#include "main.h"
#include "map.h"
#include "save.h"
#include "noise.h"
#include "../res/vocab.h"
#include <string.h>

// necessary for recursion
void check_movement(const uint8_t);

struct Player p;
clock_t delay_time;

void load_sprite(char *name)
{
  if (strcmp(name, "player") == 0)
  {
    set_sprite_tile(0, 0);
    set_sprite_tile(1, 2);
  }
  else if (strcmp(name, "cat") == 0)
  {
    set_sprite_tile(2, 5);
    set_sprite_tile(3, 7);
  }
}

void position_sprite(char *name, uint8_t x, uint8_t y)
{
  if (strcmp(name, "player") == 0)
  {
    move_sprite(0, x, y);
    move_sprite(1, x + 8, y);
  }
  if (strcmp(name, "cat") == 0)
  {
    move_sprite(2, x, y);
    move_sprite(3, x + 8, y);
  }
}

void show_menu()
{
  // display map to erase previous menus
  HIDE_SPRITES; // menu is open
  const uint8_t x = p.x[0] - START_POSITION;
  const uint8_t y = p.y[0] - START_POSITION;

  printf("\ngold:\t%u", p.gold);
  printf("\nmaps:\t%u", p.maps);
  printf("\nweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\nposition:\t(%u, %u)", x, y);
  printf("\nsteps:\t%u", p.steps);

  uint8_t rnd = prng(p.x[0], p.y[0]);
  printf("\n\nrandom:\t%u\n", rnd);
  const char *str = rnd % 2 ? phrases[rnd % 7] : jokes[rnd % 10];
  printf(str);

  save_data();             // save data on menu press (temp)
  delay(33 * SENSITIVITY); // (100 / 6) * 2 comes from macro definition
  waitpad(0b11111111);
  display_map();
  SHOW_SPRITES; // menu is closed
}

void treasure_search()
{
  for (uint8_t x = 0; x < p.maps; x++)
  {
    for (uint8_t y = 0; y < p.maps; y++)
    {
      const uint8_t noise = prng(x, y);
      if (noise == 255)
      {
        // 255 is the "magic number" for the treasure
        // this is the only place where the treasure is generated
        printf("treasure found at (%u, %u)", x, y);
        waitpad(0b11111111);
        return;
      }
    }
  }
}

void add_inventory(uint8_t item)
{
  // fill primary or replace secondary
  item -= BACKGROUND_COUNT;
  switch (item)
  {
  case 0:
    p.maps++;
    treasure_search();
    break;
  case 8:
    p.gold++;
    break;
  case 4:
  case 12:
    if (p.weapons[0] == -1)
      p.weapons[0] = item;
    else
      p.weapons[1] = item;
    break;
  }
}

void change_item()
{
  // switch primary with secondary weapons
  const int8_t _w = p.weapons[0];
  p.weapons[0] = p.weapons[1];
  p.weapons[1] = _w;
}

void interact()
{
  // -1 <= x - 1 <= 1
  // -1 <= y - 2 <= 1
  // -1 and -2 are "magic numbers"
  // these loops form a square of interaction around the player
  for (int8_t x = -2; x <= 0; x++)
    for (int8_t y = -3; y <= -1; y++)
    {
      const uint8_t pos_x = x + CENTER_X;
      const uint8_t pos_y = y + CENTER_Y;
      const uint8_t item = map[pos_x][pos_y];
      if (item >= FONT_MEMORY + BACKGROUND_COUNT)
      {
        add_inventory(item - FONT_MEMORY);
        remove_item(x + p.x[0], y + p.y[0]);
        // (item - BACKGROUND_COUNT) is the terrain tile
        map[pos_x][pos_y] = item - BACKGROUND_COUNT;
        display_map();
        return; // only pick up one item per interaction
      }
    }
}

void attack()
{
  switch (p.weapons[0])
  {
  case 0:
    // gun
    break;
  case 2:
    // sword
    break;
  }
}

void check_interaction(const uint8_t j)
{
  if (j & J_START)
    show_menu();
  if (j & J_SELECT)
    change_item();
  if (j & J_A)
    interact();
  if (j & J_B)
    attack();
}

uint8_t get_terrain(const int8_t direction)
{
  // n - none, r - right, l - left, u - up, d - down
  switch (direction)
  {
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

void push_player()
{
  const uint8_t current_terrain = get_terrain('n');
  const uint8_t down_terrain = get_terrain('d');
  if (down_terrain == 4 || down_terrain == 4 + BACKGROUND_COUNT ||
      current_terrain == 4 || current_terrain == 4 + BACKGROUND_COUNT)
    // check_movement will recursively call if the user is still on water
    // left (00000010), right (00000001), down (00001000)
    // randomly push down right or left
    check_movement(prng(p.x[0], p.y[0]) % 2 + 0b00001001);
}

void adjust_position(const uint8_t terrain_type, const uint8_t old_x,
                     const uint8_t old_y)
{
  switch (terrain_type)
  {
  case 0:                    // grass
  case 0 + BACKGROUND_COUNT: // item on terrain
  case 8:                    // tree
  case 8 + BACKGROUND_COUNT:
    display_map();
    break; // ignore grass and tree tiles
  case 4:  // water
  case 4 + BACKGROUND_COUNT:
    display_map();
    push_player();
    break;
  case 12: // mountain
  case 12 + BACKGROUND_COUNT:
    // revert to previous position
    p.x[0] = old_x;
    p.y[0] = old_y;
    p.steps--;
    generate_map_sides();
    display_map();
    break;
  }
}

void check_movement(const uint8_t j)
{
  check_interaction(joypad());
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
  if (p.x[0] != _x || p.y[0] != _y)
  {
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
