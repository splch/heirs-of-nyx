#ifndef MAP_H_INCLUDE
#define MAP_H_INCLUDE

void remove_item(const pos_t, const pos_t);
uint8_t get_terrain(const uint8_t);
void generate_map();
void generate_map_sides();
void display_map();

#endif
