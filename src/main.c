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
  DISPLAY_OFF; // prevent visual bugs
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

  // --- splash screen --- //
  init_splash();
  display_map();

  DISPLAY_ON;
  waitpad(J_START);
  printf("loading world...");
  // -------------------- //

  // generate terrain
  generate_map();
  adjust_position(get_terrain('n'), p.x[1], p.y[1]); // if player loads on water or hills

  // display terrain
  display_map();

  // wait until start button is pressed
  SHOW_SPRITES; // show player

  // start delay time
  delay_time = clock();
}

static inline void check_input()
{
  // delay input by SENSITIVITY
  if (clock() - delay_time > SENSITIVITY && joypad())
  {
    // non-movement press
    check_interaction(joypad());
    // movement press
    check_movement(joypad());
    // reset delay
    delay_time = clock();
  }
}
