#ifndef MAIN_H_INCLUDE
#define MAIN_H_INCLUDE

#include <gbdk/platform.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

// --- CONFIG --- //
#define SENSITIVITY 0 // CLOCKS_PER_SEC * t(s), so this is 60 * .1(s) = 6

// map data type
#define pos_t uint16_t // sets type for map generation
#define MAX 65535      // match with pos_t

#define START_POSITION MAX / 2

// terrain ratios
#define WATER_RANGE MAX / 13
#define GRASS_RANGE MAX / 4
#define TREES_RANGE MAX / 3
#define HILLS_RANGE MAX
// -------------- //

// --- GB VALUES --- //
#define FONT_MEMORY 102 // prevents writing over font memory
#define WATER 4 + FONT_MEMORY
#define GRASS 0 + FONT_MEMORY
#define TREES 8 + FONT_MEMORY
#define HILLS 12 + FONT_MEMORY
#define EMPTY 255
#define METATILES 4
#define BACKGROUND_COUNT METATILES * 4
#define SCREEN_WIDTH DEVICE_SCREEN_WIDTH / 2 // metatiles are 16x16
#define SCREEN_HEIGHT DEVICE_SCREEN_HEIGHT / 2
#define CENTER_X SCREEN_WIDTH / 2
#define CENTER_Y SCREEN_HEIGHT / 2 + 2
#define CENTER_X_PX SCREEN_WIDTH * 8 - 8  // 8 pixels per tile, move right 8 pixels
#define CENTER_Y_PX SCREEN_HEIGHT * 8 + 8 // move up 8 pixels
// ----------------- //

#define bool uint8_t
#define true 1
#define false 0

extern struct Player
{
  pos_t x[2];
  pos_t y[2];
  uint16_t steps;
  uint8_t hearts;
  int8_t weapons[2];
  uint16_t gold;
  uint16_t maps;
} p;

extern uint8_t map[SCREEN_WIDTH][SCREEN_HEIGHT];
extern uint8_t sprites[SCREEN_WIDTH][SCREEN_HEIGHT];
extern uint8_t sprite_count;
#define SPRITE_MAX 10
#define ARR_SIZE 256
extern uint16_t arr[ARR_SIZE]; // for used items and decompression
extern clock_t delay_time;

#endif
