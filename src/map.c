#include "main.h"
#include "noise.h"

uint8_t used_index;
uint16_t used[256];

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
  for (uint8_t i = 0; i < 255; i++) {
    const uint8_t used_x = used[i] >> 8;     // high byte
    const uint8_t used_y = used[i] & 0x00ff; // low byte
    if (used_x == x && used_y == y)
      return true;
  }
  return false;
}

void remove_item(const uint8_t x, const uint8_t y) {
  // item has been picked up at (x, y)
  // store x in high byte and y in low byte
  used[used_index] = ((uint16_t)x << 8) | y;
  used_index++;
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
