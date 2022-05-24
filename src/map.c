#include "main.h"
#include "noise.h"

uint16_t arr_4kb[256];
uint8_t map[SCREEN_WIDTH][SCREEN_HEIGHT];

uint8_t closest(const uint8_t value)
{
  if (value < 90)
    return 4 + FONT_MEMORY; // water
  else if (value < 140)
    return 0 + FONT_MEMORY; // grass
  else if (value < 160)
    return 8 + FONT_MEMORY; // trees
  else
    return 12 + FONT_MEMORY; // mountains
}

uint8_t terrain(uint8_t x, uint8_t y)
{
  // return type of terrain at (x, y)
  // increasing scale increases the map size
  const uint8_t value = interpolate_noise(x, y);
  return closest(value);
}

uint8_t generate_item(uint8_t x, uint8_t y)
{
  // return item at (x, y)
  const uint8_t _n = prng(x, y);
  switch (_n)
  {
  case 0:
    return 4 + FONT_MEMORY; // map on water
  case 90:
    return 0 + FONT_MEMORY; // gun on grass
  case 140:
    return 8 + FONT_MEMORY; // sword in trees
  case 160:
    return 12 + FONT_MEMORY; // gold on mountains
  default:
    return 255; // no item
  }
}

bool is_removed(const uint8_t x, const uint8_t y)
{
  // returns true if item has been picked up at (x, y)
  printf("%u, %u\n", x + 1, arr_4kb[x + 1]);
  waitpad(0b11111111);
  return arr_4kb[x + 1] == y + 2;
}

void remove_item(const uint8_t x, const uint8_t y)
{
  // item has been picked up at (x, y)
  printf("%u, %u\n", x + 1, y + 2);
  delay(1000);
  waitpad(0b11111111);
  arr_4kb[x + 1] = y + 2;
}

void shift_array_right()
{
  for (uint8_t x = SCREEN_WIDTH - 1; x > 0; x--)
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
      map[x][y] = map[x - 1][y];
}

void shift_array_left()
{
  for (uint8_t x = 0; x < SCREEN_WIDTH - 1; x++)
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
      map[x][y] = map[x + 1][y];
}

void shift_array_up()
{
  for (uint8_t y = 0; y < SCREEN_HEIGHT - 1; y++)
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
      map[x][y] = map[x][y + 1];
}

void shift_array_down()
{
  for (uint8_t y = SCREEN_HEIGHT - 1; y > 0; y--)
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
      map[x][y] = map[x][y - 1];
}

void generate_side(const int8_t side)
{
  // r - right, l - left, t - top, b - bottom
  uint8_t _x;
  uint8_t _y;
  switch (side)
  {
  case 'r':
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      // _x and _y came from some logic and a lot of trial and error...
      _x = SCREEN_WIDTH - CENTER_X + p.x[0] - 1;
      // use old y since generating r/l (no y change yet)
      _y = y + p.y[1] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      // set either a terrain tile or item tile
      // terrain associated item tiles are stored at terrain + BACKGROUND_COUNT
      map[SCREEN_WIDTH - 1][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'l':
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      _x = p.x[0] - CENTER_X;
      _y = y + p.y[1] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[0][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 't':
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    {
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
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    {
      _x = x + p.x[0] - CENTER_X;
      _y = SCREEN_HEIGHT - CENTER_Y + p.y[0] - 1;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][SCREEN_HEIGHT - 1] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  }
}

void generate_map()
{
  // generate entire map on first load
  for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      const uint8_t _x = x + p.x[0] - CENTER_X;
      const uint8_t _y = y + p.y[0] - CENTER_Y;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
}

void generate_map_sides()
{
  const int8_t diff_x = p.x[1] - p.x[0];
  const int8_t diff_y = p.y[1] - p.y[0];
  if (diff_x < 0)
  {
    // moved right
    shift_array_left();
    generate_side('r');
  }
  else if (diff_x > 0)
  {
    // moved left
    shift_array_right();
    generate_side('l');
  }
  if (diff_y > 0)
  {
    // moved up
    shift_array_down();
    generate_side('t');
  }
  else if (diff_y < 0)
  {
    // moved down
    shift_array_up();
    generate_side('b');
  }
  // makes difference 0 so next step has difference of 1
  p.x[1] = p.x[0];
  p.y[1] = p.y[0];
}

void display_map()
{
  for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
  {
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      set_bkg_tile_xy(2 * x, 2 * y, map[x][y]);
      set_bkg_tile_xy(2 * x, 2 * y + 1, map[x][y] + 1);
      set_bkg_tile_xy(2 * x + 1, 2 * y, map[x][y] + 2);
      set_bkg_tile_xy(2 * x + 1, 2 * y + 1, map[x][y] + 3);
    }
  }

  wait_vbl_done(); // wait due to recursion
}
