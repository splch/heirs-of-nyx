#include "main.h"

// necessary for recursion
void update_position(const unsigned char);

// used[used_index][x,y]
unsigned char used[255][2];
unsigned char used_index = 0;

inline unsigned char noise(unsigned char x, unsigned char y) {
  // return random number [49, 201]
  // prng comes from a combination of perlin noise and 8-bit xorshift
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

inline unsigned char closest(const unsigned char value) {
  // 49 <= value <= 201
  if (value < 100)
    return 1 + FONT_MEMORY; // water
  else if (value < 135)
    return 0 + FONT_MEMORY; // grass
  else if (value < 160)
    return 2 + FONT_MEMORY; // trees
  else
    return 3 + FONT_MEMORY; // mountains
}

unsigned char terrain(unsigned char x, unsigned char y) {
  // return type of terrain at (x, y)
  // increasing scale increases the map size
  const unsigned char value = interpolate_noise(x / SCALE, y / SCALE);
  return closest(value);
}

unsigned char generate_item(unsigned char x, unsigned char y) {
  // return item at (x, y)
  // 49 <= noise(x, y) <= 201
  const unsigned char _n = noise(x, y);
  if (_n > 49 && _n < 51)
    return 1 + FONT_MEMORY; // map on water
  else if (_n > 133 && _n < 135)
    return 0 + FONT_MEMORY; // gun on grass
  else if (_n > 158 && _n < 160)
    return 2 + FONT_MEMORY; // sword in trees
  else if (_n > 190 && _n < 201)
    return 3 + FONT_MEMORY; // gold on mountains
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
      // _x and _y came from some logic and a lot of trial and error...
      _x = DEVICE_SCREEN_WIDTH - CENTER_X + p.x[0] - 1;
      // use old y since generating r/l (no y change yet)
      _y = y + p.y[1] - CENTER_Y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      // set either a terrain tile or item tile
      // terrain associated item tiles are stored at terrain + BACKGROUND_COUNT
      map[DEVICE_SCREEN_WIDTH - 1][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'l':
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      _x = p.x[0] - CENTER_X;
      _y = y + p.y[1] - CENTER_Y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[0][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 't':
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      // use current x since r/l might have already been updated
      _x = x + p.x[0] - CENTER_X;
      _y = p.y[0] - CENTER_Y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][0] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'b':
    for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      _x = x + p.x[0] - CENTER_X;
      _y = DEVICE_SCREEN_HEIGHT - CENTER_Y + p.y[0] - 1;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][DEVICE_SCREEN_HEIGHT - 1] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  }
}

void generate_map() {
  // generate entire map on first load
  for (unsigned char x = 0; x < DEVICE_SCREEN_WIDTH; x++)
    for (unsigned char y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      const unsigned char _x = x + p.x[0] - CENTER_X;
      const unsigned char _y = y + p.y[0] - CENTER_Y;
      const unsigned char _t = terrain(_x, _y);
      const unsigned char _i = generate_item(_x, _y);
      map[x][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
}

void generate_map_sides() {
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
  const unsigned char x = p.x[0] - START_POSITION;
  const unsigned char y = p.y[0] - START_POSITION;
  printf("\ngold:\t%u", p.gold);
  printf("\nmaps:\t%u", p.maps);
  printf("\nweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\nposition:\t(%u, %u)", x, y);
  printf("\nsteps:\t%u", p.steps);
  printf("\nseed:\t%u", SEED);

  printf("\n\nrandom:\t%u", noise(p.x[0], p.y[0]));

  printf("\n\npress start to exit");
  waitpad(J_START);
}

void remove_item(const unsigned char x, const unsigned char y) {
  // item has been picked up at (x, y)
  used[used_index][0] = x;
  used[used_index][1] = y;
  used_index++;
}

void add_inventory(unsigned char item) {
  // fill primary or replace secondary
  item -= BACKGROUND_COUNT;
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
  // switch primary with secondary weapons
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
      const unsigned char pos_x = x + CENTER_X;
      const unsigned char pos_y = y + CENTER_Y;
      const unsigned char item = map[pos_x][pos_y];
      if (item >= FONT_MEMORY + BACKGROUND_COUNT) {
        add_inventory(item - FONT_MEMORY);
        remove_item(x + p.x[0], y + p.y[0]);
        // (item - BACKGROUND_COUNT) is the terrain tile
        map[pos_x][pos_y] = item - BACKGROUND_COUNT;
        display_map();
        return; // only pick up one item per interaction
      }
    }
}

void attack() {
  switch (p.weapons[0]) {
  case 0:
    // printf("\nbang!\n");
    break;
  case 2:
    // printf("\nclink!\n");
    break;
  }
}

void check_interactions(const unsigned char j) {
  // delay non-movement by SENSITIVITY
  if (clock() - SENSITIVITY > delay_time) {
    if (j & J_START)
      show_menu();
    if (j & J_SELECT)
      change_item();
    if (j & J_A)
      interact();
    if (j & J_B)
      attack();
    // secret way to change the global SEED
    // if (j & J_SELECT && j & J_B) {
    //   if (j & J_RIGHT)
    //     SEED++;
    //   if (j & J_LEFT)
    //     SEED--;
    //   generate_map();
    // }
    // reset delay if input is detected
    if (j)
      delay_time = clock();
  }
}

unsigned char get_terrain(const char direction) {
  // n - none, r - right, l - left, u - up, d - down
  switch (direction) {
  // these "magic numbers" are from `interact()`
  case 'n':
    return map[CENTER_X - 1][CENTER_Y - 2] - FONT_MEMORY;
  case 'r':
    return map[CENTER_X][CENTER_Y - 2] - FONT_MEMORY;
  case 'l':
    return map[CENTER_X - 2][CENTER_Y - 2] - FONT_MEMORY;
  case 'u':
    return map[CENTER_X - 1][CENTER_Y - 3] - FONT_MEMORY;
  case 'd':
    return map[CENTER_X - 1][CENTER_Y - 1] - FONT_MEMORY;
  }
  return 255;
}

void push_player() {
  const unsigned char current_terrain = get_terrain('n');
  const unsigned char down_terrain = get_terrain('d');
  if (down_terrain == 1 || down_terrain == 1 + BACKGROUND_COUNT ||
      current_terrain == 1 || current_terrain == 1 + BACKGROUND_COUNT)
    // update_position will recursively call if the user is still on water
    // push the player right on the water (00000001)
    // push the player down the water (00001000)
    // right and down = 00001001 = 9
    update_position(9);
}

void adjust_position(const unsigned char terrain_type,
                     const unsigned char old_x, const unsigned char old_y) {
  switch (terrain_type) {
  case 0:                    // grass
  case 0 + BACKGROUND_COUNT: // item on terrain
  case 2:                    // tree
  case 2 + BACKGROUND_COUNT:
    display_map();
    break; // ignore grass and tree tiles
  case 1:  // water
  case 1 + BACKGROUND_COUNT:
    display_map();
    push_player();
    break;
  case 3: // mountain
  case 3 + BACKGROUND_COUNT:
    // revert to previous position
    p.x[0] = old_x;
    p.y[0] = old_y;
    generate_map_sides();
    display_map();
    break;
  }
}

void update_position(const unsigned char j) {
  check_interactions(joypad());
  // j = right - 1, left - 2, up - 4, down - 8
  unsigned char _x = p.x[0];
  unsigned char _y = p.y[0];
  if (j & J_RIGHT)
    _x++;
  if (j & J_LEFT)
    _x--;
  if (j & J_UP)
    _y--;
  if (j & J_DOWN)
    _y++;
  const unsigned char old_x = p.x[1];
  const unsigned char old_y = p.y[1];
  if (p.x[0] != _x) {
    p.x[1] = p.x[0];
    p.x[0] = _x;
    p.steps++;
  }
  if (p.y[0] != _y) {
    // if makes diagonal movement possible
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
  }
  generate_map_sides();
  adjust_position(get_terrain('n'), old_x, old_y);
}
