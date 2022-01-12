# Pirate's Folly

Travel through vast procedural lands (1,000+ Km^2), over mountains, through forests, across plains, and around water. All the while, searching for treasure and defeating pirates.

![Game](https://slc.is/images/piratesFolly2.webp)

## Install

1. To play the game, move the `pirates_folly.uf2` file into your Raspberry Pi Pico storage.

2. To build it from source, follow [PicoSystem's Guide](https://learn.pimoroni.com/article/getting-started-with-picosystem-and-c++).

Once the SDKs have been built, run:

```shell
chmod +x build.sh
./build.sh
```

There should now be a new `pirates_folly.uf2` file in the directory.

## This game is in development

Changes:
- [x] Procedurally-generated map
- [ ] Items
  - [x] Gold
  - [x] Weapons
  - [ ] Equipment
- [ ] Enemies
- [x] Menu
- [ ] New tileset

## Generation

This game uses Perlin noise to generate its landscapes. The algorithm is based on [Hugo Elias'](https://web.archive.org/web/20160303203643/http://freespace.virgin.net/hugo.elias/models/m_perlin.htm) tutorial.

Using unsigned 32-bit integers, (x, y), as seeds means that there are 2^32 x 2^32 pixels of landscape possible. This means that there are over 1,116 square kilometers of land to cover. Walking from one end of the world to the other would take around 20 years straight (you travel a pixel every 150 ms).

I'm using a global seed found in `main.hpp`, so much like No Man's Sky, everyone can see the same world; however, the starting positions can be varied.

Items and enemies will generate randomly, though, pirates will more likely gather around gold and valuables. The random spawning of items and enemies is inspired by Minecraft's similar generation as conditions need to be met for varying occurrences.
