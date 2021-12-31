#include "main.h"
#include <gb/gb.h>
#include <rand.h>

inline UINT8 noise(UINT8 x, UINT8 y) {
  // return random number [76, 172]
  x ^= (x << 7);
  x ^= (x >> 5);
  y ^= (y << 7);
  y ^= (y >> 5);
  return x + y * SEED;
}

inline UINT8 smooth_noise(UINT8 x, UINT8 y) {
  // gets average noise at (x, y)
  const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
                         noise(x - 1, y + 1) + noise(x + 1, y + 1)) >>
                        4; // divide by 16
  const UINT8 sides =
      (noise(x - 1, y) + noise(x + 1, y) + noise(x, y - 1) + noise(x, y + 1)) >>
      3;                                 // divide by 8
  const UINT8 center = noise(x, y) >> 2; // divide by 4
  return corners + sides + center;       // average noise at center
}

inline UINT8 interpolate(UINT8 v1, UINT8 v2) {
  // linear interpolation is avg of v1 and v2
  return (v1 + v2) >> 1; // divide by 2
}

inline UINT8 interpolate_noise(UINT8 x, UINT8 y) {
  // gets expected noise
  UINT8 v1 = smooth_noise(x, y);
  UINT8 v2 = smooth_noise(x + 1, y);
  const UINT8 i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1);
  v2 = smooth_noise(x + 1, y + 1);
  const UINT8 i2 = interpolate(v1, v2);
  return interpolate(i1, i2); // average of smoothed sides
}

inline unsigned char closest(UINT8 value) {
  // 80 <= value <= 170
  if (value < 100)
    return 0x01; // water
  else if (value < 130)
    return 0x00; // grass
  else if (value < 150)
    return 0x02; // trees
  else
    return 0x03; // mountains
}

inline unsigned char terrain(UINT8 x, UINT8 y) {
  // return type of terrain at (x, y)
  // increasing scale increases the map size
  const UINT8 value = interpolate_noise(x / scale, y / scale);
  return closest(value);
}

void shift_array_left(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int x = 0; x < pixel_x - 1; x++)
    for (int y = 0; y < pixel_y; y++)
      map[x][y] = map[x + 1][y];
}

void shift_array_right(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int x = pixel_x - 1; x > 0; x--)
    for (int y = 0; y < pixel_y; y++)
      map[x][y] = map[x - 1][y];
}

void shift_array_up(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int y = 0; y < pixel_y - 1; y++)
    for (int x = 0; x < pixel_x; x++)
      map[x][y] = map[x][y + 1];
}

void shift_array_down(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int y = pixel_y - 1; y > 0; y--)
    for (int x = 0; x < pixel_x; x++)
      map[x][y] = map[x][y - 1];
}

void generate_side(const char side, const UINT8 pixel_x, const UINT8 pixel_y) {
  // t - top, r - right, b - bottom, l - left
  switch (side) {
  case 't':
    for (int x = 0; x < pixel_x; x++)
      map[x][0] = terrain(x + p.x[0], p.y[0]);
    break;
  case 'r':
    for (int y = 0; y < pixel_y; y++)
      map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
    break;
  case 'b':
    for (int x = 0; x < pixel_x; x++)
      map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
    break;
  case 'l':
    for (int y = 0; y < pixel_y; y++)
      map[0][y] = terrain(p.x[0], y + p.y[0]);
    break;
  }
}

void generate_map() {
  const UINT8 pixel_x = screen_x / sprite_size;
  const UINT8 pixel_y = screen_y / sprite_size;
  const INT8 diff_x = p.x[1] - p.x[0];
  const INT8 diff_y = p.y[1] - p.y[0];
  if (p.steps > 0) {
    if (diff_x < 0) {
      // moved right
      shift_array_left(pixel_x, pixel_y);
      generate_side('r', pixel_x, pixel_y);
    } else if (diff_x > 0) {
      // moved left
      shift_array_right(pixel_x, pixel_y);
      generate_side('l', pixel_x, pixel_y);
    }
    if (diff_y < 0) {
      // moved down
      shift_array_up(pixel_x, pixel_y);
      generate_side('b', pixel_x, pixel_y);
    } else if (diff_y > 0) {
      // moved up
      shift_array_down(pixel_x, pixel_y);
      generate_side('t', pixel_x, pixel_y);
    }
    // makes difference 0 so next step has difference of 1
    p.x[1] = p.x[0];
    p.y[1] = p.y[0];
  } else {
    // on first load, generate entire map
    for (UINT8 x = 0; x < pixel_x; x++)
      for (UINT8 y = 0; y < pixel_y; y++)
        map[x][y] = terrain(x + p.x[0], y + p.y[0]);
  }
}

void display_map() {
  for (UINT8 i = 0; i < 20; i++)
    set_bkg_tiles(i, 0, 1, 18, map[i]);
}

void update_position() {
  bool update = false;
  UINT8 _x = p.x[0];
  UINT8 _y = p.y[0];
  if (joypad() & J_RIGHT)
    _x++;
  else if (joypad() & J_LEFT)
    _x--;
  if (joypad() & J_UP)
    _y--;
  else if (joypad() & J_DOWN)
    _y++;
  if (_x != p.x[0]) {
    p.x[1] = p.x[0];
    p.x[0] = _x;
    p.steps++;
    update = true;
  } else if (_y != p.y[0]) {
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
    update = true;
  }
  if (update == true) {
    generate_map();
    display_map();
  }
}

void show_menu() {
  HIDE_SPRITES;
  const UINT8 x = p.x[0] - start_position;
  const UINT8 y = p.y[0] - start_position;
  printf("\n\tgold:\t%u", p.gold);
  printf("\n\tmaps:\t%u", p.maps);
  printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\n\tposition:\t(%u, %u)", x, y);
  printf("\n\tsteps:\t%u", p.steps);
  printf("\n\tseed:\t%u", SEED);

  printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
}
