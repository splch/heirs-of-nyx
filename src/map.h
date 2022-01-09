#ifndef MAP
#define MAP

void remove_item(const uint8_t, const uint8_t);
void generate_map();
void generate_map_sides();
void display_map();

// used[used_index][x,y]
extern uint16_t used[256];
extern uint8_t used_index;

#endif
