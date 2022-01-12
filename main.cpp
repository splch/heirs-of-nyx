#include "picosystem.hpp"
#include "main.hpp"
#include "utils.cpp"

using namespace picosystem;

// globals
enum game_state { PLAYING, PAUSED } state;
player p;
uint32_t start_position;
uint32_t start_time;
const uint16_t sensitivity = 150;
uint8_t map[screen_x / sprite_size][screen_y / sprite_size];
int8_t items[screen_x / sprite_size][screen_y / sprite_size];
std::map<uint32_t, std::set<uint32_t>> removed;

// picosystem calls
void init() {
  // set globals
  start_time = time() - sensitivity - 1;
  start_position = 2.15e9;
  state = PLAYING;
  // set starting position
  p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
  p.steps = p.gold = p.maps = 0;
  p.weapons[0] = p.weapons[1] = -1;
  // generate terrain and items
  generate_map();
}

void update(uint32_t tick) {
  if (button(X)) {
    // menu
    if (time() - start_time > sensitivity) {
      start_time = time();
      state = state == PAUSED ? PLAYING : PAUSED;
    }
  }
  if (button(B) && button(Y)) {
    // super speed >:)
    start_time = time() - sensitivity - 1;
  }
  if (state == PLAYING && time() - start_time > sensitivity) {
    if (button(DOWN) || button(RIGHT) || button(LEFT) || button(UP)) {
      start_time = time();
      update_position();
      generate_map();
    }
    if (button(A)) {
      // interact with item
      for (int x = -1; x <= 1; x++)
        for (int y = -1; y <= 1; y++) {
          auto pos_x = x + center[0] / sprite_size;
          auto pos_y = y + center[1] / sprite_size;
          const int8_t item_id = items[pos_x][pos_y];
          items[pos_x][pos_y] = -1;
          if (item_id != -1) {
            // add the location to removed items
            if (removed.count(pos_x + p.x[0])) {
              removed[pos_x + p.x[0]].insert(pos_y + p.y[0]);
            } else {
              std::set<uint32_t> s = {pos_y + p.y[0]};
              removed.insert({pos_x + p.x[0], s});
            }
            int item = loot[item_id][0];
            if (item == COIN_GOLDEN)
              p.gold++;
            else if (item == BOOK_LARGE)
              p.maps++;
            else {
              if (p.weapons[0] == -1)
                p.weapons[0] = item;
              else if (p.weapons[1] == -1)
                p.weapons[1] = item;
              else {
                // items[pos_x][pos_y] = p.weapons[1];
                p.weapons[1] = item;
              }
            }
            start_time = time();
          }
        }
    }
    if (button(Y)) {
      // change primary weapon
      if (time() - start_time > sensitivity) {
        start_time = time();
        int _weapon = p.weapons[0];
        p.weapons[0] = p.weapons[1];
        p.weapons[1] = _weapon;
      }
    }
  }
}

void draw(uint32_t tick) {
  // clear screen
  pen(0, 0, 0);
  clear();
  pen(15, 15, 15);
  if (state == PLAYING) {
    battery_indicator(false);
    for (int x = 0; x < screen_x / sprite_size; x++)
      for (int y = 0; y < screen_y / sprite_size; y++)
        if (x * sprite_size != center[0] || y * sprite_size != center[1]) {
          sprite(terrains[map[x][y]], sprite_size * x, sprite_size * y);
          if (items[x][y] != -1)
            sprite(loot[items[x][y]][0], sprite_size * x, sprite_size * y);
        }
    sprite(DEMON_RED, center[0], center[1]);
  } else {
    battery_indicator(true);
    int32_t x = p.x[0] - start_position;
    int32_t y = p.y[0] - start_position;
    text("gold: " + str(p.gold), 0, 0);
    text("maps: " + str(p.maps), 0, 10);
    text("weapons: " + str(int32_t(p.weapons[0])) + " " +
             str(int32_t(p.weapons[1])),
         0, 20);
    text("position: (" + str(x) + ", " + str(y) + ")", 0, 40);
    text("steps: " + str(int32_t(p.steps), 0), 0, 50);
    text("seed: " + str(SEED), 0, 60);
    text("random: " + str(double(noise(p.x[0], p.y[0])), 4), 0, 80);
    text("battery: " + str(battery()) + "%", 0, 100);
    text("key pressed: " + str(get_button()), 0, 110);
  }
}
