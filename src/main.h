#ifndef CONFIG
#define CONFIG

#include <gbdk/platform.h>
#include <stdio.h>

// --- CONFIG --- //
#define scale 2
#define start_position 127
#define SEED 57
// -------------- //

// --- GB VALUES --- //
#define backgrounds 4
#define sprite_size 8
#define center_x DEVICE_SCREEN_WIDTH * 4
#define center_y DEVICE_SCREEN_HEIGHT * 4
#define gen_x DEVICE_SCREEN_WIDTH / 2
#define gen_y DEVICE_SCREEN_HEIGHT / 2
// ----------------- //

#define true 1
#define false 0
typedef char bool;

extern unsigned char map[DEVICE_SCREEN_WIDTH][DEVICE_SCREEN_HEIGHT];

extern struct player {
  unsigned char x[2];
  unsigned char y[2];
  unsigned long steps;
  char weapons[2];
  unsigned char gold;
  unsigned char maps;
} p;

#endif
