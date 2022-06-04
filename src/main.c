#include "init.h"
#include "main.h"
#include "map.h"
#include "player.h"
#include "save.h"

struct Player p;

void main()
{
  init();

  // main game loop
  while (true)
  {
    check_input();   // check for player input
    wait_vbl_done(); // wait until VBLANK to avoid corrupting memory
  }
}

static inline void init()
{
  // initialize game
  init_sgb();
  init_font();
  init_palette();
  init_tiles();
  init_sprites();
  init_sound();

  // initialize game logic
  ENABLE_RAM; // for loading save data

  // load and initialize save data
  load_save_data();

  DISPLAY_ON; // turn on the display

  // --- loading text --- //
  printf("\n\tWelcome to\n\tPirate's Folly");
  // -------------------- //

  // generate terrain
  generate_map();
  // display terrain
  display_map();
  SHOW_SPRITES;                                      // show player
  adjust_position(get_terrain('n'), p.x[1], p.y[1]); // if player loads on water

  // start delay time
  delay_time = clock();
}

static inline void check_input()
{
  const uint8_t j = joypad();
  // delay input by SENSITIVITY
  if (clock() - SENSITIVITY > delay_time && j)
  {
    // non-movement press
    check_interaction(j);
    // movement press
    check_movement(j);
    // reset delay
    delay_time = clock();
  }
}
