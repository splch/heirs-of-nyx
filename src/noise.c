#include "main.h"
#include "noise.h"

static inline uint8_t smooth_noise(uint8_t x, uint8_t y)
{
  // gets average noise at (x, y)
  const uint8_t corners = (prng(x - 1, y - 1) + prng(x + 1, y - 1) +
                           prng(x - 1, y + 1) + prng(x + 1, y + 1)) >>
                          4; // divide by 16
  const uint8_t sides =
      (prng(x - 1, y) + prng(x + 1, y) + prng(x, y - 1) + prng(x, y + 1)) >>
      3;                                  // divide by 8
  const uint8_t center = prng(x, y) >> 2; // divide by 4
  return corners + sides + center;        // average noise at center
}

static inline uint8_t interpolate(uint8_t v1, uint8_t v2)
{
  // linear interpolation is avg of v1 and v2
  return (v1 + v2) >> 1; // divide by 2
}

inline uint8_t interpolate_noise(uint8_t x, uint8_t y)
{
  // gets expected noise
  uint8_t v1 = smooth_noise(x, y);
  uint8_t v2 = smooth_noise(x + 1, y);
  const uint8_t i1 = interpolate(v1, v2);
  v1 = smooth_noise(x, y + 1);
  v2 = smooth_noise(x + 1, y + 1);
  const uint8_t i2 = interpolate(v1, v2);
  return interpolate(i1, i2); // average of smoothed sides
}
