#include "main.h"
#include "map.h"
#include "noise.h"
#include "save.h"

// necessary for recursion
void update_position(const uint8_t);

void show_menu() {
  // display map to erase previous menus
  display_map();
  HIDE_SPRITES; // menu is open
  const uint8_t x = p.x[0] - START_POSITION;
  const uint8_t y = p.y[0] - START_POSITION;
  printf("\ngold:\t%u", p.gold);
  printf("\nmaps:\t%u", p.maps);
  printf("\nweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\nposition:\t(%u, %u)", x, y);
  printf("\nsteps:\t%u", p.steps);
  printf("\nseed:\t%u", SEED);

  printf("\n\nrandom:\t%u", noise(p.x[0], p.y[0]));

  printf("\n\npress start to exit");
  save_data(); // Save data on menu press (temp)
  waitpad(J_START);
  display_map();
}

void add_inventory(uint8_t item) {
  // fill primary or replace secondary
  item -= BACKGROUND_COUNT;
  switch (item) {
  case 0:
  case 2:
    if (p.weapons[0] == -1) {
      p.weapons[0] = item;
    } else {
      p.weapons[1] = item;
    }
    break;
  case 1:
    p.maps++;
    break;
  case 3:
    p.gold++;
    break;
  }
}

void change_item() {
  // switch primary with secondary weapons
  const int8_t _w = p.weapons[0];
  p.weapons[0] = p.weapons[1];
  p.weapons[1] = _w;
}

void interact() {
  // -1 <= x - 1 <= 1
  // -1 <= y - 2 <= 1
  // -1 and -2 are "magic numbers"
  // these loops form a square of interaction around the player
  for (int8_t x = -2; x <= 0; x++)
    for (int8_t y = -3; y <= -1; y++) {
      const uint8_t pos_x = x + CENTER_X;
      const uint8_t pos_y = y + CENTER_Y;
      const uint8_t item = map[pos_x][pos_y];
      if (item >= FONT_MEMORY + BACKGROUND_COUNT) {
        add_inventory(item - FONT_MEMORY);
        remove_item(x + p.x[0], y + p.y[0]);
        // (item - BACKGROUND_COUNT) is the terrain tile
        map[pos_x][pos_y] = item - BACKGROUND_COUNT;
        display_map();
        return; // only pick up one item per interaction
      }
    }
}

void attack() {
  switch (p.weapons[0]) {
  case 0:
    // printf("\nbang!\n");
    break;
  case 2:
    // printf("\nclink!\n");
    break;
  }
}

void check_interactions(const uint8_t j) {
  // delay non-movement by SENSITIVITY
  if (clock() - SENSITIVITY > delay_time) {
    if (j & J_START)
      show_menu();
    if (j & J_SELECT)
      change_item();
    if (j & J_A)
      interact();
    if (j & J_B)
      attack();
    // reset delay if input is detected
    if (j)
      delay_time = clock();
  }
}

uint8_t get_terrain(const int8_t direction) {
  // n - none, r - right, l - left, u - up, d - down
  switch (direction) {
  // these "magic numbers" are from `interact()`
  case 'n':
    return map[CENTER_X - 1][CENTER_Y - 2] - FONT_MEMORY;
  case 'r':
    return map[CENTER_X][CENTER_Y - 2] - FONT_MEMORY;
  case 'l':
    return map[CENTER_X - 2][CENTER_Y - 2] - FONT_MEMORY;
  case 'u':
    return map[CENTER_X - 1][CENTER_Y - 3] - FONT_MEMORY;
  case 'd':
    return map[CENTER_X - 1][CENTER_Y - 1] - FONT_MEMORY;
  }
  return 255;
}

void push_player() {
  const uint8_t current_terrain = get_terrain('n');
  const uint8_t down_terrain = get_terrain('d');
  if (down_terrain == 1 || down_terrain == 1 + BACKGROUND_COUNT ||
      current_terrain == 1 || current_terrain == 1 + BACKGROUND_COUNT)
    // update_position will recursively call if the user is still on water
    // push the player right on the water (00000001)
    // push the player down the water (00001000)
    // right and down = 00001001 = 9
    update_position(9);
}

void adjust_position(const uint8_t terrain_type, const uint8_t old_x,
                     const uint8_t old_y) {
  switch (terrain_type) {
  case 0:                    // grass
  case 0 + BACKGROUND_COUNT: // item on terrain
  case 2:                    // tree
  case 2 + BACKGROUND_COUNT:
    display_map();
    break; // ignore grass and tree tiles
  case 1:  // water
  case 1 + BACKGROUND_COUNT:
    display_map();
    push_player();
    break;
  case 3: // mountain
  case 3 + BACKGROUND_COUNT:
    // revert to previous position
    p.x[0] = old_x;
    p.y[0] = old_y;
    p.steps--;
    generate_map_sides();
    display_map();
    break;
  }
}

void update_position(const uint8_t j) {
  check_interactions(joypad());
  // j = right - 1, left - 2, up - 4, down - 8
  uint8_t _x = p.x[0];
  uint8_t _y = p.y[0];
  if (j & J_RIGHT)
    _x++;
  if (j & J_LEFT)
    _x--;
  if (j & J_UP)
    _y--;
  if (j & J_DOWN)
    _y++;
  if (p.x[0] != _x || p.y[0] != _y) {
    const uint8_t old_x = p.x[1];
    const uint8_t old_y = p.y[1];
    p.x[1] = p.x[0];
    p.x[0] = _x;
    // makes diagonal movement possible
    p.y[1] = p.y[0];
    p.y[0] = _y;
    p.steps++;
    generate_map_sides();
    adjust_position(get_terrain('n'), old_x, old_y);
  }
}
