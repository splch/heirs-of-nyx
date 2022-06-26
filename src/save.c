#include "main.h"
#include "map.h"

// check if save data exists
static bool *has_save = (bool *)0xA000;     // pointer to memory address
static uint16_t *vals = (uint16_t *)0xA001; // 16 bit for 2^16 x 2^16 map

void load_save_data()
{
  ENABLE_RAM; // for r/w ram address

  if (has_save[0] == true) // needs true since any non-zero satisfies the condition
  {
    uint8_t i = 0;

    // starting position for map generation
    p.x[0] = p.x[1] = vals[i++];
    p.y[0] = p.y[1] = vals[i++];

    // player item initialization
    p.steps = vals[i++];
    p.hearts = vals[i++];
    p.weapons[0] = (int8_t)vals[i++];
    p.weapons[1] = (int8_t)vals[i++];
    p.gold = vals[i++];
    p.maps = vals[i++];

    // item history data
    for (uint8_t j = 0; j < 255 - i; j++) // compiler reduces 255-8->247
      arr[j] = vals[j + i];               // don't overwrite other save data
  }
  else
  {
    // starting position for map generation
    p.x[0] = p.x[1] = p.y[0] = p.y[1] = START_POSITION;

    // player item initialization
    p.steps = p.gold = p.maps = 0;
    p.hearts = 3;
    p.weapons[0] = p.weapons[1] = -1;

    // initialize item history to 0
    for (uint8_t i = 0; i < 255; i++)
      arr[i] = 0;
  }
}

void save_data()
{
  ENABLE_RAM; // TODO: find out what's disabling RAM

  uint8_t i = 0;

  // save position
  vals[i++] = p.x[0];
  vals[i++] = p.y[0];

  // save items
  vals[i++] = p.steps;
  vals[i++] = p.hearts;
  vals[i++] = p.weapons[0];
  vals[i++] = p.weapons[1];
  vals[i++] = p.gold;
  vals[i++] = p.maps;

  // save item history
  for (uint8_t j = i; j < 255; j++)
    vals[j] = arr[j - i];

  // save is now true
  has_save[0] = true;
}
