# Pirate's Folly

Travel through procedural lands, across plains, through forests, over mountains, and around water. All the while, searching for treasure and defeating pirates.

![Game](https://slc.is/images/piratesFolly1.webp)

## File Structure

1. `src/` contains all the source code for building the game

2. `res/` contains all the visual resources in the game

3. `GBTD/` is the [tile designer](https://github.com/gbdk-2020/GBTD_GBMB/releases/) used to edit the `res/*.gbr` files

4. `build/` has the most recent ROMS for different systems

## Install

1. To play the game, move the `build/gb/Pirates Folly.gb` file into your emulator / flash cart.

2. To build it from source, follow [GBDK's guide](https://github.com/gbdk-2020/gbdk-2020#build-instructions) or use a [release](https://github.com/gbdk-2020/gbdk-2020/releases).

3. Run `export GBDK_HOME=/path/to/gbdk`

Once the environment has been built, run:

```shell
make gb
```

There should now be a new `Pirates Folly.gb` file in the `build/gb/` directory.

Alternatively, you can upload the ROM to an emulator site like @Juchi's [Gameboy emulator](https://juchi.github.io/gameboy.js/) and run it.

## This game is in development

Features:

- [x] Custom tileset
  - [ ] Color palette
- [ ] 16×16 Metasprites
- [x] Procedurally-generated map
- [x] Menu
- [x] Items
  - [x] Gold / Maps
  - [x] Weapons
  - [ ] Equipment
- [ ] Enemies
- [ ] Music

## Generation

This game uses [xorshift](https://wikipedia.org/wiki/Xorshift) noise to generate its landscapes. The algorithm is based on [Hugo Elias'](https://web.archive.org/web/20160303203643/http://freespace.virgin.net/hugo.elias/models/m_perlin.htm) tutorial.

Here is an example of the map array generated:

https://replit.com/@splch/gb-procedural-generation#main.c

Using unsigned 8-bit integers, (x, y), as seeds means that there are 2^8 x 2^8 pixels of landscape possible.

I'm using a global seed found in `main.h`, so much like No Man's Sky, everyone can see the same world; however, the starting positions can be varied.

Items and enemies will generate randomly, though, pirates will more likely gather around gold and valuables. The random spawning of items and enemies is inspired by Minecraft's similar generation as conditions need to be met for varying occurrences.
