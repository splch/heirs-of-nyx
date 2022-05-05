#ifndef UTILS
#define UTILS

void load_save_data();
void generate_map();
void display_map();
void load_sprite(char *);
void position_sprite(char *, uint8_t, uint8_t);
void show_menu();
void change_item();
void interact();
void attack();
void check_interaction(const uint8_t);
void check_movement(const uint8_t);

#endif
