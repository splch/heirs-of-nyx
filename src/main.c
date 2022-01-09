#include "main.h"
#include "../res/sprites.h"
#include "../res/tiles.h"
#include "utils.h"
#include <gbdk/font.h>
#include <gbdk/gbdecompress.h>

void init();
void update_switches();
void check_input();

uint8_t map[DEVICE_SCREEN_WIDTH][DEVICE_SCREEN_HEIGHT];
struct Player p;
clock_t delay_time;

void main() {
  init();

  while (true) {
    check_input();   // Check for player input
    wait_vbl_done(); // Wait until VBLANK to avoid corrupting memory
  }
}

void init() {
  font_init();                   // Initialize font system
  font_set(font_load(font_ibm)); // Set and load the font

  // Set color palette for compatible ROMs
  set_default_palette();

  // Decompress background and sprite data
  // and load them into memory
  uint8_t buffer[256];
  set_bkg_data(FONT_MEMORY, gb_decompress(landscape, buffer) >> 4, buffer);
  set_sprite_data(0, gb_decompress(player_sprite, buffer) >> 4, buffer);

  // Set first movable sprite (0) to be first tile in sprite memory (0)
  set_sprite_tile(0, 0);

  // Move the sprite in the first movable sprite list (0)
  // the center of the screen
  move_sprite(0, CENTER_X_PX, CENTER_Y_PX);

  ENABLE_RAM; // For loading save data

  // Load and initialize save data
  load_save_data();

  DISPLAY_ON; // Turn on the display

  // --- LOADING TEXT --- //
  printf("\n\tWelcome to\n\tPirate's Folly");
  // -------------------- //

  // Generate terrain
  generate_map();
  // Display terrain
  display_map();
  SHOW_SPRITES; // Show player

  // Start delay time
  delay_time = clock();
}

inline void check_input() {
  const uint8_t j = joypad();
  // check interactions separately from movement
  // makes delaying simple
  check_interactions(j);
  if (j)
    update_position(j);
}
