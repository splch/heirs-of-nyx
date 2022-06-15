#include "main.h"

uint16_t prngs[6];
uint8_t prngs_index = 0;

pos_t prng(pos_t x, pos_t y)
{
  // /tools/noise.pdf
  y ^= x >> 1;
  x ^= y << 3;
  y ^= x >> 5;
  x ^= y << 7;
  return ((x + y) * 3) ^ 0b0101010100010100;
}

static pos_t smooth_noise(pos_t x, pos_t y, pos_t *num)
{
  // gets average noise at (x, y)
  pos_t corners;
  pos_t sides;
  uint16_t prngs0;
  uint16_t prngs1;
  uint16_t prngs2;

  if (num != NULL) // first run to populate prngs
  {
    prngs[0] = prng(x + 1, y - 1);
    prngs[1] = prng(x + 1, y + 1);
    prngs[2] = prng(x + 1, y);
    prngs[3] = prng(x, y - 1);
    prngs[4] = prng(x, y + 1);
    prngs[5] = prng(x, y);

    corners = (prng(x - 1, y - 1) + prngs[0] + prng(x - 1, y + 1) + prngs[1]) >> 4; // divide by 16
    sides = (prng(x - 1, y) + prngs[2] + prngs[3] + prngs[4]) >> 3;                 // divide by 8
    *num = prngs[5];                                                                // store random number for item and sprite generation
  }
  else
  {
    prngs0 = prng(x + 1, y - 1);
    prngs1 = prng(x + 1, y + 1);
    prngs2 = prng(x + 1, y);

    corners = (prngs[3] + prngs0 + prngs[4] + prngs1) >> 4; // divide by 16
    sides = (prngs[5] + prngs2 + prngs[0] + prngs[1]) >> 3; // divide by 8
    *num = prngs[2];

    prngs[3] = prngs[0];
    prngs[4] = prngs[1];
    prngs[5] = prngs[2];
  }
  const pos_t center = *num >> 2; // divide by 4
  prngs[0] = prngs0;
  prngs[1] = prngs1;
  prngs[2] = prngs2;
  return corners + sides + center; // average noise at center
}

static inline pos_t interpolate(pos_t v1, pos_t v2)
{
  // linear interpolation is avg of v1 and v2
  return (v1 + v2) >> 1; // divide by 2
}

pos_t interpolate_noise(pos_t x, pos_t y, pos_t *num)
{
  // gets expected noise
  pos_t v1 = smooth_noise(x, y, num);
  pos_t v2 = smooth_noise(x + 1, y, NULL);
  const pos_t i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1, NULL);
  v2 = smooth_noise(x + 1, y + 1, NULL);
  const pos_t i2 = interpolate(v1, v2);
  return interpolate(i1, i2); // average of smoothed sides
}
