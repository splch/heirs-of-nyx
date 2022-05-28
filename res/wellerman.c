#include "hUGEDriver.h"
#include <stddef.h>

static const unsigned char order_cnt = 2;

static const unsigned char P0[] = {
    DN(As3,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(C_4,1,0x000),
    DN(C_4,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(Ds4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(Gs4,1,0x000),
    DN(___,1,0x000),
    DN(F_4,1,0x000),
    DN(F_4,1,0x000),
    DN(F_4,1,0x000),
    DN(___,1,0x000),
    DN(F_4,1,0x000),
    DN(G_4,1,0x000),
    DN(Gs4,1,0x000),
    DN(C_5,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(Ds4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(G_4,1,0x000),
    DN(___,1,0x000),
    DN(F_4,1,0x000),
    DN(___,1,0x000),
    DN(Ds4,1,0x000),
    DN(___,1,0x000),
    DN(D_4,1,0x000),
    DN(___,1,0x000),
    DN(C_4,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
};
static const unsigned char P1[] = {
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
    DN(___,1,0x000),
};
static const unsigned char P2[] = {
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
    DN(___,5,0x000),
};

static const unsigned char* const order1[] = {P0};
static const unsigned char* const order2[] = {P1};
static const unsigned char* const order3[] = {P2};
static const unsigned char* const order4[] = {P1};

static const unsigned char duty_instruments[] = {
8,0,240,128,
8,64,240,128,
8,128,240,128,
8,192,240,128,
8,0,241,128,
8,64,241,128,
8,128,241,128,
8,192,241,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
8,128,240,128,
};
static const unsigned char wave_instruments[] = {
0,32,0,128,
0,32,1,128,
0,32,2,128,
0,32,3,128,
0,32,4,128,
0,32,5,128,
0,32,6,128,
0,32,7,128,
0,32,8,128,
0,32,9,128,
0,32,10,128,
0,32,11,128,
0,32,12,128,
0,32,13,128,
0,32,14,128,
};
static const unsigned char noise_instruments[] = {
240,64,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
240,0,0,0,0,0,0,0,
};

static const unsigned char waves[] = {
    0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
    0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,
    0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,
    0,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239,
    254,220,186,152,118,84,50,16,18,52,86,120,154,188,222,255,
    122,205,219,117,33,19,104,189,220,151,65,1,71,156,221,184,
    15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,
    254,252,250,248,246,244,242,240,242,244,246,248,250,252,254,255,
    254,221,204,187,170,153,136,119,138,189,241,36,87,138,189,238,
    132,17,97,237,87,71,90,173,206,163,23,121,221,32,3,71,
    96,104,5,81,230,62,194,150,211,206,237,210,119,188,215,148,
    149,180,208,140,122,46,102,126,171,189,146,109,22,212,154,71,
    114,62,229,201,163,64,222,227,120,102,182,204,146,131,44,165,
    151,222,38,210,189,187,78,1,126,116,12,180,204,233,2,102,
    221,51,1,14,172,114,114,18,70,185,104,70,136,129,158,26,
};

const hUGESong_t wellerman = {10, &order_cnt, order1, order2, order3,order4, duty_instruments, wave_instruments, noise_instruments, NULL, waves};
