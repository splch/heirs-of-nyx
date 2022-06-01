# Pirate's Folly

Pirates once circled the world's waters, commanding the seas and seizing its bounty. But the tides of fortune shifted when they began hunting for Greek treasure. Hidden within the island of Crete, Pandora's infamous box lurked, but it appeared pure and tempting like a small case of jewels. The pirates greedily opened this box, and Pandora's evils poured across the land.

Travel through vast terrains, searching for ancient evils while defeating pirates, forming friendships, and plundering treasures. Restore peace, so trade routes prosper and provide livelihood for hardworking thieving pirates.

![Game](https://user-images.githubusercontent.com/25377399/171068749-1d08ecc7-fb5a-4da0-88fe-a23ad7738371.png)

## File Structure

1. `src/` contains source code for building the game

2. `res/` stores visual resources in the game

3. `tools/` clones various development tools:
  - [tile designer](https://github.com/gbdk-2020/GBTD_GBMB/releases/) to edit the `res/*.gbr` files
  - [emulicious](https://emulicious.net/) to run the gameboy rom.
  - [hUGETracker](https://nickfa.ro/index.php/HUGETracker) to edit `res/wellerman.uge`
  - [romusage](https://github.com/bbbbbr/romusage) to view the gameboy rom space `./romusage game.map -gA`

```shell
Bank           Range             Size   Used   Used%  Free   Free% 
----------     ----------------  -----  -----  -----  -----  -----
ROM            0x0000 -> 0x3FFF  16384  16002    97%    382     2% |░███████████████████████████|
ROM_0          0x4000 -> 0x7FFF  16384   9399    57%   6985    42% |████████████████____________|
WRAM           0xC000 -> 0xCFFF   4096    792    19%   3304    80% |_▓████▒_____________________|
```

4. `build/` has the most recent ROMS for different systems

## Install

1. To play the game, move the release or `build/gb/Pirates Folly.gb` ROM into your emulator / flash cart.

2. To build it from source, follow [GBDK's guide](https://github.com/gbdk-2020/gbdk-2020#build-instructions).

3. Run `export GBDK_HOME=/path/to/gbdk-2020`

Once the environment has been built, run:

```shell
make gb
```

There should now be a new `Pirates Folly.gb` file in the `build/gb/` directory.

Alternatively, you can upload the ROM to an emulator site like @Juchi's [GameBoy emulator](https://juchi.github.io/gameboy.js/) and run it. To use `Emulicious.jar`, install the Java runtime (`openjdk-*-jre`) and run `java -jar Emulicious.jar`.

## This game is in development

Features:

- [x] Custom tileset
  - [ ] Color palette
  - [x] SuperGameBoy Background
- [x] 16×16 Metatiles (sprites and backgrounds)
- [x] Procedurally-generated map
  - [ ] 16-bit generation
- [x] Menu
- [x] Items
  - [x] Gold / Maps
  - [x] Weapons
  - [ ] Equipment
- [ ] Enemies
- [x] Music

## Generation

This game uses [xorshift](https://wikipedia.org/wiki/Xorshift) noise to generate its landscapes. The algorithm is based on [Hugo Elias'](https://web.archive.org/web/20160303203643/http://freespace.virgin.net/hugo.elias/models/m_perlin.htm) tutorial.

Here is an example of the map array generated:

https://replit.com/@splch/gb-procedural-generation#main.c

Using unsigned 8-bit integers, (x, y), as seeds means that there are 2^8 x 2^8 pixels of landscape possible.

I'm using a global seed found in `prng.s`, so much like No Man's Sky, everyone can see the same world; however, the starting positions can be varied. Additionally, everything from enemies to items are spawned via the same algorithm. This is useful since optimizing `prng.s` further will lead to an entirely faster game.

Please enjoy the grand adventure this game offers in only 32KB!
