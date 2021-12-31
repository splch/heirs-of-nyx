#ifndef CONFIG
#define CONFIG

#include <gb/gb.h>
#include <rand.h>
#include <stdio.h>

#define sprite_size 8
#define screen_x 160
#define screen_y 144
#define scale 3
#define start_position 127
#define SEED 57

typedef enum { false, true } bool;

// map[screen_x / sprite_size][screen_y / sprite_size]
extern unsigned char map[20][18];

extern struct player {
  UINT16 x[2], y[2];
  UINT16 steps;
  INT8 weapons[2];
  UINT8 gold, maps;
} p;

#endif
