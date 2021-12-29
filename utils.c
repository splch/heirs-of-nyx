#include "main.h"
#include <gb/gb.h>
#include <rand.h>

void update_position() {
  UINT8 _x = p.x[0];
  UINT8 _y = p.y[0];
  if (joypad() & J_UP)
    _y--;
  if (joypad() & J_DOWN)
    _y++;
  if (joypad() & J_LEFT)
    _x--;
  if (joypad() & J_RIGHT)
    _x++;
  if (_x != p.x[0]) {
    p.x[1] = p.x[0];
    p.x[0] = _x;
    p.steps++;
  }
  if (_y != p.y[0]) {
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
  }
}

UINT8 noise(UINT8 x, UINT8 y) {
  // return random number [0, 0xffffffff]
  initrand(x + y * SEED);
  return rand();
  // UINT8 n = x + y * SEED;
  // n = (n << 13) ^ n;
  // return ((n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff);
}

UINT8 smooth_noise(UINT8 x, UINT8 y) {
  // gets average noise at (x, y)
  const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
                         noise(x - 1, y + 1) + noise(x + 1, y + 1)) >>
                        4; // divide by 16
  const UINT8 sides =
      (noise(x - 1, y) + noise(x + 1, y) + noise(x, y - 1) + noise(x, y + 1)) >>
      3;                                 // divide by 8
  const UINT8 center = noise(x, y) >> 2; // divide by 4
  return corners + sides + center;
}

UINT8 interpolate(UINT8 v1, UINT8 v2) {
  // linear interpolate
  return (v1 + v2) >> 1; // divide by 2
  // cosine interpolate
  // auto f = (1 - fcos(x * 3.14159265358979323846)) * .5;
  // return v1 * (1 - f) + v2 * f;
}

UINT8 interpolate_noise(UINT8 x, UINT8 y) {

  // gets expected noise
  UINT8 v1 = smooth_noise(x, y);
  UINT8 v2 = smooth_noise(x + 1, y);
  const UINT8 i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1);
  v2 = smooth_noise(x + 1, y + 1);
  const UINT8 i2 = interpolate(v1, v2);
  return interpolate(i1, i2);
}

// TODO: fix generator
unsigned char closest(UINT8 value) {
  if (value < 110)
    return 0; // water
  else if (value < 150)
    return 1; // grass
  else if (value < 160)
    return 2; // trees
  else
    return 3; // mountains
}

unsigned char terrain(UINT8 x, UINT8 y) {
  // return type of terrain at (x, y)
  const UINT8 scale = 2;
  const UINT8 value = interpolate_noise(x / scale, y / scale);
  return closest(value);
}

void shift_left(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int x = 0; x < pixel_x - 1; x++)
    for (int y = 0; y < pixel_y; y++)
      map[x][y] = map[x + 1][y];
}

void shift_right(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int x = pixel_x - 1; x > 0; x--)
    for (int y = 0; y < pixel_y; y++)
      map[x][y] = map[x - 1][y];
}

void shift_up(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int y = 0; y < pixel_y - 1; y++)
    for (int x = 0; x < pixel_x; x++)
      map[x][y] = map[x][y + 1];
}

void shift_down(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int y = pixel_y - 1; y > 0; y--)
    for (int x = 0; x < pixel_x; x++)
      map[x][y] = map[x][y - 1];
}

void generate_border(const UINT8 pixel_x, const UINT8 pixel_y) {
  for (int y = 0; y < pixel_y; y++) {
    // generate left and right edges of terrain
    map[0][y] = terrain(p.x[0], y + p.y[0]);
    map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
  }
  for (int x = 0; x < pixel_x; x++) {
    // generate top and bottom edges of terrain
    map[x][0] = terrain(x + p.x[0], p.y[0]);
    map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
  }
}

void generate_map() {
  const UINT8 pixel_x = screen_x / sprite_size;
  const UINT8 pixel_y = screen_y / sprite_size;
  const int8_t diff_x = p.x[1] - p.x[0];
  const int8_t diff_y = p.y[1] - p.y[0];
  if (p.steps > 0) {
    if (diff_x < 0) {
      // moved right
      shift_left(pixel_x, pixel_y);
    } else if (diff_x > 0) {
      // moved left
      shift_right(pixel_x, pixel_y);
    }
    if (diff_y < 0) {
      // moved down
      shift_up(pixel_x, pixel_y);

    } else if (diff_y > 0) {
      // moved up
      shift_down(pixel_x, pixel_y);
    }
    generate_border(pixel_x, pixel_y);
    p.x[1] = p.x[0];
    p.y[1] = p.y[0];
  } else
    for (int x = 0; x < pixel_x; x++)
      for (int y = 0; y < pixel_y; y++) {
        map[x][y] = terrain(x + p.x[0], y + p.y[0]);
      }
}

void load_map() {
  for (UINT8 i = 0; i < 20; i++)
    set_bkg_tiles(i, 0, 20, 18, map[i]);
}
