#include "main.h"
#include "../res/vocab.h"

const char *pirate_speak()
{
    return phrases[DIV_REG % phrase_len];
}
