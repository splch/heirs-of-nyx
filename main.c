#include "main.h"
#include "sprites.c"
#include "tiles.c"
#include "utils.c"
#include <gb/gbdecompress.h>
#include <gbdk/font.h>

void init();
void update_switches();
void check_input();

unsigned char map[pixel_x][pixel_y];
struct player p;

void main() {
  init();

  while (1) {
    check_input();     // Check for user input
    update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
                       // on each loop
    wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
  }
}

void init() {
  DISPLAY_ON; // Turn on the display

  font_init();                   // Initialize font
  font_set(font_load(font_ibm)); // Set and load the font

  // Decompress background and sprite data
  // and load them into memory
  gb_decompress_bkg_data(0, landscape);
  gb_decompress_sprite_data(0, player_sprite);

  // Set first movable sprite (0) to be first tile in sprite memory (0)
  set_sprite_tile(0, 0);

  // Move the sprite in the first movable sprite list (0)
  // the center of the screen
  move_sprite(0, center_x, center_y);

  // Starting position for map generation
  p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;

  // Player item initialization
  p.steps = p.gold = p.maps = 0;
  p.weapons[0] = p.weapons[1] = -1;

  // --- LOADING TEXT --- //
  printf("\n\tWelcome to\n\tPirate's Folly");
  // -------------------- //

  // Generate terrain
  generate_map();

  // Display terrain
  display_map();
}

inline void update_switches() {
  HIDE_WIN;
  SHOW_BKG;
}

inline void check_input() {
  const unsigned char j = joypad();
  if (j & J_START)
    show_menu();
  if (j & J_SELECT)
    change_item();
  if (j & J_A)
    interact();
  if (j & J_B)
    attack();
  if (j)
    update_position(j);
}
