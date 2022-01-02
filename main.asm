;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _update_position
	.globl _attack
	.globl _interact
	.globl _change_item
	.globl _add_inventory
	.globl _remove_item
	.globl _show_menu
	.globl _display_map
	.globl _generate_map_side
	.globl _generate_map
	.globl _generate_side
	.globl _shift_array_down
	.globl _shift_array_up
	.globl _shift_array_left
	.globl _shift_array_right
	.globl _is_removed
	.globl _noise
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _used_index
	.globl _p
	.globl _map
	.globl _used
	.globl _landscape
	.globl _player_sprite
	.globl _init
	.globl _update_switches
	.globl _check_input
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_used::
	.ds 510
_map::
	.ds 360
_p::
	.ds 12
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_used_index::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;utils.c:8: unsigned char noise(unsigned char x, unsigned char y) {
;	---------------------------------
; Function noise
; ---------------------------------
_noise::
;utils.c:10: x ^= (y << 7);
	ldhl	sp,	#3
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
;utils.c:11: x ^= (x >> 5);
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
;utils.c:12: y ^= (x << 3);
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
;utils.c:13: y ^= (y >> 1);
	ld	(hl), a
	srl	a
	xor	a, (hl)
;utils.c:14: return x ^ y * SEED;
	ld	(hl), a
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#2
	ld	c, (hl)
	xor	a, c
	ld	e, a
;utils.c:15: }
	ret
_player_sprite:
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x00	; 0
_landscape:
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe1	; 225
	.db #0x1e	; 30
	.db #0x30	; 48	'0'
	.db #0xcf	; 207
	.db #0x1a	; 26
	.db #0xe5	; 229
	.db #0x18	; 24
	.db #0xe7	; 231
	.db #0x19	; 25
	.db #0xe6	; 230
	.db #0x98	; 152
	.db #0x67	; 103	'g'
	.db #0x0c	; 12
	.db #0xf3	; 243
	.db #0x07	; 7
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x74	; 116	't'
	.db #0x4c	; 76	'L'
	.db #0xc2	; 194
	.db #0xbe	; 190
	.db #0x82	; 130
	.db #0xfe	; 254
	.db #0x8a	; 138
	.db #0xfe	; 254
	.db #0x6c	; 108	'l'
	.db #0x7c	; 124
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x71	; 113	'q'
	.db #0x51	; 81	'Q'
	.db #0x8b	; 139
	.db #0xfa	; 250
	.db #0x5c	; 92
	.db #0xf7	; 247
	.db #0x3e	; 62
	.db #0xe3	; 227
	.db #0x41	; 65	'A'
	.db #0xff	; 255
	.db #0x80	; 128
	.db #0xff	; 255
;utils.c:80: bool is_removed(const unsigned char x, const unsigned char y) {
;	---------------------------------
; Function is_removed
; ---------------------------------
_is_removed::
;utils.c:82: for (unsigned char i = 0; i < 255; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0xff
	jr	NC, 00104$
;utils.c:83: if (used[i][0] == x && used[i][1] == y)
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	ld	a, l
	add	a, #<(_used)
	ld	e, a
	ld	a, h
	adc	a, #>(_used)
	ld	d, a
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00107$
;utils.c:84: return true;
	ld	e, #0x01
	ret
00107$:
;utils.c:82: for (unsigned char i = 0; i < 255; i++)
	inc	c
	jr	00106$
00104$:
;utils.c:85: return false;
	ld	e, #0x00
;utils.c:86: }
	ret
;utils.c:88: void shift_array_right() {
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;utils.c:89: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ld	c, #0x13
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;utils.c:90: for (unsigned char y = 0; y < pixel_y; y++)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x12
	jr	NC, 00108$
;utils.c:91: map[x][y] = map[x - 1][y];
	pop	de
	push	de
	ld	l, b
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	dec	hl
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	de, #_map
	add	hl, de
	ld	e, b
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#2
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:90: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:89: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;utils.c:92: }
	add	sp, #4
	ret
;utils.c:94: void shift_array_left() {
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-4
;utils.c:95: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00109$
;utils.c:96: for (unsigned char y = 0; y < pixel_y; y++)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x12
	jr	NC, 00108$
;utils.c:97: map[x][y] = map[x + 1][y];
	pop	de
	push	de
	ld	l, b
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	de, #_map
	add	hl, de
	ld	e, b
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#2
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:96: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:95: for (unsigned char x = 0; x < pixel_x - 1; x++)
	inc	c
	jr	00107$
00109$:
;utils.c:98: }
	add	sp, #4
	ret
;utils.c:100: void shift_array_up() {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
;utils.c:101: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x11
	ret	NC
;utils.c:102: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:103: map[x][y] = map[x][y + 1];
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, l
	add	a, #<(_map)
	ld	e, a
	ld	a, h
	adc	a, #>(_map)
	ld	d, a
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	a, c
	inc	a
	add	a, e
	ld	e, a
	ld	a, #0x00
	adc	a, d
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;utils.c:102: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:101: for (unsigned char y = 0; y < pixel_y - 1; y++)
	inc	c
;utils.c:104: }
	jr	00107$
;utils.c:106: void shift_array_down() {
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;utils.c:107: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ld	c, #0x11
00107$:
	ld	a, c
	or	a, a
	ret	Z
;utils.c:108: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:109: map[x][y] = map[x][y - 1];
	ld	e, b
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, l
	add	a, #<(_map)
	ld	e, a
	ld	a, h
	adc	a, #>(_map)
	ld	d, a
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	a, c
	dec	a
	add	a, e
	ld	e, a
	ld	a, #0x00
	adc	a, d
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;utils.c:108: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:107: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;utils.c:110: }
	jr	00107$
;utils.c:112: void generate_side(const char side) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-14
;utils.c:116: switch (side) {
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00363$
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00331$
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00315$
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x74
	jp	Z,00347$
	jp	00266$
;utils.c:118: for (unsigned char y = 0; y < pixel_y; y++) {
00315$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00255$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00266$
;utils.c:119: _x = pixel_x - 1 + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0x09
	ldhl	sp,	#2
	ld	(hl), a
;utils.c:120: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#13
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#3
;utils.c:121: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00268$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
00268$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#4
	ld	(hl), c
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00269$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00269$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	push	bc
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:22: const unsigned char sides =
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:36: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	c
	push	bc
	push	de
	ldhl	sp,	#10
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#12
	ld	(hl), e
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
;utils.c:38: const unsigned char i1 = interpolate(v1, v2);
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	inc	c
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#11
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(hl-), a
	dec	hl
	add	a, #0xff
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	dec	b
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	c, a
	inc	c
	push	bc
	push	de
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#9
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
;utils.c:41: const unsigned char i2 = interpolate(v1, v2);
	ld	a, (hl+)
	inc	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:121: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00125$
	ld	c, #0x01
	jr	00127$
00125$:
	cp	a, #0x87
	jr	NC, 00123$
	ld	c, #0x00
	jr	00127$
00123$:
	sub	a, #0xa0
	jr	NC, 00121$
	ld	c, #0x02
	jr	00127$
00121$:
	ld	c, #0x03
00127$:
;utils.c:67: const unsigned char _n = noise(x, y);
	push	bc
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
;utils.c:122: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00143$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00143$
	ld	b, #0x01
	jr	00145$
00143$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00141$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00141$
	ld	b, #0x00
	jr	00145$
00141$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00139$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00139$
	ld	b, #0x02
	jr	00145$
00139$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00137$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00137$
	ld	b, #0x03
	jr	00145$
00137$:
	ld	b, #0xff
00145$:
;utils.c:123: map[pixel_x - 1][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ld	de, #(_map + 342)
	ldhl	sp,	#13
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00270$
	push	bc
	push	de
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00270$
	ld	a, b
	add	a, #0x40
	jr	00271$
00270$:
	ld	a, c
00271$:
	ld	(de), a
;utils.c:118: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00255$
;utils.c:127: for (unsigned char y = 0; y < pixel_y; y++) {
00331$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00258$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00266$
;utils.c:128: _x = p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0xf6
	ldhl	sp,	#2
	ld	(hl), a
;utils.c:129: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#13
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#3
;utils.c:130: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00275$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
00275$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#4
	ld	(hl), c
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00276$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00276$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	push	bc
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:36: unsigned char v1 = smooth_noise(x, y);
	ld	a, c
	add	a, b
	add	a, e
	ldhl	sp,	#10
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	c
	push	bc
	push	de
	ldhl	sp,	#10
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#12
	ld	(hl), e
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
;utils.c:38: const unsigned char i1 = interpolate(v1, v2);
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	inc	c
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#11
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(hl-), a
	dec	hl
	add	a, #0xff
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	dec	b
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	c, a
	inc	c
	push	bc
	push	de
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#9
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
;utils.c:41: const unsigned char i2 = interpolate(v1, v2);
	ld	a, (hl+)
	inc	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:130: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00161$
	ld	c, #0x01
	jr	00163$
00161$:
	cp	a, #0x87
	jr	NC, 00159$
	ld	c, #0x00
	jr	00163$
00159$:
	sub	a, #0xa0
	jr	NC, 00157$
	ld	c, #0x02
	jr	00163$
00157$:
	ld	c, #0x03
00163$:
;utils.c:67: const unsigned char _n = noise(x, y);
	push	bc
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
;utils.c:131: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00179$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00179$
	ld	b, #0x01
	jr	00181$
00179$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00177$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00177$
	ld	b, #0x00
	jr	00181$
00177$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00175$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00175$
	ld	b, #0x02
	jr	00181$
00175$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00173$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00173$
	ld	b, #0x03
	jr	00181$
00173$:
	ld	b, #0xff
00181$:
;utils.c:132: map[0][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ld	de, #_map
	ldhl	sp,	#13
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00277$
	push	bc
	push	de
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00277$
	ld	a, b
	add	a, #0x40
	jr	00278$
00277$:
	ld	a, c
00278$:
	ld	(de), a
;utils.c:127: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00258$
;utils.c:136: for (unsigned char x = 0; x < pixel_x; x++) {
00347$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00261$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00266$
;utils.c:137: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#2
;utils.c:138: _y = p.y[0] - gen_y;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0xf7
;utils.c:139: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00282$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
00282$:
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#4
	ld	(hl), c
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00283$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00283$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	push	bc
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:22: const unsigned char sides =
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	c, e
	ld	b, #0x00
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ld	a, e
	add	a, c
	ld	c, a
	ld	a, d
	adc	a, b
	ld	b, a
	push	bc
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:36: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	c
	push	bc
	push	de
	ldhl	sp,	#10
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#12
	ld	(hl), e
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
;utils.c:38: const unsigned char i1 = interpolate(v1, v2);
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	inc	c
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#11
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(hl-), a
	dec	hl
	add	a, #0xff
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	dec	b
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	c, a
	inc	c
	push	bc
	push	de
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#9
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
;utils.c:41: const unsigned char i2 = interpolate(v1, v2);
	ld	a, (hl+)
	inc	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:139: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00197$
	ld	c, #0x01
	jr	00199$
00197$:
	cp	a, #0x87
	jr	NC, 00195$
	ld	c, #0x00
	jr	00199$
00195$:
	sub	a, #0xa0
	jr	NC, 00193$
	ld	c, #0x02
	jr	00199$
00193$:
	ld	c, #0x03
00199$:
;utils.c:67: const unsigned char _n = noise(x, y);
	push	bc
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
;utils.c:140: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00215$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00215$
	ld	b, #0x01
	jr	00217$
00215$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00213$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00213$
	ld	b, #0x00
	jr	00217$
00213$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00211$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00211$
	ld	b, #0x02
	jr	00217$
00211$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00209$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00209$
	ld	b, #0x03
	jr	00217$
00209$:
	ld	b, #0xff
00217$:
;utils.c:141: map[x][0] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,	#13
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, l
	add	a, #<(_map)
	ld	e, a
	ld	a, h
	adc	a, #>(_map)
	ld	d, a
	ld	a, c
	sub	a, b
	jr	NZ, 00284$
	push	bc
	push	de
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00284$
	ld	a, b
	add	a, #0x40
	jr	00285$
00284$:
	ld	a, c
00285$:
	ld	(de), a
;utils.c:136: for (unsigned char x = 0; x < pixel_x; x++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00261$
;utils.c:145: for (unsigned char x = 0; x < pixel_x; x++) {
00363$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00264$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00266$
;utils.c:146: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#2
;utils.c:147: _y = pixel_y - 1 + p.y[0] - gen_y;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0x08
;utils.c:148: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00289$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00289$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#4
	ld	(hl), c
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00290$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00290$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	push	bc
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:22: const unsigned char sides =
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:36: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	c
	push	bc
	push	de
	ldhl	sp,	#10
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#13
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#12
	ld	(hl), e
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#6
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
;utils.c:38: const unsigned char i1 = interpolate(v1, v2);
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#12
	ld	(hl), c
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	inc	c
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#11
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	(hl-), a
	dec	hl
	add	a, #0xff
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	dec	b
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	c, a
	inc	c
	push	bc
	push	de
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#9
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
;utils.c:41: const unsigned char i2 = interpolate(v1, v2);
	ld	a, (hl+)
	inc	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:148: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00233$
	ld	c, #0x01
	jr	00235$
00233$:
	cp	a, #0x87
	jr	NC, 00231$
	ld	c, #0x00
	jr	00235$
00231$:
	sub	a, #0xa0
	jr	NC, 00229$
	ld	c, #0x02
	jr	00235$
00229$:
	ld	c, #0x03
00235$:
;utils.c:67: const unsigned char _n = noise(x, y);
	push	bc
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
;utils.c:149: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00251$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00251$
	ld	b, #0x01
	jr	00253$
00251$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00249$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00249$
	ld	b, #0x00
	jr	00253$
00249$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00247$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00247$
	ld	b, #0x02
	jr	00253$
00247$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00245$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00245$
	ld	b, #0x03
	jr	00253$
00245$:
	ld	b, #0xff
00253$:
;utils.c:150: map[x][pixel_y - 1] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,	#13
	ld	e, (hl)
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	de, #_map
	add	hl, de
	ld	de, #0x11
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00291$
	push	bc
	push	de
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00291$
	ld	a, b
	add	a, #0x40
	jr	00292$
00291$:
	ld	a, c
00292$:
	ld	(de), a
;utils.c:145: for (unsigned char x = 0; x < pixel_x; x++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00264$
;utils.c:153: }
00266$:
;utils.c:154: }
	add	sp, #14
	ret
;utils.c:156: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-17
;utils.c:158: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#15
	ld	(hl), #0x00
00143$:
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00145$
;utils.c:159: for (unsigned char y = 0; y < pixel_y; y++) {
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_map
	add	hl,bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#16
	ld	(hl), #0x00
00140$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00144$
;utils.c:160: const unsigned char _x = x + p.x[0] - gen_x;
	dec	hl
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#4
	ld	(hl), a
;utils.c:161: const unsigned char _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#16
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#5
;utils.c:162: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	dec	hl
	bit	7, (hl)
	jr	Z, 00147$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
00147$:
	ldhl	sp,#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#6
	ld	(hl), c
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00148$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00148$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#7
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
	ld	(hl-), a
	dec	hl
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	inc	a
	ldhl	sp,	#11
	ld	(hl), a
	push	bc
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:22: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	d, #0x00
	push	de
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:36: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	c
	push	bc
	push	de
	ldhl	sp,	#12
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#15
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#15
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#14
	ld	(hl), e
;utils.c:22: const unsigned char sides =
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#8
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#16
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#13
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#8
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#16
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:37: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#14
;utils.c:38: const unsigned char i1 = interpolate(v1, v2);
	ld	a, (hl-)
	dec	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	inc	c
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#15
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#13
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:19: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#12
	ld	a, (hl-)
	ld	(hl-), a
	dec	hl
	add	a, #0xff
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	dec	b
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	c, a
	inc	c
	push	bc
	push	de
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	ldhl	sp,	#14
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#11
;utils.c:22: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	de
	ldhl	sp,	#14
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	de
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:25: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
;utils.c:41: const unsigned char i2 = interpolate(v1, v2);
	ld	a, (hl+)
	inc	hl
	add	a, c
	add	a, e
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:60: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:162: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00118$
	ldhl	sp,	#14
	ld	(hl), #0x01
	jr	00120$
00118$:
	cp	a, #0x87
	jr	NC, 00116$
	ldhl	sp,	#14
	ld	(hl), #0x00
	jr	00120$
00116$:
	sub	a, #0xa0
	jr	NC, 00114$
	ldhl	sp,	#14
	ld	(hl), #0x02
	jr	00120$
00114$:
	ldhl	sp,	#14
	ld	(hl), #0x03
00120$:
	ldhl	sp,	#14
	ld	c, (hl)
;utils.c:67: const unsigned char _n = noise(x, y);
	push	bc
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
;utils.c:163: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00136$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00136$
	ld	b, #0x01
	jr	00138$
00136$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00134$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00134$
	ld	b, #0x00
	jr	00138$
00134$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00132$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00132$
	ld	b, #0x02
	jr	00138$
00132$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00130$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00130$
	ld	b, #0x03
	jr	00138$
00130$:
	ld	b, #0xff
00138$:
;utils.c:164: map[x][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00149$
	push	bc
	push	de
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00149$
	ld	a, b
	add	a, #0x40
	jr	00150$
00149$:
	ld	a, c
00150$:
	ld	(de), a
;utils.c:159: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#16
	inc	(hl)
	jp	00140$
00144$:
;utils.c:158: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#15
	inc	(hl)
	jp	00143$
00145$:
;utils.c:166: }
	add	sp, #17
	ret
;utils.c:168: void generate_map_side() {
;	---------------------------------
; Function generate_map_side
; ---------------------------------
_generate_map_side::
;utils.c:169: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #_p
	ld	c, (hl)
	ld	a, (#(_p + 1) + 0)
	sub	a, c
	ld	c, a
;utils.c:170: const char diff_y = p.y[1] - p.y[0];
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	a, (#(_p + 3) + 0)
	sub	a, b
	ld	b, a
;utils.c:171: if (diff_x < 0) {
	bit	7, c
	jr	Z, 00104$
;utils.c:173: shift_array_left();
	push	bc
	call	_shift_array_left
	ld	a, #0x72
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	pop	bc
	jr	00105$
00104$:
;utils.c:175: } else if (diff_x > 0) {
	ld	e, c
	xor	a, a
	ld	d, a
	sub	a, c
	bit	7, e
	jr	Z, 00133$
	bit	7, d
	jr	NZ, 00134$
	cp	a, a
	jr	00134$
00133$:
	bit	7, d
	jr	Z, 00134$
	scf
00134$:
	jr	NC, 00105$
;utils.c:177: shift_array_right();
	push	bc
	call	_shift_array_right
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	pop	bc
00105$:
;utils.c:180: if (diff_y > 0) {
	ld	e, b
	xor	a, a
	ld	d, a
	sub	a, b
	bit	7, e
	jr	Z, 00135$
	bit	7, d
	jr	NZ, 00136$
	cp	a, a
	jr	00136$
00135$:
	bit	7, d
	jr	Z, 00136$
	scf
00136$:
	jr	NC, 00109$
;utils.c:182: shift_array_down();
	call	_shift_array_down
;utils.c:183: generate_side('t');
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	jr	00110$
00109$:
;utils.c:184: } else if (diff_y < 0) {
	bit	7, b
	jr	Z, 00110$
;utils.c:186: shift_array_up();
	call	_shift_array_up
;utils.c:187: generate_side('b');
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	inc	sp
00110$:
;utils.c:190: p.x[1] = p.x[0];
	ld	a, (#_p + 0)
	ld	(#(_p + 1)),a
;utils.c:191: p.y[1] = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ld	(#(_p + 3)),a
;utils.c:192: }
	ret
;utils.c:194: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:195: for (unsigned char i = 0; i < pixel_x; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;utils.c:196: set_bkg_tiles(i, 0, 1, pixel_y, map[i]);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	de, #_map
	add	hl, de
	push	hl
	ld	hl, #0x1201
	push	hl
	xor	a, a
	ld	b, a
	push	bc
	call	_set_bkg_tiles
	add	sp, #6
;utils.c:195: for (unsigned char i = 0; i < pixel_x; i++)
	inc	c
	jr	00103$
00101$:
;utils.c:197: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;utils.c:198: }
	ret
;utils.c:200: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
;utils.c:202: display_map();
	call	_display_map
;utils.c:203: HIDE_SPRITES; // menu is open
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:204: const unsigned char x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0x81
	ldhl	sp,	#2
;utils.c:205: const unsigned char y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0x81
	ld	(hl), a
;utils.c:206: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 10) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:207: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 11) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:208: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
	ld	a, (#(_p + 9) + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (#(_p + 8) + 0)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	push	bc
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #6
;utils.c:210: printf("\n\n\tposition:\t(%u, %u)", x, y);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	e, a
	ld	d, #0x00
	ld	c, (hl)
	ld	b, #0x00
	push	de
	push	bc
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #6
;utils.c:211: printf("\n\tsteps:\t%u", p.steps);
	ld	de, #(_p + 4)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #6
;utils.c:212: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:214: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	a, (#_p + 0)
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	d, #0x00
	push	de
	ld	de, #___str_6
	push	de
	call	_printf
;utils.c:215: }
	add	sp, #8
	ret
___str_0:
	.db 0x0a
	.db 0x09
	.ascii "gold:"
	.db 0x09
	.ascii "%u"
	.db 0x00
___str_1:
	.db 0x0a
	.db 0x09
	.ascii "maps:"
	.db 0x09
	.ascii "%u"
	.db 0x00
___str_2:
	.db 0x0a
	.db 0x09
	.ascii "weapons:"
	.db 0x09
	.ascii "%d"
	.db 0x09
	.ascii "%d"
	.db 0x00
___str_3:
	.db 0x0a
	.db 0x0a
	.db 0x09
	.ascii "position:"
	.db 0x09
	.ascii "(%u, %u)"
	.db 0x00
___str_4:
	.db 0x0a
	.db 0x09
	.ascii "steps:"
	.db 0x09
	.ascii "%u"
	.db 0x00
___str_5:
	.db 0x0a
	.db 0x09
	.ascii "seed:"
	.db 0x09
	.ascii "%u"
	.db 0x00
___str_6:
	.db 0x0a
	.db 0x0a
	.db 0x09
	.ascii "random:"
	.db 0x09
	.ascii "%u"
	.db 0x00
;utils.c:217: void remove_item(const unsigned char x, unsigned char y) {
;	---------------------------------
; Function remove_item
; ---------------------------------
_remove_item::
;utils.c:219: used[used_index][0] = x;
	ld	bc, #_used+0
	ld	hl, #_used_index
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;utils.c:220: used[used_index][1] = y;
	ld	hl, #_used_index
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, bc
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(bc), a
;utils.c:221: used_index++;
	ld	hl, #_used_index
	inc	(hl)
;utils.c:222: }
	ret
;utils.c:224: void add_inventory(const unsigned char item) {
;	---------------------------------
; Function add_inventory
; ---------------------------------
_add_inventory::
;utils.c:226: if (p.weapons[0] == -1) {
	ld	bc, #_p + 8
	ld	a, (bc)
	inc	a
	jr	NZ, 00102$
;utils.c:227: p.weapons[0] = item;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	ret
00102$:
;utils.c:229: p.weapons[1] = item;
	ld	de, #(_p + 9)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;utils.c:231: }
	ret
;utils.c:233: void change_item() {
;	---------------------------------
; Function change_item
; ---------------------------------
_change_item::
;utils.c:234: const char _w = p.weapons[0];
	ld	hl, #_p + 8
	ld	c, (hl)
;utils.c:235: p.weapons[0] = p.weapons[1];
	ld	de, #_p + 9
	ld	a, (de)
	ld	(hl), a
;utils.c:236: p.weapons[1] = _w;
	ld	a, c
	ld	(de), a
;utils.c:237: }
	ret
;utils.c:239: void interact() {
;	---------------------------------
; Function interact
; ---------------------------------
_interact::
	add	sp, #-6
;utils.c:244: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#4
	ld	(hl), #0xfe
00109$:
	ldhl	sp,	#4
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00140$
	bit	7, d
	jr	NZ, 00141$
	cp	a, a
	jr	00141$
00140$:
	bit	7, d
	jr	Z, 00141$
	scf
00141$:
	jp	C, 00111$
;utils.c:245: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, #0x0a
	ld	c, a
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_map
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	(hl), #0xfd
00106$:
	ldhl	sp,	#5
	ld	e, (hl)
	ld	a,#0xff
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00142$
	bit	7, d
	jr	NZ, 00143$
	cp	a, a
	jr	00143$
00142$:
	bit	7, d
	jr	Z, 00143$
	scf
00143$:
	jr	C, 00110$
;utils.c:247: const unsigned char pos_y = y + center_y / sprite_size;
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x09
;utils.c:248: const unsigned char item = map[pos_x][pos_y];
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ldhl	sp,	#2
;utils.c:249: if (item >= 64) {
	ld	(hl), a
	sub	a, #0x40
	jr	C, 00107$
;utils.c:250: add_inventory(item);
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	call	_add_inventory
	inc	sp
	pop	bc
;utils.c:251: remove_item(x + p.x[0], y + p.y[0]);
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#5
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	ld	a, (#_p + 0)
	add	a, (hl)
	dec	hl
	push	bc
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_remove_item
	pop	hl
	pop	bc
;utils.c:253: map[pos_x][pos_y] = item - 64;
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0xc0
	pop	hl
	push	hl
	ld	(hl), a
;utils.c:254: display_map();
	push	bc
	call	_display_map
	pop	bc
00107$:
;utils.c:245: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#5
	inc	(hl)
	jr	00106$
00110$:
;utils.c:244: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#4
	inc	(hl)
	jp	00109$
00111$:
;utils.c:257: }
	add	sp, #6
	ret
;utils.c:259: void attack() {}
;	---------------------------------
; Function attack
; ---------------------------------
_attack::
	ret
;utils.c:261: void update_position(unsigned char j) {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-8
;utils.c:262: bool update = false;
	ldhl	sp,	#4
	ld	(hl), #0x00
;utils.c:263: unsigned char _x = p.x[0];
	ld	a, (#_p + 0)
	ldhl	sp,	#6
	ld	(hl), a
;utils.c:264: unsigned char _y = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;utils.c:265: if (j & J_RIGHT)
	ldhl	sp,	#10
	ld	c, (hl)
	bit	0, c
	jr	Z, 00104$
;utils.c:266: _x++;
	ldhl	sp,	#6
	inc	(hl)
	jr	00105$
00104$:
;utils.c:267: else if (j & J_LEFT)
	bit	1, c
	jr	Z, 00105$
;utils.c:268: _x--;
	ldhl	sp,	#6
	dec	(hl)
00105$:
;utils.c:269: if (j & J_UP)
	bit	2, c
	jr	Z, 00109$
;utils.c:270: _y--;
	ldhl	sp,	#7
	dec	(hl)
	jr	00110$
00109$:
;utils.c:271: else if (j & J_DOWN)
	bit	3, c
	jr	Z, 00110$
;utils.c:272: _y++;
	ldhl	sp,	#7
	inc	(hl)
00110$:
;utils.c:273: if (_x != p.x[0]) {
	ld	hl, #_p
	ld	c, (hl)
;utils.c:276: p.steps++;
;utils.c:273: if (_x != p.x[0]) {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	jr	Z, 00114$
;utils.c:274: p.x[1] = p.x[0];
	ld	hl, #(_p + 1)
	ld	(hl), c
;utils.c:275: p.x[0] = _x;
	ld	de, #_p
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;utils.c:276: p.steps++;
	ld	de, #(_p + 4)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	hl
	pop	de
	push	de
	ld	a, e
	add	a, #0x01
	ld	e, a
	ld	a, d
	adc	a, #0x00
	push	af
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	ld	a, e
	adc	a, #0x00
	ld	e, a
	ld	a, d
	adc	a, #0x00
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	de, #(_p + 4)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:277: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
	jr	00115$
00114$:
;utils.c:278: } else if (_y != p.y[0]) {
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	Z, 00115$
;utils.c:281: p.y[1] = p.y[0];
	ld	de, #(_p + 3)
	ldhl	sp,	#5
;utils.c:282: p.y[0] = _y;
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #(_p + 2)
	ld	a, (hl)
	ld	(de), a
;utils.c:283: p.steps++;
	ld	de, #(_p + 4)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	hl
	pop	de
	push	de
	ld	a, e
	add	a, #0x01
	ld	e, a
	ld	a, d
	adc	a, #0x00
	push	af
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	af
	ld	a, e
	adc	a, #0x00
	ld	e, a
	ld	a, d
	adc	a, #0x00
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	de, #(_p + 4)
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:284: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
00115$:
;utils.c:286: if (update) {
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
;utils.c:287: generate_map_side();
	call	_generate_map_side
;utils.c:288: display_map();
	call	_display_map
00118$:
;utils.c:290: }
	add	sp, #8
	ret
;main.c:12: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:13: init();
	call	_init
;main.c:15: while (1) {
00102$:
;main.c:16: check_input();     // Check for user input (and act on it)
	call	_check_input
;main.c:17: update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
	call	_update_switches
;main.c:19: wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;main.c:21: }
	jr	00102$
;main.c:23: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:24: DISPLAY_ON; // Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:26: font_init();                   // Initialize font
	call	_font_init
;main.c:27: font_set(font_load(font_ibm)); // Set and load the font
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;main.c:30: set_bkg_data(0, 4, landscape);
	ld	de, #_landscape
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:33: set_sprite_data(0, 0, player_sprite);
	ld	de, #_player_sprite
	push	de
	xor	a, a
	rrca
	push	af
	call	_set_sprite_data
	add	sp, #4
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1399: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1400: itm->y=y, itm->x=x;
	ld	a, #0x48
	ld	(hl+), a
	ld	(hl), #0x50
;main.c:43: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	hl, #(_p + 3)
	ld	(hl), #0x7f
	ld	hl, #(_p + 2)
	ld	(hl), #0x7f
	ld	hl, #(_p + 1)
	ld	(hl), #0x7f
	ld	hl, #_p
	ld	(hl), #0x7f
;main.c:46: p.steps = p.gold = p.maps = 0;
	ld	hl, #(_p + 11)
	ld	(hl), #0x00
	ld	hl, #(_p + 10)
	ld	(hl), #0x00
	ld	hl, #(_p + 4)
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:47: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 9)
	ld	(hl), #0xff
	ld	hl, #(_p + 8)
	ld	(hl), #0xff
;main.c:50: printf("\n\tWelcome to\n\tPirate's Folly");
	ld	de, #___str_7
	push	de
	call	_printf
	pop	hl
;main.c:54: generate_map();
	call	_generate_map
;main.c:57: display_map();
;main.c:58: }
	jp	_display_map
___str_7:
	.db 0x0a
	.db 0x09
	.ascii "Welcome to"
	.db 0x0a
	.db 0x09
	.ascii "Pirate's Folly"
	.db 0x00
;main.c:60: void update_switches() {
;	---------------------------------
; Function update_switches
; ---------------------------------
_update_switches::
;main.c:61: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;main.c:62: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:63: }
	ret
;main.c:65: void check_input() {
;	---------------------------------
; Function check_input
; ---------------------------------
_check_input::
;main.c:66: const unsigned char j = joypad();
	call	_joypad
	ld	b, e
;main.c:67: if (j & J_START)
	bit	7, b
	jr	Z, 00102$
;main.c:68: show_menu();
	push	bc
	call	_show_menu
	pop	bc
00102$:
;main.c:69: if (j & J_SELECT)
	bit	6, b
	jr	Z, 00104$
;main.c:70: change_item();
	push	bc
	call	_change_item
	pop	bc
00104$:
;main.c:71: if (j & J_A)
	bit	4, b
	jr	Z, 00106$
;main.c:72: interact();
	push	bc
	call	_interact
	pop	bc
00106$:
;main.c:73: if (j & J_B)
	bit	5, b
	jr	Z, 00108$
;main.c:74: attack();
	push	bc
	call	_attack
	pop	bc
00108$:
;main.c:75: if (j)
	ld	a, b
	or	a, a
	ret	Z
;main.c:76: update_position(j);
	push	bc
	inc	sp
	call	_update_position
	inc	sp
;main.c:77: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__used_index:
	.db #0x00	; 0
	.area _CABS (ABS)
