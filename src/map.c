#include "main.h"
#include "noise.h"

uint16_t arr[ARR_SIZE];
uint8_t map[SCREEN_WIDTH][SCREEN_HEIGHT];
uint8_t sprites[SCREEN_WIDTH][SCREEN_HEIGHT];

static uint8_t closest(const pos_t value)
{
  if (WATER_RANGE > value)
    return WATER;
  else if (GRASS_RANGE > value)
    return GRASS;
  else if (TREES_RANGE > value)
    return TREES;
  else
    return HILLS;
}

static uint8_t generate_item(pos_t x, pos_t y)
{
  // return item at (x, y)
  const pos_t _n = prng(x, y);
  const pos_t inc = 100; // spawn items within a range of inc
  if (inc > _n)
    return WATER; // map on water
  if (WATER_RANGE + inc > _n && WATER_RANGE < _n)
    return GRASS; // gun on grass
  if (GRASS_RANGE + inc > _n && GRASS_RANGE < _n)
    return TREES; // sword in trees
  if (TREES_RANGE + inc > _n && TREES_RANGE < _n)
    return HILLS; // gold on hills
  else
    return 255; // no item
}

static inline uint8_t terrain(pos_t x, pos_t y)
{
  // return type of terrain at (x, y)
  const pos_t value = interpolate_noise(x, y);
  return closest(value);
}

uint8_t get_terrain(const int8_t direction)
{
  // n - none, r - right, l - left, u - up, d - down
  switch (direction)
  {
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

static uint8_t generate_sprite(pos_t x, pos_t y)
{
  // return sprite at (x, y)
  const pos_t _n = prng(x, y);
  return 255;
}

static inline bool is_removed(pos_t x, pos_t y)
{
  // returns true if item has been picked up at (x, y)
  // force uint8_t because of ARR_SIZE
  return arr[(uint8_t)x] == (uint8_t)y;
}

void remove_item(pos_t x, pos_t y)
{
  // item has been picked up at (x, y)
  arr[(uint8_t)x] = (uint8_t)y;
}

static inline void shift_array_right()
{
  for (uint8_t x = SCREEN_WIDTH - 1; x > 0; x--)
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      map[x][y] = map[x - 1][y];
      sprites[x][y] = sprites[x - 1][y];
    }
}

static inline void shift_array_left()
{
  for (uint8_t x = 0; x < SCREEN_WIDTH - 1; x++)
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      map[x][y] = map[x + 1][y];
      sprites[x][y] = map[x + 1][y];
    }
}

static inline void shift_array_up()
{
  for (uint8_t y = 0; y < SCREEN_HEIGHT - 1; y++)
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    {
      map[x][y] = map[x][y + 1];
      sprites[x][y] = sprites[x][y + 1];
    }
}

static inline void shift_array_down()
{
  for (uint8_t y = SCREEN_HEIGHT - 1; y > 0; y--)
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    {
      map[x][y] = map[x][y - 1];
      sprites[x][y] = sprites[x][y - 1];
    }
}

static void generate_side(const int8_t side)
{
  // r - right, l - left, t - top, b - bottom
  pos_t _x;
  pos_t _y;
  switch (side)
  {
  case 'r':
    for (uint8_t y = 0; y < SCREEN_HEIGHT; y++)
    {
      // _x and _y came from some logic and a lot of trial and error...
      _x = p.x[0] + SCREEN_WIDTH - CENTER_X;
      // use old y since generating r/l (no y change yet)
      _y = p.y[1] + y - CENTER_Y - 2;
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
      _x = p.x[0] - CENTER_X + 1;
      _y = p.y[1] + y - CENTER_Y - 2;
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
      _x = p.x[0] + x - CENTER_X + 1;
      _y = p.y[0] - CENTER_Y - 2;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][0] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
    }
    break;
  case 'b':
    for (uint8_t x = 0; x < SCREEN_WIDTH; x++)
    {
      _x = p.x[0] + x - CENTER_X + 1;
      _y = p.y[0] + SCREEN_HEIGHT - CENTER_Y - 3;
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
      const pos_t _x = p.x[0] + x - CENTER_X + 1;
      const pos_t _y = p.y[0] + y - CENTER_Y - 2;
      const uint8_t _t = terrain(_x, _y);
      const uint8_t _i = generate_item(_x, _y);
      map[x][y] =
          (_i == _t && !is_removed(_x, _y)) ? _i + BACKGROUND_COUNT : _t;
      const uint8_t _s = generate_sprite(_x, _y);
      sprites[x][y] =
          (_s == _t) ? _s : 255;
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
      // sets a 16x16 metatile
      set_bkg_tile_xy(2 * x, 2 * y, map[x][y]);
      set_bkg_tile_xy(2 * x, 2 * y + 1, map[x][y] + 1);
      set_bkg_tile_xy(2 * x + 1, 2 * y, map[x][y] + 2);
      set_bkg_tile_xy(2 * x + 1, 2 * y + 1, map[x][y] + 3);
    }
  }
  wait_vbl_done(); // wait due to recursion
}
