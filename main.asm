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
	.globl _gb_decompress_sprite_data
	.globl _gb_decompress_bkg_data
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
	.globl _printf
	.globl _set_bkg_tiles
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
;utils.c:79: bool is_removed(const unsigned char x, const unsigned char y) {
;	---------------------------------
; Function is_removed
; ---------------------------------
_is_removed::
;utils.c:81: for (unsigned char i = 0; i < 255; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0xff
	jr	NC, 00104$
;utils.c:82: if (used[i][0] == x && used[i][1] == y)
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
;utils.c:83: return true;
	ld	e, #0x01
	ret
00107$:
;utils.c:81: for (unsigned char i = 0; i < 255; i++)
	inc	c
	jr	00106$
00104$:
;utils.c:84: return false;
	ld	e, #0x00
;utils.c:85: }
	ret
_player_sprite:
	.db #0x02	; 2
	.db #0x38	; 56	'8'
	.db #0xc8	; 200
	.db #0x10	; 16
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x02	; 2
	.db #0x28	; 40
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
_landscape:
	.db #0xc2	; 194
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0xf9	; 249
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
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
;utils.c:87: void shift_array_right() {
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;utils.c:88: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ld	c, #0x13
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;utils.c:89: for (unsigned char y = 0; y < pixel_y; y++)
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
;utils.c:90: map[x][y] = map[x - 1][y];
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
;utils.c:89: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:88: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;utils.c:91: }
	add	sp, #4
	ret
;utils.c:93: void shift_array_left() {
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-4
;utils.c:94: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00109$
;utils.c:95: for (unsigned char y = 0; y < pixel_y; y++)
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
;utils.c:96: map[x][y] = map[x + 1][y];
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
;utils.c:95: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:94: for (unsigned char x = 0; x < pixel_x - 1; x++)
	inc	c
	jr	00107$
00109$:
;utils.c:97: }
	add	sp, #4
	ret
;utils.c:99: void shift_array_up() {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
;utils.c:100: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x11
	ret	NC
;utils.c:101: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:102: map[x][y] = map[x][y + 1];
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
;utils.c:101: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:100: for (unsigned char y = 0; y < pixel_y - 1; y++)
	inc	c
;utils.c:103: }
	jr	00107$
;utils.c:105: void shift_array_down() {
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;utils.c:106: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ld	c, #0x11
00107$:
	ld	a, c
	or	a, a
	ret	Z
;utils.c:107: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:108: map[x][y] = map[x][y - 1];
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
;utils.c:107: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:106: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;utils.c:109: }
	jr	00107$
;utils.c:111: void generate_side(const char side) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-17
;utils.c:115: switch (side) {
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00511$
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00479$
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00463$
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x74
	jp	Z,00495$
	jp	00414$
;utils.c:117: for (unsigned char y = 0; y < pixel_y; y++) {
00463$:
	ldhl	sp,	#16
	ld	(hl), #0x00
00403$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00414$
;utils.c:118: _x = pixel_x - 1 + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0x09
	ldhl	sp,	#3
	ld	(hl), a
;utils.c:119: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#16
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#4
;utils.c:120: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#11
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
	jr	Z, 00416$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
00416$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00417$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00417$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#10
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#5
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#10
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
	ldhl	sp,	#7
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl+), a
	inc	hl
	ld	a, c
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#9
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#2
	xor	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:40: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#8
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
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#7
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
;utils.c:120: const unsigned char _t = terrain(_x, _y);
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
;utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	b, a
	ld	e, b
;utils.c:121: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, b
	jr	NC, 00180$
	ld	a, b
	sub	a, #0x33
	jr	NC, 00180$
	ld	b, #0x01
	jr	00182$
00180$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00178$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00178$
	ld	b, #0x00
	jr	00182$
00178$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00176$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00176$
	ld	b, #0x02
	jr	00182$
00176$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00174$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00174$
	ld	b, #0x03
	jr	00182$
00174$:
	ld	b, #0xff
00182$:
;utils.c:122: map[pixel_x - 1][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ld	de, #(_map + 342)
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00418$
	push	bc
	push	de
	ldhl	sp,	#8
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
	jr	NZ, 00418$
	ld	a, b
	add	a, #0x40
	jr	00419$
00418$:
	ld	a, c
00419$:
	ld	(de), a
;utils.c:117: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#16
	inc	(hl)
	jp	00403$
;utils.c:126: for (unsigned char y = 0; y < pixel_y; y++) {
00479$:
	ldhl	sp,	#16
	ld	(hl), #0x00
00406$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00414$
;utils.c:127: _x = p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0xf6
	ldhl	sp,	#3
	ld	(hl), a
;utils.c:128: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#16
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#4
;utils.c:129: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#11
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
	jr	Z, 00423$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
00423$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00424$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00424$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#10
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#5
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#10
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
	ldhl	sp,	#7
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	c, a
	dec	c
	ld	e, c
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, c
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	b, l
	ld	e, h
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	sra	e
	rr	b
	ldhl	sp,	#13
	ld	(hl), b
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, c
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, c
	ld	c, a
	srl	a
	xor	a, c
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#9
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#2
	xor	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:40: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#8
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
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#7
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
;utils.c:129: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00234$
	ld	c, #0x01
	jr	00236$
00234$:
	cp	a, #0x87
	jr	NC, 00232$
	ld	c, #0x00
	jr	00236$
00232$:
	sub	a, #0xa0
	jr	NC, 00230$
	ld	c, #0x02
	jr	00236$
00230$:
	ld	c, #0x03
00236$:
;utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	b, a
	ld	e, b
;utils.c:130: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, b
	jr	NC, 00253$
	ld	a, b
	sub	a, #0x33
	jr	NC, 00253$
	ld	b, #0x01
	jr	00255$
00253$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00251$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00251$
	ld	b, #0x00
	jr	00255$
00251$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00249$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00249$
	ld	b, #0x02
	jr	00255$
00249$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00247$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00247$
	ld	b, #0x03
	jr	00255$
00247$:
	ld	b, #0xff
00255$:
;utils.c:131: map[0][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ld	de, #_map
	ldhl	sp,	#16
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00425$
	push	bc
	push	de
	ldhl	sp,	#8
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
	jr	NZ, 00425$
	ld	a, b
	add	a, #0x40
	jr	00426$
00425$:
	ld	a, c
00426$:
	ld	(de), a
;utils.c:126: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#16
	inc	(hl)
	jp	00406$
;utils.c:135: for (unsigned char x = 0; x < pixel_x; x++) {
00495$:
	ldhl	sp,	#16
	ld	(hl), #0x00
00409$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00414$
;utils.c:136: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#3
;utils.c:137: _y = p.y[0] - gen_y;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0xf7
;utils.c:138: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#11
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
	jr	Z, 00430$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
00430$:
	ldhl	sp,#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00431$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00431$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#10
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#5
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#10
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
	ldhl	sp,	#7
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl+), a
	inc	hl
	ld	a, c
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#9
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#2
	xor	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:40: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#8
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
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#7
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
;utils.c:138: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00307$
	ld	c, #0x01
	jr	00309$
00307$:
	cp	a, #0x87
	jr	NC, 00305$
	ld	c, #0x00
	jr	00309$
00305$:
	sub	a, #0xa0
	jr	NC, 00303$
	ld	c, #0x02
	jr	00309$
00303$:
	ld	c, #0x03
00309$:
;utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	b, a
	ld	e, b
;utils.c:139: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, b
	jr	NC, 00326$
	ld	a, b
	sub	a, #0x33
	jr	NC, 00326$
	ld	b, #0x01
	jr	00328$
00326$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00324$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00324$
	ld	b, #0x00
	jr	00328$
00324$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00322$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00322$
	ld	b, #0x02
	jr	00328$
00322$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00320$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00320$
	ld	b, #0x03
	jr	00328$
00320$:
	ld	b, #0xff
00328$:
;utils.c:140: map[x][0] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,	#16
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
	jr	NZ, 00432$
	push	bc
	push	de
	ldhl	sp,	#8
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
	jr	NZ, 00432$
	ld	a, b
	add	a, #0x40
	jr	00433$
00432$:
	ld	a, c
00433$:
	ld	(de), a
;utils.c:135: for (unsigned char x = 0; x < pixel_x; x++) {
	ldhl	sp,	#16
	inc	(hl)
	jp	00409$
;utils.c:144: for (unsigned char x = 0; x < pixel_x; x++) {
00511$:
	ldhl	sp,	#16
	ld	(hl), #0x00
00412$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00414$
;utils.c:145: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#3
;utils.c:146: _y = pixel_y - 1 + p.y[0] - gen_y;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0x08
;utils.c:147: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00437$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00437$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00438$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00438$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#14
	ld	(hl), c
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#10
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#12
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#5
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#12
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#10
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
	ldhl	sp,	#7
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl+), a
	inc	hl
	ld	a, c
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#13
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#9
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#2
	xor	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#13
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:40: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#8
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
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#7
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
;utils.c:147: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00380$
	ld	c, #0x01
	jr	00382$
00380$:
	cp	a, #0x87
	jr	NC, 00378$
	ld	c, #0x00
	jr	00382$
00378$:
	sub	a, #0xa0
	jr	NC, 00376$
	ld	c, #0x02
	jr	00382$
00376$:
	ld	c, #0x03
00382$:
;utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	b, a
	ld	e, b
;utils.c:148: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, b
	jr	NC, 00399$
	ld	a, b
	sub	a, #0x33
	jr	NC, 00399$
	ld	b, #0x01
	jr	00401$
00399$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00397$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00397$
	ld	b, #0x00
	jr	00401$
00397$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00395$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00395$
	ld	b, #0x02
	jr	00401$
00395$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00393$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00393$
	ld	b, #0x03
	jr	00401$
00393$:
	ld	b, #0xff
00401$:
;utils.c:149: map[x][pixel_y - 1] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,	#16
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
	jr	NZ, 00439$
	push	bc
	push	de
	ldhl	sp,	#8
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
	jr	NZ, 00439$
	ld	a, b
	add	a, #0x40
	jr	00440$
00439$:
	ld	a, c
00440$:
	ld	(de), a
;utils.c:144: for (unsigned char x = 0; x < pixel_x; x++) {
	ldhl	sp,	#16
	inc	(hl)
	jp	00412$
;utils.c:152: }
00414$:
;utils.c:153: }
	add	sp, #17
	ret
;utils.c:155: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-20
;utils.c:157: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#18
	ld	(hl), #0x00
00180$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00182$
;utils.c:158: for (unsigned char y = 0; y < pixel_y; y++) {
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
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#19
	ld	(hl), #0x00
00177$:
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00181$
;utils.c:159: const unsigned char _x = x + p.x[0] - gen_x;
	dec	hl
	ld	a, (#_p + 0)
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#5
	ld	(hl), a
;utils.c:160: const unsigned char _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#19
	add	a, (hl)
	add	a, #0xf7
	ldhl	sp,	#6
;utils.c:161: const unsigned char _t = terrain(_x, _y);
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#13
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
	jr	Z, 00184$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
00184$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ldhl	sp,	#17
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00185$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00185$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#16
	ld	(hl), c
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#10
	xor	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	inc	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#15
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#14
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#7
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#15
;utils.c:21: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#14
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#2
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i1 = interpolate(v1, v2);
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
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#9
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl+), a
	inc	hl
	ld	a, c
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#15
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#15
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#16
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#14
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#16
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#10
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#11
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#15
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#2
	xor	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	srl	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	inc	a
	ldhl	sp,	#17
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#16
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#16
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a, (hl)
	inc	a
	ldhl	sp,	#16
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, e
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#16
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#15
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#15
	ld	(hl), c
;utils.c:21: const unsigned char sides =
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl-), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#17
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#8
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:40: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#10
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
;utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
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
;utils.c:161: const unsigned char _t = terrain(_x, _y);
	cp	a, #0x64
	jr	NC, 00154$
	ldhl	sp,	#17
	ld	(hl), #0x01
	jr	00156$
00154$:
	cp	a, #0x87
	jr	NC, 00152$
	ldhl	sp,	#17
	ld	(hl), #0x00
	jr	00156$
00152$:
	sub	a, #0xa0
	jr	NC, 00150$
	ldhl	sp,	#17
	ld	(hl), #0x02
	jr	00156$
00150$:
	ldhl	sp,	#17
	ld	(hl), #0x03
00156$:
	ldhl	sp,	#17
	ld	c, (hl)
;utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#6
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, b
	ld	b, a
	ld	e, b
;utils.c:162: const unsigned char _i = generate_item(_x, _y);
	ld	a, #0x31
	sub	a, b
	jr	NC, 00173$
	ld	a, b
	sub	a, #0x33
	jr	NC, 00173$
	ld	b, #0x01
	jr	00175$
00173$:
	ld	a, #0x85
	sub	a, e
	jr	NC, 00171$
	ld	a, e
	sub	a, #0x87
	jr	NC, 00171$
	ld	b, #0x00
	jr	00175$
00171$:
	ld	a, #0x9e
	sub	a, e
	jr	NC, 00169$
	ld	a, e
	sub	a, #0xa0
	jr	NC, 00169$
	ld	b, #0x02
	jr	00175$
00169$:
	ld	a, #0xc5
	sub	a, e
	jr	NC, 00167$
	ld	a, e
	sub	a, #0xc9
	jr	NC, 00167$
	ld	b, #0x03
	jr	00175$
00167$:
	ld	b, #0xff
00175$:
;utils.c:163: map[x][y] = (_i == _t && !is_removed(_x, _y)) ? _i + 64 : _t;
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00186$
	push	bc
	push	de
	ldhl	sp,	#10
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
	jr	NZ, 00186$
	ld	a, b
	add	a, #0x40
	jr	00187$
00186$:
	ld	a, c
00187$:
	ld	(de), a
;utils.c:158: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#19
	inc	(hl)
	jp	00177$
00181$:
;utils.c:157: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#18
	inc	(hl)
	jp	00180$
00182$:
;utils.c:165: }
	add	sp, #20
	ret
;utils.c:167: void generate_map_side() {
;	---------------------------------
; Function generate_map_side
; ---------------------------------
_generate_map_side::
;utils.c:168: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #_p
	ld	c, (hl)
	ld	a, (#(_p + 1) + 0)
	sub	a, c
	ld	c, a
;utils.c:169: const char diff_y = p.y[1] - p.y[0];
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	a, (#(_p + 3) + 0)
	sub	a, b
	ld	b, a
;utils.c:170: if (diff_x < 0) {
	bit	7, c
	jr	Z, 00104$
;utils.c:172: shift_array_left();
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
;utils.c:174: } else if (diff_x > 0) {
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
;utils.c:176: shift_array_right();
	push	bc
	call	_shift_array_right
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	pop	bc
00105$:
;utils.c:179: if (diff_y > 0) {
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
;utils.c:181: shift_array_down();
	call	_shift_array_down
;utils.c:182: generate_side('t');
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	jr	00110$
00109$:
;utils.c:183: } else if (diff_y < 0) {
	bit	7, b
	jr	Z, 00110$
;utils.c:185: shift_array_up();
	call	_shift_array_up
;utils.c:186: generate_side('b');
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	inc	sp
00110$:
;utils.c:189: p.x[1] = p.x[0];
	ld	a, (#_p + 0)
	ld	(#(_p + 1)),a
;utils.c:190: p.y[1] = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ld	(#(_p + 3)),a
;utils.c:191: }
	ret
;utils.c:193: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:194: for (unsigned char i = 0; i < pixel_x; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;utils.c:195: set_bkg_tiles(i, 0, 1, pixel_y, map[i]);
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
;utils.c:194: for (unsigned char i = 0; i < pixel_x; i++)
	inc	c
	jr	00103$
00101$:
;utils.c:196: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;utils.c:197: }
	ret
;utils.c:199: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
;utils.c:201: display_map();
	call	_display_map
;utils.c:202: HIDE_SPRITES; // menu is open
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:203: const unsigned char x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0x81
	ldhl	sp,	#2
;utils.c:204: const unsigned char y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0x81
	ld	(hl), a
;utils.c:205: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 10) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:206: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 11) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:207: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
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
;utils.c:209: printf("\n\n\tposition:\t(%u, %u)", x, y);
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
;utils.c:210: printf("\n\tsteps:\t%u", p.steps);
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
;utils.c:211: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:213: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	hl, #_p
	ld	c, (hl)
;utils.c:9: x ^= (y << 7);
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, c
;utils.c:10: x ^= (x >> 5);
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
;utils.c:11: y ^= (x << 3);
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, b
;utils.c:12: y ^= (y >> 1);
	ld	b, a
	srl	a
	xor	a, b
;utils.c:13: return x ^ y * SEED;
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	xor	a, c
;utils.c:213: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
;utils.c:214: }
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
;utils.c:216: void remove_item(const unsigned char x, unsigned char y) {
;	---------------------------------
; Function remove_item
; ---------------------------------
_remove_item::
;utils.c:218: used[used_index][0] = x;
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
;utils.c:219: used[used_index][1] = y;
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
;utils.c:220: used_index++;
	ld	hl, #_used_index
	inc	(hl)
;utils.c:221: }
	ret
;utils.c:223: void add_inventory(const unsigned char item) {
;	---------------------------------
; Function add_inventory
; ---------------------------------
_add_inventory::
;utils.c:225: if (p.weapons[0] == -1) {
	ld	bc, #_p + 8
	ld	a, (bc)
	inc	a
	jr	NZ, 00102$
;utils.c:226: p.weapons[0] = item;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	ret
00102$:
;utils.c:228: p.weapons[1] = item;
	ld	de, #(_p + 9)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;utils.c:230: }
	ret
;utils.c:232: void change_item() {
;	---------------------------------
; Function change_item
; ---------------------------------
_change_item::
;utils.c:233: const char _w = p.weapons[0];
	ld	hl, #_p + 8
	ld	c, (hl)
;utils.c:234: p.weapons[0] = p.weapons[1];
	ld	de, #_p + 9
	ld	a, (de)
	ld	(hl), a
;utils.c:235: p.weapons[1] = _w;
	ld	a, c
	ld	(de), a
;utils.c:236: }
	ret
;utils.c:238: void interact() {
;	---------------------------------
; Function interact
; ---------------------------------
_interact::
	add	sp, #-6
;utils.c:243: for (char x = -2; x <= 0; x++)
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
;utils.c:244: for (char y = -3; y <= -1; y++) {
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
;utils.c:246: const unsigned char pos_y = y + center_y / sprite_size;
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x09
;utils.c:247: const unsigned char item = map[pos_x][pos_y];
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
;utils.c:248: if (item >= 64) {
	ld	(hl), a
	sub	a, #0x40
	jr	C, 00107$
;utils.c:249: add_inventory(item);
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	call	_add_inventory
	inc	sp
	pop	bc
;utils.c:250: remove_item(x + p.x[0], y + p.y[0]);
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
;utils.c:252: map[pos_x][pos_y] = item - 64;
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0xc0
	pop	hl
	push	hl
	ld	(hl), a
;utils.c:253: display_map();
	push	bc
	call	_display_map
	pop	bc
00107$:
;utils.c:244: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#5
	inc	(hl)
	jr	00106$
00110$:
;utils.c:243: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#4
	inc	(hl)
	jp	00109$
00111$:
;utils.c:256: }
	add	sp, #6
	ret
;utils.c:258: void attack() {}
;	---------------------------------
; Function attack
; ---------------------------------
_attack::
	ret
;utils.c:260: void update_position(unsigned char j) {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-8
;utils.c:261: bool update = false;
	ldhl	sp,	#4
	ld	(hl), #0x00
;utils.c:262: unsigned char _x = p.x[0];
	ld	a, (#_p + 0)
	ldhl	sp,	#6
	ld	(hl), a
;utils.c:263: unsigned char _y = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;utils.c:264: if (j & J_RIGHT)
	ldhl	sp,	#10
	ld	c, (hl)
	bit	0, c
	jr	Z, 00104$
;utils.c:265: _x++;
	ldhl	sp,	#6
	inc	(hl)
	jr	00105$
00104$:
;utils.c:266: else if (j & J_LEFT)
	bit	1, c
	jr	Z, 00105$
;utils.c:267: _x--;
	ldhl	sp,	#6
	dec	(hl)
00105$:
;utils.c:268: if (j & J_UP)
	bit	2, c
	jr	Z, 00109$
;utils.c:269: _y--;
	ldhl	sp,	#7
	dec	(hl)
	jr	00110$
00109$:
;utils.c:270: else if (j & J_DOWN)
	bit	3, c
	jr	Z, 00110$
;utils.c:271: _y++;
	ldhl	sp,	#7
	inc	(hl)
00110$:
;utils.c:272: if (_x != p.x[0]) {
	ld	hl, #_p
	ld	c, (hl)
;utils.c:275: p.steps++;
;utils.c:272: if (_x != p.x[0]) {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	jr	Z, 00114$
;utils.c:273: p.x[1] = p.x[0];
	ld	hl, #(_p + 1)
	ld	(hl), c
;utils.c:274: p.x[0] = _x;
	ld	de, #_p
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;utils.c:275: p.steps++;
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
;utils.c:276: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
	jr	00115$
00114$:
;utils.c:277: } else if (_y != p.y[0]) {
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	Z, 00115$
;utils.c:280: p.y[1] = p.y[0];
	ld	de, #(_p + 3)
	ldhl	sp,	#5
;utils.c:281: p.y[0] = _y;
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #(_p + 2)
	ld	a, (hl)
	ld	(de), a
;utils.c:282: p.steps++;
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
;utils.c:283: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
00115$:
;utils.c:285: if (update) {
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
;utils.c:286: generate_map_side();
	call	_generate_map_side
;utils.c:287: display_map();
	call	_display_map
00118$:
;utils.c:289: }
	add	sp, #8
	ret
;main.c:15: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:16: init();
	call	_init
;main.c:18: while (1) {
00102$:
;main.c:19: check_input();     // Check for user input
	call	_check_input
;main.c:20: update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
	call	_update_switches
;main.c:22: wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;main.c:24: }
	jr	00102$
;main.c:26: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:27: DISPLAY_ON; // Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:29: font_init();                   // Initialize font
	call	_font_init
;main.c:30: font_set(font_load(font_ibm)); // Set and load the font
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;main.c:34: gb_decompress_bkg_data(0, landscape);
	ld	de, #_landscape
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_gb_decompress_bkg_data
	add	sp, #3
;main.c:35: gb_decompress_sprite_data(0, player_sprite);
	ld	de, #_player_sprite
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_gb_decompress_sprite_data
	add	sp, #3
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1399: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1400: itm->y=y, itm->x=x;
	ld	a, #0x48
	ld	(hl+), a
	ld	(hl), #0x50
;main.c:45: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	hl, #(_p + 3)
	ld	(hl), #0x7f
	ld	hl, #(_p + 2)
	ld	(hl), #0x7f
	ld	hl, #(_p + 1)
	ld	(hl), #0x7f
	ld	hl, #_p
	ld	(hl), #0x7f
;main.c:48: p.steps = p.gold = p.maps = 0;
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
;main.c:49: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 9)
	ld	(hl), #0xff
	ld	hl, #(_p + 8)
	ld	(hl), #0xff
;main.c:52: printf("\n\tWelcome to\n\tPirate's Folly");
	ld	de, #___str_7
	push	de
	call	_printf
	pop	hl
;main.c:56: generate_map();
	call	_generate_map
;main.c:59: display_map();
;main.c:60: }
	jp	_display_map
___str_7:
	.db 0x0a
	.db 0x09
	.ascii "Welcome to"
	.db 0x0a
	.db 0x09
	.ascii "Pirate's Folly"
	.db 0x00
;main.c:62: inline void update_switches() {
;	---------------------------------
; Function update_switches
; ---------------------------------
_update_switches::
;main.c:63: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;main.c:64: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:65: }
	ret
;main.c:67: inline void check_input() {
;	---------------------------------
; Function check_input
; ---------------------------------
_check_input::
;main.c:68: const unsigned char j = joypad();
	call	_joypad
	ld	b, e
;main.c:69: if (j & J_START)
	bit	7, b
	jr	Z, 00102$
;main.c:70: show_menu();
	push	bc
	call	_show_menu
	pop	bc
00102$:
;main.c:71: if (j & J_SELECT)
	bit	6, b
	jr	Z, 00104$
;main.c:72: change_item();
	push	bc
	call	_change_item
	pop	bc
00104$:
;main.c:73: if (j & J_A)
	bit	4, b
	jr	Z, 00106$
;main.c:74: interact();
	push	bc
	call	_interact
	pop	bc
00106$:
;main.c:75: if (j & J_B)
	bit	5, b
	jr	Z, 00108$
;main.c:76: attack();
	push	bc
	call	_attack
	pop	bc
00108$:
;main.c:77: if (j)
	ld	a, b
	or	a, a
	ret	Z
;main.c:78: update_position(j);
	push	bc
	inc	sp
	call	_update_position
	inc	sp
;main.c:79: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__used_index:
	.db #0x00	; 0
	.area _CABS (ABS)
