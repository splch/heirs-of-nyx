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
// ----------------- //

typedef enum { false, true } bool;

// map[screen_x / sprite_size][screen_y / sprite_size]
extern unsigned char map[20][18];

extern struct player {
  unsigned long x[2], y[2];
  unsigned long steps;
  char weapons[2];
  unsigned char gold, maps;
} p;

#endif
