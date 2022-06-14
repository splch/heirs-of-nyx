#include "main.h"

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
  const pos_t corners = (prng(x - 1, y - 1) + prng(x + 1, y - 1) +
                         prng(x - 1, y + 1) + prng(x + 1, y + 1)) >>
                        4; // divide by 16
  const pos_t sides =
      (prng(x - 1, y) + prng(x + 1, y) + prng(x, y - 1) + prng(x, y + 1)) >>
      3; // divide by 8
  *num = prng(x, y);
  const pos_t center = *num >> 2;  // divide by 4
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
