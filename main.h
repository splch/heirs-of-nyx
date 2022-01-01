#ifndef CONFIG
#define CONFIG

#include "sprites.c"
#include "tiles.c"
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
// ----------------- //

typedef enum { false, true } bool;

extern unsigned char map[screen_x / sprite_size][screen_y / sprite_size];

extern struct player {
  unsigned long x[2], y[2];
  unsigned long steps;
  char weapons[2];
  unsigned char gold, maps;
} p;

#endif
