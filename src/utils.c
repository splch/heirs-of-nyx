#include "main.h"

// used[used_index][x,y]
unsigned char used[255][2];
unsigned char used_index = 0;

inline unsigned char noise(unsigned char x, unsigned char y) {
  // return random number [49, 201]
  x ^= (y << 7);
  x ^= (x >> 5);
  y ^= (x << 3);
  y ^= (y >> 1);
  return x ^ y * SEED;
}

inline unsigned char smooth_noise(unsigned char x, unsigned char y) {
  // gets average noise at (x, y)
  const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
                                 noise(x - 1, y + 1) + noise(x + 1, y + 1)) >>
                                4; // divide by 16
  const unsigned char sides =
      (noise(x - 1, y) + noise(x + 1, y) + noise(x, y - 1) + noise(x, y + 1)) >>
      3;                                         // divide by 8
  const unsigned char center = noise(x, y) >> 2; // divide by 4
  return corners + sides + center;               // average noise at center
}

inline unsigned char interpolate(unsigned char v1, unsigned char v2) {
  // linear interpolation is avg of v1 and v2
  return (v1 + v2) >> 1; // divide by 2
}

inline unsigned char interpolate_noise(unsigned char x, unsigned char y) {
  // gets expected noise
  unsigned char v1 = smooth_noise(x, y);
  unsigned char v2 = smooth_noise(x + 1, y);
  const unsigned char i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1);
  v2 = smooth_noise(x + 1, y + 1);
  const unsigned char i2 = interpolate(v1, v2);
  return interpolate(i1, i2); // average of smoothed sides
}

inline unsigned char closest(unsigned char value) {
  // 49 <= value <= 201
  if (value < 100)
    return 1; // water
  else if (value < 135)
    return 0; // grass
  else if (value < 160)
    return 2; // trees
  else
    return 3; // mountains
}

unsigned char terrain(unsigned char x, unsigned char y) {
  // return type of terrain at (x, y)
  // increasing scale increases the map size
  const unsigned char value = interpolate_noise(x / scale, y / scale);
  return closest(value);
}

unsigned char generate_item(unsigned char x, unsigned char y) {
  // return item at (x, y)
  // 49 <= noise(x, y) <= 201
  const unsigned char _n = noise(x, y);
  if (_n > 49 && _n < 51)
    return 1; // map on water
  else if (_n > 133 && _n < 135)
    return 0; // gun on grass
  else if (_n > 158 && _n < 160)
    return 2; // sword in trees
  else if (_n > 190 && _n < 201)
    return 3; // gold on mountains
  else
    return 255; // no item
}

bool is_removed(const unsigned char x, const unsigned char y) {
  // returns true if item has been picked up at (x, y)
  for (unsigned char i = 0; i < 255; i++)
    if (used[i][0] == x && used[i][1] == y)
      return true;
  return false;
}

void shift_array_right() {
  for (unsigned char x = DEVICE_SCREEN_WIDTH - 1; x > 0; x--)
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++)
      map[x][y] = map[x - 1][y];
}

void shift_array_left() {
  for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH - 1; x++)
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++)
      map[x][y] = map[x + 1][y];
}

void shift_array_up() {
  for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT - 1; y++)
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++)
      map[x][y] = map[x][y + 1];
}

void shift_array_down() {
  for (unsigned char y = DEVICE_SCREEN_HEIGHT - 1; y > 0; y--)
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++)
      map[x][y] = map[x][y - 1];
}

void generate_side(const char side) {
  // r - right, l - left, t - top, b - bottom
  unsigned char _x;
  unsigned char _y;
  switch (side) {
  case 'r':
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      _x = DEVICE_SCREEN_WIDTH - 1 + p.x[0] - gen_x;
      _y = y + p.y[0] - gen_y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[DEVICE_SCREEN_WIDTH - 1][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
    }
    break;
  case 'l':
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      _x = p.x[0] - gen_x;
      _y = y + p.y[0] - gen_y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[0][y] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
    }
    break;
  case 't':
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      _x = x + p.x[0] - gen_x;
      _y = p.y[0] - gen_y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][0] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
    }
    break;
  case 'b':
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      _x = x + p.x[0] - gen_x;
      _y = DEVICE_SCREEN_HEIGHT - 1 + p.y[0] - gen_y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][DEVICE_SCREEN_HEIGHT - 1] =
          (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
    }
    break;
  }
}

void generate_map() {
  // generate entire map on first load
  for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++)
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      const unsigned char _x = x + p.x[0] - gen_x;
      const unsigned char _y = y + p.y[0] - gen_y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][y] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
    }
}

void generate_map_side() {
  const char diff_x = p.x[1] - p.x[0];
  const char diff_y = p.y[1] - p.y[0];
  if (diff_x < 0) {
    // moved right
    shift_array_left();
    generate_side('r');
  } else if (diff_x > 0) {
    // moved left
    shift_array_right();
    generate_side('l');
  }
  if (diff_y > 0) {
    // moved up
    shift_array_down();
    generate_side('t');
  } else if (diff_y < 0) {
    // moved down
    shift_array_up();
    generate_side('b');
  }
  // makes difference 0 so next step has difference of 1
  p.x[1] = p.x[0];
  p.y[1] = p.y[0];
}

void display_map() {
  for (unsigned char i = 0; i < DEVICE_SCREEN_WIDTH; i++)
    set_bkg_tiles(i, 0, 1, DEVICE_SCREEN_HEIGHT, map[i]);
  SHOW_SPRITES; // menu is closed
}

void show_menu() {
  // display map to erase previous menus
  display_map();
  HIDE_SPRITES; // menu is open
  const unsigned char x = p.x[0] - start_position;
  const unsigned char y = p.y[0] - start_position;
  printf("\n\tgold:\t%u", p.gold);
  printf("\n\tmaps:\t%u", p.maps);
  printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\n\tposition:\t(%u, %u)", x, y);
  printf("\n\tsteps:\t%u", p.steps);
  printf("\n\tseed:\t%u", SEED);

  printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
}

void remove_item(const unsigned char x, unsigned char y) {
  // item has been picked up at (x, y)
  used[used_index][0] = x;
  used[used_index][1] = y;
  used_index++;
}

void add_inventory(unsigned char item) {
  // fill primary or replace secondary
  item -= backgrounds;
  switch (item) {
  case 0:
  case 2:
    if (p.weapons[0] == -1) {
      p.weapons[0] = item;
    } else {
      p.weapons[1] = item;
    }
    break;
  case 1:
    p.maps++;
    break;
  case 3:
    p.gold++;
    break;
  }
}

void change_item() {
  const char _w = p.weapons[0];
  p.weapons[0] = p.weapons[1];
  p.weapons[1] = _w;
}

void interact() {
  // -1 <= x - 1 <= 1
  // -1 <= y - 2 <= 1
  // -1 and -2 are "magic numbers"
  // these loops form a square of interaction around the player
  for (char x = -2; x <= 0; x++)
    for (char y = -3; y <= -1; y++) {
      const unsigned char pos_x = x + center_x / sprite_size;
      const unsigned char pos_y = y + center_y / sprite_size;
      const unsigned char item = map[pos_x][pos_y];
      if (item >= backgrounds) {
        add_inventory(item);
        remove_item(x + p.x[0], y + p.y[0]);
        // (item - backgrounds) is the terrain tile
        map[pos_x][pos_y] = item - backgrounds;
        display_map();
      }
    }
}

void attack() {
  switch (p.weapons[0]) {
  case 0:
    printf("\nbang!\n");
    break;
  case 2:
    printf("\nclink!\n");
    break;
  }
}

void update_position(unsigned char j) {
  bool update = false;
  unsigned char _x = p.x[0];
  unsigned char _y = p.y[0];
  if (j & J_RIGHT)
    _x++;
  else if (j & J_LEFT)
    _x--;
  if (j & J_UP)
    _y--;
  else if (j & J_DOWN)
    _y++;
  if (_x != p.x[0]) {
    p.x[1] = p.x[0];
    p.x[0] = _x;
    p.steps++;
    update = true;
  } else if (_y != p.y[0]) {
    // else if so diagonal movement isn't possible
    // y is second to prioritize right and left movement
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
    update = true;
  }
  if (update) {
    generate_map_side();
    display_map();
  }
}
