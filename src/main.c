#include "main.h"
#include "../res/sprites.h"
#include "../res/tiles.h"
#include "utils.h"
#include <gbdk/font.h>
#include <gbdk/gbdecompress.h>

void init();
void update_switches();
void check_input();

// unsigned char SEED;
unsigned char buffer[32]; // for decompression
unsigned char map[DEVICE_SCREEN_WIDTH][DEVICE_SCREEN_HEIGHT];
struct Player p;
clock_t delay_time;

void main() {
  init();

  while (1) {
    check_input();     // Check for player input
    update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
                       // on each loop
    wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
  }
}

void init() {
  DISPLAY_ON; // Turn on the display

  font_init();                   // Initialize font system
  font_set(font_load(font_ibm)); // Set and load the font

  // Decompress background and sprite data
  // and load them into memory
  set_bkg_data(FONT_MEMORY, gb_decompress(landscape, buffer) >> 4, buffer);
  set_sprite_data(0, gb_decompress(player_sprite, buffer) >> 4, buffer);

  // Set first movable sprite (0) to be first tile in sprite memory (0)
  set_sprite_tile(0, 0);

  // Move the sprite in the first movable sprite list (0)
  // the center of the screen
  move_sprite(0, CENTER_X_PX, CENTER_Y_PX);

  // Starting position for map generation
  p.x[0] = p.x[1] = p.y[0] = p.y[1] = START_POSITION;

  // Player item initialization
  p.steps = p.gold = p.maps = 0;
  p.weapons[0] = p.weapons[1] = -1;

  // --- LOADING TEXT --- //
  printf("\n\tWelcome to\n\tPirate's Folly");
  // -------------------- //

  // Set SEED
  // uncomment the SEED lines to let player change SEED
  // SEED = 57;

  // Generate terrain
  generate_map();
  // Display terrain
  display_map();

  // Start delay time
  delay_time = clock();
}

inline void update_switches() {
  HIDE_WIN;
  SHOW_BKG;
}

inline void check_input() {
  const unsigned char j = joypad();
  // check interactions separately from movement
  // makes delaying simple
  check_interactions(j);
  if (j)
    update_position(j);
}
