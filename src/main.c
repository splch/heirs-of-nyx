#include "main.h"
#include "../res/sprites.h"
#include "../res/tiles.h"
#include "utils.h"
#include <gbdk/font.h>
#include <gbdk/gbdecompress.h>
#include <gbdk/metasprites.h>

void init();
void check_input();

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

void init()
{
  font_init();                   // initialize font system
  font_set(font_load(font_ibm)); // set and load the font

  // set color palette for compatible ROMs
  set_default_palette();

  // decompress background and sprite data
  // and load them into memory
  set_bkg_data(FONT_MEMORY, gb_decompress(landscape, arr_4kb) >> 4, arr_4kb);
  set_sprite_data(0, gb_decompress(player_sprite, arr_4kb) >> 4, arr_4kb);

  // use metasprite sizes
  SPRITES_8x16;

  // set first movable sprite (0) to be first tile in sprite memory (0)
  load_sprite("player");

  // move the sprite in the first movable sprite list (0)
  // the center of the screen
  position_sprite("player", CENTER_X_PX, CENTER_Y_PX);

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
  SHOW_SPRITES; // show player

  // start delay time
  delay_time = clock();
}

inline void check_input()
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
