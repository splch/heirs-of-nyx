#include "main.h"
#include "map.h"
#include "noise.h"
#include "pirate.h"
#include "save.h"

// necessary for recursion
void check_movement(const uint8_t);

clock_t delay_time;

void wait()
{
  delay(33 * SENSITIVITY + 1); // (100 / 6) * 2 comes from macro definition
  wait_vbl_done();             // put system in low power mode
  waitpad(0b11111111);
}

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
  const int16_t x = p.x[0] - START_POSITION;
  const int16_t y = p.y[0] - START_POSITION;

  printf("\ngold:\t%u", p.gold);
  printf("\nmaps:\t%u", p.maps);
  printf("\nweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);

  printf("\n\nposition:\t(%d, %d)", x, y);
  printf("\nsteps:\t%u", p.steps);

  printf("\n\nrandom:\t%u", prng(p.x[0], p.y[0]));

  printf("\n\npress any key to continue...");

  save_data(); // save data on menu press (temp)
  wait();
  display_map();
  SHOW_SPRITES; // menu is closed
}

static inline void treasure_search()
{
  // search a grid around the start position
  for (uint8_t x = 0; x < 5; x++)
  {
    for (uint8_t y = 0; y < 5; y++)
    {
      const uint8_t noise = (uint8_t)prng(START_POSITION + x, START_POSITION + y);
      if (noise < p.maps)
      {
        printf("treasure found at (%d, %d)", x - START_POSITION, y - START_POSITION);
        wait();
        return;
      }
    }
  }
}

static inline void add_inventory(uint8_t item)
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
  const int8_t _t = p.weapons[0];
  p.weapons[0] = p.weapons[1];
  p.weapons[1] = _t;
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
        remove_item(p.x[0] + x + 1, p.y[0] + y + 2); // +1 and +2 are round-off errors
        // (item - BACKGROUND_COUNT) is the terrain tile
        map[pos_x][pos_y] = item - BACKGROUND_COUNT;
        display_map();
        add_inventory(item - FONT_MEMORY);
        save_data(); // save data on item pickup
        return;      // only pick up one item per interaction
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

static inline void push_player()
{
  const uint8_t current_terrain = get_terrain('n');
  const uint8_t down_terrain = get_terrain('d');
  if (down_terrain == 4 || down_terrain == 4 + BACKGROUND_COUNT ||
      current_terrain == 4 || current_terrain == 4 + BACKGROUND_COUNT)
    // check_movement will recursively call if the user is still on water
    // left (00000010), right (00000001), down (00001000)
    // randomly push down right or left
    check_movement((prng(p.x[0], p.y[0]) & 1) + 0b00001001);
}

void adjust_position(const uint8_t terrain_type, const pos_t old_x,
                     const pos_t old_y)
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
  case 12: // hill
  case 12 + BACKGROUND_COUNT:
    // if START_POSITION is a hill
    if (p.steps == 0)
    {
      p.x[0] = p.x[1] = p.y[0] = p.y[1] = prng(p.x[0], p.y[0]); // move randomly
      generate_map();
      adjust_position(get_terrain('n'), p.x[1], p.y[1]);
    }
    else
    {
      // revert to previous position
      p.x[0] = old_x;
      p.y[0] = old_y;
      p.steps--;
      generate_map_sides();
    }
    display_map();
    break;
  }
}

void check_movement(const uint8_t j)
{
  check_interaction(joypad()); // interact when water is pushing
  // j = right - 1, left - 2, up - 4, down - 8
  pos_t _x = p.x[0];
  pos_t _y = p.y[0];
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
    const pos_t old_x = p.x[1];
    const pos_t old_y = p.y[1];
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
