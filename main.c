#include "main.h"
#include "sprites.c"
#include "tiles.c"
#include "utils.c"
#include <gb/gb.h>
#include <gbdk/font.h>
#include <rand.h>
#include <stdio.h>
#include <time.h>

void init();
void checkInput();
void updateSwitches();

unsigned char map[20][18];
struct player p;
UINT16 start_time;

void main() {
  init();

  while (1) {
    checkInput();     // Check for user input (and act on it)
    updateSwitches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are on
                      // each loop
    wait_vbl_done();  // Wait until VBLANK to avoid corrupting memory
  }
}

void init() {
  DISPLAY_ON; // Turn on the display

  font_init();                   // Initialize font
  font_set(font_load(font_ibm)); // Set and load the font

  set_bkg_data(0, 3, landscape);

  // Load the the 'sprites' tiles into sprite memory
  set_sprite_data(0, 0, player_sprite);

  // Set first movable sprite (0) to be first tile in sprite memory (0)
  set_sprite_tile(0, 0);

  // Move the sprite in the first movable sprite list (0)
  // the center of the screen
  move_sprite(0, (screen_x + sprite_size) / 2, (screen_y + sprite_size) / 2);

  // Set globals
  start_time = time(NULL);
  // Starting position
  p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
  // Item initialization
  p.steps = p.gold = p.maps = 0;
  p.weapons[0] = p.weapons[1] = -1;
  // Generate terrain
  printf("\n\tWelcome to\n\tPirate's Folly");
  generate_map();
  load_map();
}

void updateSwitches() {
  HIDE_WIN;
  SHOW_SPRITES;
  SHOW_BKG;
}

void checkInput() {
  if (joypad()) {
    update_position();
    generate_map();
    load_map();
  }
}
