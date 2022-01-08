#include "main.h"

// necessary for recursion
void update_position(const uint8_t);

// used[used_index][x,y]
uint8_t used[255][2];
uint8_t used_index = 0;

inline uint8_t noise(uint8_t x, uint8_t y) {
  // return random number [49, 201]
  // prng comes from a combination of perlin noise and 8-bit xorshift
  x ^= (y << 7);
  x ^= (x >> 5);
  y ^= (x << 3);
  y ^= (y >> 1);
  return x ^ y * SEED;
}

inline uint8_t smooth_noise(uint8_t x, uint8_t y) {
  // gets average noise at (x, y)
  const uint8_t corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
                           noise(x - 1, y + 1) + noise(x + 1, y + 1)) >>
                          4; // divide by 16
  const uint8_t sides =
      (noise(x - 1, y) + noise(x + 1, y) + noise(x, y - 1) + noise(x, y + 1)) >>
      3;                                   // divide by 8
  const uint8_t center = noise(x, y) >> 2; // divide by 4
  return corners + sides + center;         // average noise at center
}

inline uint8_t interpolate(uint8_t v1, uint8_t v2) {
  // linear interpolation is avg of v1 and v2
  return (v1 + v2) >> 1; // divide by 2
}

uint8_t interpolate_noise(uint8_t x, uint8_t y) {
  // gets expected noise
  uint8_t v1 = smooth_noise(x, y);
  uint8_t v2 = smooth_noise(x + 1, y);
  const uint8_t i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1);
  v2 = smooth_noise(x + 1, y + 1);
  const uint8_t i2 = interpolate(v1, v2);
  return interpolate(i1, i2); // average of smoothed sides
}

uint8_t closest(const uint8_t value) {
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

uint8_t terrain(uint8_t x, uint8_t y) {
  // return type of terrain at (x, y)
  // increasing scale increases the map size
  const uint8_t value = interpolate_noise(x / SCALE, y / SCALE);
  return closest(value);
}

uint8_t generate_item(uint8_t x, uint8_t y) {
  // return item at (x, y)
  // 49 <= noise(x, y) <= 201
  const uint8_t _n = noise(x, y);
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

bool is_removed(const uint8_t x, const uint8_t y) {
  // returns true if item has been picked up at (x, y)
  for (uint8_t i = 0; i < 255; i++)
    if (used[i][0] == x && used[i][1] == y)
      return true;
  return false;
}

void shift_array_right() {
  for (uint8_t x = DEVICE_SCREEN_WIDTH - 1; x > 0; x--)
    for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT; y++)
      map[x][y] = map[x - 1][y];
}

void shift_array_left() {
  for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH - 1; x++)
    for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT; y++)
      map[x][y] = map[x + 1][y];
}

void shift_array_up() {
  for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT - 1; y++)
    for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH; x++)
      map[x][y] = map[x][y + 1];
}

void shift_array_down() {
  for (uint8_t y = DEVICE_SCREEN_HEIGHT - 1; y > 0; y--)
    for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH; x++)
      map[x][y] = map[x][y - 1];
}

void generate_side(const int8_t side) {
  // r - right, l - left, t - top, b - bottom
  uint8_t _x;
  uint8_t _y;
  switch (side) {
  case 'r':
    for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      // _x and _y came from some logic and a lot of trial and error...
      _x = DEVICE_SCREEN_WIDTH - CENTER_X + p.x[0] - 1;
      // use old y since generating r/l (no y change yet)
      _y = y + p.y[1] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      // set either a terrain tile or item tile
      // terrain associated item tiles are stored at terrain + BACKGROUND_COUNT
      map[DEVICE_SCREEN_WIDTH - 1][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'l':
    for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      _x = p.x[0] - CENTER_X;
      _y = y + p.y[1] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[0][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 't':
    for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      // use current x since r/l might have already been updated
      _x = x + p.x[0] - CENTER_X;
      _y = p.y[0] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][0] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'b':
    for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH; x++) {
      _x = x + p.x[0] - CENTER_X;
      _y = DEVICE_SCREEN_HEIGHT - CENTER_Y + p.y[0] - 1;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][DEVICE_SCREEN_HEIGHT - 1] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  }
}

void generate_map() {
  // generate entire map on first load
  for (uint8_t x = 0; x < DEVICE_SCREEN_WIDTH; x++)
    for (uint8_t y = 0; y < DEVICE_SCREEN_HEIGHT; y++) {
      const uint8_t _x = x + p.x[0] - CENTER_X;
      const uint8_t _y = y + p.y[0] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
}

void generate_map_sides() {
  const int8_t diff_x = p.x[1] - p.x[0];
  const int8_t diff_y = p.y[1] - p.y[0];
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
  for (uint8_t i = 0; i < DEVICE_SCREEN_WIDTH; i++)
    set_bkg_tiles(i, 0, 1, DEVICE_SCREEN_HEIGHT, map[i]);
  SHOW_SPRITES; // menu is closed
}

void show_menu() {
  // display map to erase previous menus
  display_map();
  HIDE_SPRITES; // menu is open
  const uint8_t x = p.x[0] - START_POSITION;
  const uint8_t y = p.y[0] - START_POSITION;
  printf("\ngold:\t%u", p.gold);
  printf("\nmaps:\t%u", p.maps);
  printf("\nweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\nposition:\t(%u, %u)", x, y);
  printf("\nsteps:\t%u", p.steps);
  printf("\nseed:\t%u", SEED);

  printf("\n\nrandom:\t%u", noise(p.x[0], p.y[0]));

  printf("\n\npress start to exit");
  waitpad(J_START);
  display_map();
}

void remove_item(const uint8_t x, const uint8_t y) {
  // item has been picked up at (x, y)
  used[used_index][0] = x;
  used[used_index][1] = y;
  used_index++;
}

void add_inventory(uint8_t item) {
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
  const int8_t _w = p.weapons[0];
  p.weapons[0] = p.weapons[1];
  p.weapons[1] = _w;
}

void interact() {
  // -1 <= x - 1 <= 1
  // -1 <= y - 2 <= 1
  // -1 and -2 are "magic numbers"
  // these loops form a square of interaction around the player
  for (int8_t x = -2; x <= 0; x++)
    for (int8_t y = -3; y <= -1; y++) {
      const uint8_t pos_x = x + CENTER_X;
      const uint8_t pos_y = y + CENTER_Y;
      const uint8_t item = map[pos_x][pos_y];
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

void check_interactions(const uint8_t j) {
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
    // reset delay if input is detected
    if (j)
      delay_time = clock();
  }
}

uint8_t get_terrain(const int8_t direction) {
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
  const uint8_t current_terrain = get_terrain('n');
  const uint8_t down_terrain = get_terrain('d');
  if (down_terrain == 1 || down_terrain == 1 + BACKGROUND_COUNT ||
      current_terrain == 1 || current_terrain == 1 + BACKGROUND_COUNT)
    // update_position will recursively call if the user is still on water
    // push the player right on the water (00000001)
    // push the player down the water (00001000)
    // right and down = 00001001 = 9
    update_position(9);
}

void adjust_position(const uint8_t terrain_type, const uint8_t old_x,
                     const uint8_t old_y) {
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
    p.steps--;
    generate_map_sides();
    display_map();
    break;
  }
}

void update_position(const uint8_t j) {
  check_interactions(joypad());
  // j = right - 1, left - 2, up - 4, down - 8
  uint8_t _x = p.x[0];
  uint8_t _y = p.y[0];
  if (j & J_RIGHT)
    _x++;
  if (j & J_LEFT)
    _x--;
  if (j & J_UP)
    _y--;
  if (j & J_DOWN)
    _y++;
  if (p.x[0] != _x || p.y[0] != _y) {
    const uint8_t old_x = p.x[1];
    const uint8_t old_y = p.y[1];
    p.x[1] = p.x[0];
    p.x[0] = _x;
    // makes diagonal movement possible
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
    generate_map_sides();
    adjust_position(get_terrain('n'), old_x, old_y);
  }
}
