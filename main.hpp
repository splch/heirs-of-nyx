#ifndef LIBRARY_H_
#define LIBRARY_H_

#include "picosystem.hpp"
#include <map>
#include <set>
#include <cmath>

using namespace picosystem;

extern const uint32_t SEED = 57;
extern const double DROP_RATE = 0.005;
extern uint32_t start_position;
extern const int terrains[] = {WATER, GRASS, WOOD, MINE};
extern const int loot[][2] = {{SWORD_WOOD, GRASS},  {SWORD_IRON, MINE},
                              {SWORD_SILVER, WOOD}, {PISTOL, MINE},
                              {COIN_GOLDEN, MINE},  {BOOK_LARGE, GRASS}};
extern struct player {
  uint32_t x[2], y[2];
  uint32_t steps;
  int weapons[2];
  uint32_t gold;
  uint32_t maps;
} p;
extern const uint8_t sprite_size = 8;
extern const uint32_t screen_x = 120;
extern const uint32_t screen_y = 120;
extern const uint32_t center[2] = {(screen_x - sprite_size) / 2,
                                   (screen_y - sprite_size) / 2};
extern uint8_t map[screen_x / sprite_size][screen_y / sprite_size];
extern int8_t items[screen_x / sprite_size][screen_y / sprite_size];
extern std::map<uint32_t, std::set<uint32_t>> removed;

#endif
