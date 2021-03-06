#ifndef PLAYER_H_INCLUDE
#define PLAYER_H_INCLUDE

void load_sprite(char *);
void position_sprite(char *, uint8_t, uint8_t);
void reset_sprites();
void check_interaction(const uint8_t);
void adjust_position(const uint8_t, const uint8_t, const uint8_t);
void check_movement(const uint8_t);

#endif
