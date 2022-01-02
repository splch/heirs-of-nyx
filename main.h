#ifndef CONFIG
#define CONFIG

#include <gb/gb.h>
#include <stdio.h>

// --- CONFIG --- //
#define scale 2
#define start_position 127
#define SEED 57
// -------------- //

// --- GB VALUES --- //
#define sprite_size 8
#define screen_x 160
#define screen_y 144
#define pixel_x screen_x / sprite_size
#define pixel_y screen_y / sprite_size
#define center_x screen_x / 2
#define center_y screen_y / 2
#define gen_x pixel_x / 2
#define gen_y pixel_y / 2
// ----------------- //

#define true 1
#define false 0
typedef char bool;

extern unsigned char map[pixel_x][pixel_y];

extern struct player {
  unsigned char x[2];
  unsigned char y[2];
  unsigned long steps;
  char weapons[2];
  unsigned char gold, maps;
} p;

#endif
