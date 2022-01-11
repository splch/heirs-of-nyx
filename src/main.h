#ifndef CONFIG
#define CONFIG

#include <gbdk/platform.h>
#include <stdio.h>
#include <time.h>

// --- CONFIG --- //
#define SEED 57        // Macro is ~2x faster
#define SENSITIVITY 12 // CLOCKS_PER_SEC * t(s), so this is 60 * .2(s) = 12
#define START_POSITION 0
#define SCALE 2
// -------------- //

// --- GB VALUES --- //
#define FONT_MEMORY 102 // prevents writing over font memory
#define BACKGROUND_COUNT 4
#define SPRITE_SIZE 8
#define CENTER_X DEVICE_SCREEN_WIDTH / 2
#define CENTER_Y DEVICE_SCREEN_HEIGHT / 2
#define CENTER_X_PX DEVICE_SCREEN_WIDTH * 4
#define CENTER_Y_PX DEVICE_SCREEN_HEIGHT * 4
// ----------------- //

#define true 1
#define false 0
typedef int8_t bool;

extern struct Player {
  uint8_t x[2];
  uint8_t y[2];
  uint16_t steps;
  int8_t weapons[2];
  uint8_t gold;
  uint8_t maps;
} p;

extern uint8_t map[DEVICE_SCREEN_WIDTH][DEVICE_SCREEN_HEIGHT];
extern uint16_t used[256]; // for used items and decompression
extern uint8_t used_index;
extern clock_t delay_time;

#endif
