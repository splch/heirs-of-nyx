#include <gb/cgb.h>
#include <gbdk/font.h>
#include <gbdk/gbdecompress.h>
#include <gbdk/metasprites.h>
#include "main.h"
#include "map.h"
#include "player.h"
#include "save.h"
#include "sgb_border.h"
#include "../res/border_data.h"
#include "../res/hUGEDriver.h"
#include "../res/sprites.h"
#include "../res/tiles.h"

extern const hUGESong_t wellerman;

void init_sgb()
{
    // Wait 4 frames
    // For SGB on PAL SNES this delay is required on startup, otherwise borders don't show up
    for (uint8_t i = 4; i != 0; i--)
        wait_vbl_done();
    SHOW_BKG;
    set_sgb_border(border_data_tiles, sizeof(border_data_tiles), border_data_map, sizeof(border_data_map), border_data_palettes, sizeof(border_data_palettes));
}

void init_font()
{
    font_init();                   // initialize font system
    font_set(font_load(font_ibm)); // set and load the font
}

void init_palette()
{
    // set color palette for compatible ROMs
    set_bkg_palette_entry(0, 0, RGB8(255, 255, 255)); // lightest color
    set_bkg_palette_entry(0, 1, RGB8(0, 255, 0));
    set_bkg_palette_entry(0, 2, RGB8(0, 0, 255));
    set_bkg_palette_entry(0, 3, RGB8(0, 0, 0)); // darkest color

    set_sprite_palette_entry(0, 0, RGB8(255, 255, 255));
    set_sprite_palette_entry(0, 1, RGB8(127, 127, 127));
    set_sprite_palette_entry(0, 2, RGB8(255, 0, 0));
    set_sprite_palette_entry(0, 3, RGB8(0, 0, 0));
}

void init_tiles()
{
    // use metasprite sizes
    SPRITES_8x16;
    // decompress background and sprite data
    // and load them into memory
    set_bkg_data(FONT_MEMORY, gb_decompress(landscape, arr) >> 4, arr);
    set_sprite_data(0, gb_decompress(player_sprite, arr) >> 4, arr);
}

void init_sprites()
{
    // set first movable sprite (0) to be first tile in sprite memory (0)
    load_sprite("player");
    load_sprite("cat");

    // move the sprite in the first movable sprite list (0)
    // the center of the screen
    position_sprite("player", CENTER_X_PX, CENTER_Y_PX);
    position_sprite("cat", CENTER_X_PX + 16, CENTER_Y_PX + 16);
}

void init_sound()
{
    // #ifdef NINTENDO // only defined for nintendo
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    hUGE_init(&wellerman);
    add_VBL(hUGE_dosound);

    LYC_REG = 152;
    STAT_REG = 0b01000000;
    set_interrupts(VBL_IFLAG | LCD_IFLAG);
    // #endif
}

void init_ram()
{
    ENABLE_RAM; // for r/w ram address
    load_save_data();
}

void init_splash()
{
    uint8_t t_map[SCREEN_WIDTH][SCREEN_HEIGHT] = {
        {WATER, WATER, GRASS, GRASS, WATER, GRASS, GRASS, WATER, WATER},
        {GRASS, WATER, WATER, WATER, WATER, GRASS, GRASS, GRASS, WATER},
        {GRASS, GRASS, WATER, WATER, GRASS, GRASS, GRASS, GRASS, GRASS},
        {GRASS, GRASS, GRASS, GRASS, GRASS, GRASS, GRASS, GRASS, GRASS},
        {TREES, GRASS, GRASS, GRASS, GRASS, GRASS, GRASS, TREES, TREES},
        {TREES, GRASS, GRASS, GRASS, GRASS, GRASS, TREES, TREES, HILLS},
        {TREES, TREES, GRASS, GRASS, GRASS, TREES, TREES, HILLS, HILLS},
        {TREES, TREES, TREES, GRASS, GRASS, TREES, TREES, HILLS, HILLS},
        {HILLS, TREES, TREES, GRASS, GRASS, TREES, HILLS, HILLS, HILLS},
        {HILLS, TREES, TREES, GRASS, GRASS, TREES, HILLS, HILLS, HILLS},
    };
    memcpy(&map, &t_map, sizeof(map));
    display_map();
    waitpad(J_START);
    printf("loading world...");
}
