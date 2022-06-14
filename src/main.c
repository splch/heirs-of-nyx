#include "init.h"
#include "main.h"
#include "map.h"
#include "player.h"

struct Player p;

void main()
{
  // prepare hardware
  init_hardware();
  // prepare game on START
  init_game();

  // main game loop
  while (true)
  {
    check_input();   // check for player input
    wait_vbl_done(); // wait until VBLANK to avoid corrupting memory
  }
}

static inline void init_hardware()
{
  DISPLAY_OFF;    // prevent visual bugs
  init_sgb();     // display sgb border
  init_font();    // load font for printf
  init_palette(); // set colors for cgb
  init_tiles();   // decompress tiles
  init_sprites(); // decompress sprites
  init_sound();   // begin playing music
  init_ram();     // load save data
  init_splash();  // load splash screen into map
  DISPLAY_ON;     // game is ready!
}

static inline void init_game()
{
  // generate terrain
  generate_map();
  adjust_position(get_terrain('n'), p.x[1], p.y[1]); // if player loads on water or hills

  // display terrain
  display_map();
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
