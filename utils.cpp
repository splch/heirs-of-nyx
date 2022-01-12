#include "picosystem.hpp"
#include "main.hpp"

using namespace picosystem;

uint32_t get_button() {
  // get the last pressed button
  if (button(X))
    return X;
  else if (button(A))
    return A;
  else if (button(B))
    return B;
  else if (button(Y))
    return Y;
  else if (button(UP))
    return UP;
  else if (button(DOWN))
    return DOWN;
  else if (button(LEFT))
    return LEFT;
  else if (button(RIGHT))
    return RIGHT;
  return 15;
}

void battery_indicator(bool on) {
  if (on) {
    auto battery_level = battery();
    // red when 0%, green when 100%
    led(100 - battery_level, battery_level, 0);
  } else {
    led(0, 0, 0);
  }
}

void update_position() {
  uint32_t _x = p.x[0];
  uint32_t _y = p.y[0];
  if (button(UP)) _y--;
  if (button(DOWN)) _y++;
  if (button(LEFT)) _x--;
  if (button(RIGHT)) _x++;
  if (_x != p.x[0]) {
    p.x[1] = p.x[0];
    p.x[0] = _x;
    p.steps++;
  }
  if (_y != p.y[0]) {
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
  }
}

// from http://freespace.virgin.net/hugo.elias/models/m_perlin.htm
// try using
// https://www.davidepesce.com/2020/02/24/procedural-generation-in-game-development/

double noise(uint32_t x, uint32_t y) {
  // return random number [0, 1]
  int32_t n = x + y * SEED;
  n = (n << 13) ^ n;
  return ((n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) /
         2147483648.0;
}

double smooth_noise(uint32_t x, uint32_t y) {
  // gets average noise at (x, y)
  const double corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
                          noise(x - 1, y + 1) + noise(x + 1, y + 1)) /
                         16;
  const double sides =
      (noise(x - 1, y) + noise(x + 1, y) + noise(x, y - 1) + noise(x, y + 1)) /
      8;
  const double center = noise(x, y) / 4;
  return corners + sides + center;
}

double interpolate(double v1, double v2, double x) {
  // linear interpolate
  return v1 * (1 - x) + v2 * x;
  // cosine interpolate
  // auto f = (1 - fcos(x * 3.14159265358979323846)) * .5;
  // return v1 * (1 - f) + v2 * f;
}

double interpolate_noise(double x, double y) {
  // gets expected noise of decimals
  const uint32_t int_x = uint32_t(x);
  const double frac_x = x - int_x;
  const uint32_t int_y = uint32_t(y);
  const double frac_y = y - int_y;
  double v1 = smooth_noise(int_x, int_y);
  double v2 = smooth_noise(int_x + 1, int_y);
  const double i1 = interpolate(v1, v2, frac_x);
  v1 = smooth_noise(int_x, int_y + 1);
  v2 = smooth_noise(int_x + 1, int_y + 1);
  const double i2 = interpolate(v1, v2, frac_x);
  return interpolate(i1, i2, frac_y);
}

uint8_t closest(double value, uint8_t types) {
  auto diff = 1.0 / types;
  if (value < 1.3 * diff)
    return 0;  // water
  else if (value < 2.2 * diff)
    return 1;  // grass
  else if (value < 2.6 * diff)
    return 2;  // trees
  else
    return 3;  // mountains
}

// uint8_t closest(double value, uint8_t types) {
// 	auto diff = 1.0 / types;
// 	for (int i = 0; i < types; i++) {
// 		if (value < (i+1)*diff) return i;
// 	}
// 	return types - 1;
// }

uint8_t terrain(uint32_t x, uint32_t y, double scale = 2.2, uint8_t types = 4) {
  // return type of terrain at (x, y)
  const double value = interpolate_noise(x / scale, y / scale);
  return closest(value, types);
}

void shift_left(const uint32_t pixel_x, const uint32_t pixel_y) {
  for (int x = 0; x < pixel_x - 1; x++)
    for (int y = 0; y < pixel_y; y++) {
      map[x][y] = map[x + 1][y];
      items[x][y] = items[x + 1][y];
    }
}

void shift_right(const uint32_t pixel_x, const uint32_t pixel_y) {
  for (int x = pixel_x - 1; x > 0; x--)
    for (int y = 0; y < pixel_y; y++) {
      map[x][y] = map[x - 1][y];
      items[x][y] = items[x - 1][y];
    }
}

void shift_up(const uint32_t pixel_x, const uint32_t pixel_y) {
  for (int y = 0; y < pixel_y - 1; y++)
    for (int x = 0; x < pixel_x; x++) {
      map[x][y] = map[x][y + 1];
      items[x][y] = items[x][y + 1];
    }
}

void shift_down(const uint32_t pixel_x, const uint32_t pixel_y) {
  for (int y = pixel_y - 1; y > 0; y--)
    for (int x = 0; x < pixel_x; x++) {
      map[x][y] = map[x][y - 1];
      items[x][y] = items[x][y - 1];
    }
}

void generate_item(const uint32_t x, const uint32_t y) {
  std::set<uint32_t> s = removed[x + p.x[0]];
  if (s.count(y + p.y[0]) == 0) {
    double n = noise(x + p.x[0], y + p.y[0]);
    uint8_t item = n < std::log10(p.maps + 10) * DROP_RATE ? (int)(n * 10000) % 7 : -1;
    items[x][y] = loot[item][1] == terrains[map[x][y]] ? item : -1;
  }
}

void generate_border(const uint32_t pixel_x, const uint32_t pixel_y) {
  for (int y = 0; y < pixel_y; y++) {
    // generate left and right edges of terrain
    map[0][y] = terrain(p.x[0], y + p.y[0]);
    map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
    // generate left-edge items
    generate_item(0, y);
    // generate right-edge items
    generate_item(pixel_x - 1, y);
  }
  for (int x = 0; x < pixel_x; x++) {
    // generate top and bottom edges of terrain
    map[x][0] = terrain(x + p.x[0], p.y[0]);
    map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
    // generate left-edge items
    generate_item(x, 0);
    // generate right-edge items
    generate_item(x, pixel_y - 1);
  }
}

void generate_map() {
  const uint32_t pixel_x = screen_x / sprite_size;
  const uint32_t pixel_y = screen_y / sprite_size;
  const int8_t diff_x = p.x[1] - p.x[0];
  const int8_t diff_y = p.y[1] - p.y[0];
  if (p.steps > 0) {
    if (diff_x < 0) {
      // moved right
      shift_left(pixel_x, pixel_y);
    } else if (diff_x > 0) {
      // moved left
      shift_right(pixel_x, pixel_y);
    }
    if (diff_y < 0) {
      // moved down
      shift_up(pixel_x, pixel_y);

    } else if (diff_y > 0) {
      // moved up
      shift_down(pixel_x, pixel_y);
    }
    generate_border(pixel_x, pixel_y);
    p.x[1] = p.x[0];
    p.y[1] = p.y[0];
  }
  else for (int x = 0; x < pixel_x; x++) for (int y = 0; y < pixel_y; y++) {
    map[x][y] = terrain(x + p.x[0], y + p.y[0]);
    // simple random number
    generate_item(x, y);
  }
}
