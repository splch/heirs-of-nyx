#include "main.h"

// Check if save data exists
bool *has_save = (bool *)0xa000;    // Pointer to memory address
uint16_t *vals = (int16_t *)0xa001; // 16 bit for p.steps

void load_save_data() {
  if (has_save[0] == true) {
    // Starting position for map generation
    p.x[0] = p.x[1] = (uint8_t)vals[0];
    p.y[0] = p.y[1] = (uint8_t)vals[1];

    // Player item initialization
    p.steps = (uint16_t)vals[2];
    p.weapons[0] = (int8_t)vals[3];
    p.weapons[1] = (int8_t)vals[4];
    p.gold = (uint8_t)vals[5];
    p.maps = (uint8_t)vals[6];
  } else {
    // Starting position for map generation
    p.x[0] = p.x[1] = p.y[0] = p.y[1] = START_POSITION;

    // Player item initialization
    p.steps = p.gold = p.maps = 0;
    p.weapons[0] = p.weapons[1] = -1;
  }
}

void save_data() {
  // Save position
  vals[0] = p.x[0];
  vals[1] = p.y[0];

  // Save items
  vals[2] = p.steps;
  vals[3] = p.weapons[0];
  vals[4] = p.weapons[1];
  vals[5] = p.gold;
  vals[6] = p.maps;

  // Save is now true
  has_save[0] = true;
}
