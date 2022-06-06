#include "main.h"
#include "noise.h"
#include "../res/vocab.h"

const char *pirate_speak()
{
    return phrases[prng(p.x[0], p.y[0]) % phrase_len];
}
