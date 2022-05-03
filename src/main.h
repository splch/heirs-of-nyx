#ifndef CONFIG
#define CONFIG

#include <gbdk/platform.h>
#include <stdio.h>
#include <time.h>

// --- CONFIG --- //
#define SEED 57       // macro is ~2x faster
#define SENSITIVITY 6 // CLOCKS_PER_SEC * t(s), so this is 60 * .1(s) = 6
#define START_POSITION 0
// -------------- //

// --- GB VALUES --- //
#define FONT_MEMORY 102 // prevents writing over font memory
#define BACKGROUND_COUNT 4
#define SCREEN_WIDTH DEVICE_SCREEN_WIDTH / 2
#define SCREEN_HEIGHT DEVICE_SCREEN_HEIGHT / 2
#define CENTER_X SCREEN_WIDTH / 2
#define CENTER_Y SCREEN_HEIGHT / 2
#define CENTER_X_PX SCREEN_WIDTH * 4
#define CENTER_Y_PX SCREEN_HEIGHT * 4
// ----------------- //

#define true 1
#define false 0
typedef int8_t bool;

extern struct Player
{
  uint8_t x[2];
  uint8_t y[2];
  uint16_t steps;
  uint8_t hearts;
  int8_t weapons[2];
  uint8_t gold;
  uint8_t maps;
} p;

extern uint8_t map[SCREEN_WIDTH][SCREEN_HEIGHT];
extern uint16_t arr_4kb[256]; // for used items and decompression
extern clock_t delay_time;

#endif