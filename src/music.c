#include "main.h"
#include "music.h"
#include "../res/hUGEDriver.h"

extern const hUGESong_t wellerman;

void init_sound()
{
    NR52_REG = 0x80;
    NR51_REG = 0xFF;
    NR50_REG = 0x77;

    hUGE_init(&wellerman);
    add_VBL(hUGE_dosound);

    LYC_REG = 152;
    STAT_REG = 0b01000000;
    set_interrupts(VBL_IFLAG | LCD_IFLAG);
}