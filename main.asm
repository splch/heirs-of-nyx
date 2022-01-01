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
	.globl _add_item
	.globl _show_menu
	.globl _display_map
	.globl _generate_map_side
	.globl _generate_map
	.globl _generate_side
	.globl _shift_array_down
	.globl _shift_array_up
	.globl _shift_array_left
	.globl _shift_array_right
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _p
	.globl _map
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
_map::
	.ds 360
_p::
	.ds 24
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
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
;utils.c:76: void shift_array_right() {
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;utils.c:77: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ld	c, #0x13
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;utils.c:78: for (unsigned char y = 0; y < pixel_y; y++) {
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
;utils.c:79: map[x][y] = map[x - 1][y];
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
;utils.c:78: for (unsigned char y = 0; y < pixel_y; y++) {
	inc	b
	jr	00104$
00108$:
;utils.c:77: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;utils.c:81: }
	add	sp, #4
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
;utils.c:83: void shift_array_left() {
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-4
;utils.c:84: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00109$
;utils.c:85: for (unsigned char y = 0; y < pixel_y; y++) {
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
;utils.c:86: map[x][y] = map[x + 1][y];
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
;utils.c:85: for (unsigned char y = 0; y < pixel_y; y++) {
	inc	b
	jr	00104$
00108$:
;utils.c:84: for (unsigned char x = 0; x < pixel_x - 1; x++)
	inc	c
	jr	00107$
00109$:
;utils.c:88: }
	add	sp, #4
	ret
;utils.c:90: void shift_array_up() {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
;utils.c:91: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x11
	ret	NC
;utils.c:92: for (unsigned char x = 0; x < pixel_x; x++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:93: map[x][y] = map[x][y + 1];
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
;utils.c:92: for (unsigned char x = 0; x < pixel_x; x++) {
	inc	b
	jr	00104$
00108$:
;utils.c:91: for (unsigned char y = 0; y < pixel_y - 1; y++)
	inc	c
;utils.c:95: }
	jr	00107$
;utils.c:97: void shift_array_down() {
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;utils.c:98: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ld	c, #0x11
00107$:
	ld	a, c
	or	a, a
	ret	Z
;utils.c:99: for (unsigned char x = 0; x < pixel_x; x++) {
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;utils.c:100: map[x][y] = map[x][y - 1];
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
;utils.c:99: for (unsigned char x = 0; x < pixel_x; x++) {
	inc	b
	jr	00104$
00108$:
;utils.c:98: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;utils.c:102: }
	jr	00107$
;utils.c:104: void generate_side(const char side) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-19
;utils.c:106: switch (side) {
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00499$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00467$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00451$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x74
	jp	Z,00483$
	jp	00414$
;utils.c:108: for (unsigned char y = 0; y < pixel_y; y++) {
00451$:
	ld	bc, #_p+0
	ldhl	sp,	#18
	ld	(hl), #0x00
00403$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00414$
;utils.c:109: const unsigned char _t = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	ld	a, (#(_p + 8) + 0)
	add	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (bc)
	add	a, #0x13
	ld	(hl), a
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, e
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
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
00416$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	ldhl	sp,	#4
	ld	(hl), e
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#14
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
	jr	Z, 00417$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
00417$:
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	ldhl	sp,	#5
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, e
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, l
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ldhl	sp,	#15
;utils.c:18: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#10
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
	ldhl	sp,	#4
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
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#4
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
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
	ldhl	sp,	#14
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
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#9
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
	ldhl	sp,	#17
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
	ldhl	sp,	#17
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#10
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
	ldhl	sp,	#4
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
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	dec	hl
	dec	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#8
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
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
	ldhl	sp,	#17
	xor	a, (hl)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#6
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
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#13
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
	ldhl	sp,	#17
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#14
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
	ldhl	sp,	#17
	xor	a, (hl)
	dec	hl
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#10
	xor	a, (hl)
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
	ldhl	sp,	#4
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
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
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
	ldhl	sp,	#4
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
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#9
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
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#4
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
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	inc	hl
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#12
	ld	e, (hl)
	ld	d, #0x00
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#16
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
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
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
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
	ldhl	sp,	#16
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:18: const unsigned char sides =
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
	ldhl	sp,	#13
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
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#13
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#6
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
	dec	hl
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl+), a
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
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#15
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
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#7
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	d, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#16
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#13
	ld	(hl), d
	ld	a, (hl-)
	dec	hl
	dec	a
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, l
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
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
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#13
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
	ldhl	sp,	#13
	xor	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#9
	ld	a, (hl+)
	inc	hl
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
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
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
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
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
	ld	(hl-), a
	dec	hl
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
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
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#7
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	sra	h
	rr	l
	ld	a, l
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#17
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	sra	h
	rr	l
	ld	a, l
;utils.c:109: const unsigned char _t = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	cp	a, #0x64
	jr	NC, 00161$
	ld	a, #0x01
	jr	00163$
00161$:
	cp	a, #0x87
	jr	NC, 00159$
	xor	a, a
	jr	00163$
00159$:
	sub	a, #0xa0
	jr	NC, 00157$
	ld	a, #0x02
	jr	00163$
00157$:
	ld	a, #0x03
00163$:
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:110: const unsigned char _i = generate_item(pixel_x - 1 + p.x[0], y + p.y[0]);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;utils.c:63: const unsigned char _n = noise(x, y);
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	e, a
	ld	d, e
;utils.c:110: const unsigned char _i = generate_item(pixel_x - 1 + p.x[0], y + p.y[0]);
	ld	a, #0x31
	sub	a, e
	jr	NC, 00180$
	ld	a, e
	sub	a, #0x33
	jr	NC, 00180$
	dec	hl
	dec	hl
	ld	(hl), #0x01
	jr	00182$
00180$:
	ld	a, #0x85
	sub	a, d
	jr	NC, 00178$
	ld	a, d
	sub	a, #0x87
	jr	NC, 00178$
	ldhl	sp,	#14
	ld	(hl), #0x00
	jr	00182$
00178$:
	ld	a, #0x9e
	sub	a, d
	jr	NC, 00176$
	ld	a, d
	sub	a, #0xa0
	jr	NC, 00176$
	ldhl	sp,	#14
	ld	(hl), #0x02
	jr	00182$
00176$:
	ld	a, #0xc5
	sub	a, d
	jr	NC, 00174$
	ld	a, d
	sub	a, #0xc9
	jr	NC, 00174$
	ldhl	sp,	#14
	ld	(hl), #0x03
	jr	00182$
00174$:
	ldhl	sp,	#14
	ld	(hl), #0xff
00182$:
;utils.c:111: map[pixel_x - 1][y] = _i == _t ? _i + 64 : _t;
	ld	de, #(_map + 342)
	ldhl	sp,	#18
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#14
	sub	a, (hl)
	jr	NZ, 00418$
	ldhl	sp,	#14
	ld	a, (hl)
	add	a, #0x40
	jr	00419$
00418$:
	ldhl	sp,	#17
	ld	a, (hl)
00419$:
	ldhl	sp,	#15
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:108: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00403$
;utils.c:115: for (unsigned char y = 0; y < pixel_y; y++) {
00467$:
	ldhl	sp,	#18
	ld	(hl), #0x00
00406$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00414$
;utils.c:116: const unsigned char _t = terrain(p.x[0], y + p.y[0]);
	ld	a, (#(_p + 8) + 0)
	add	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#16
	ld	(hl), a
	ld	a, (#_p + 0)
	ldhl	sp,#6
	ld	(hl), a
	ldhl	sp,	#17
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
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
	jr	Z, 00420$
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
00420$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	sra	b
	rr	c
	ldhl	sp,	#4
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
	jr	Z, 00421$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00421$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#16
	ld	(hl), c
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#4
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
;utils.c:18: const unsigned char sides =
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
	ldhl	sp,	#4
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
	ldhl	sp,	#4
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
	ldhl	sp,	#4
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
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#7
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
	ldhl	sp,	#2
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
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
;utils.c:18: const unsigned char sides =
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
	ldhl	sp,	#4
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
	ldhl	sp,	#4
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
	ldhl	sp,	#4
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
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
;utils.c:18: const unsigned char sides =
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
	ldhl	sp,	#4
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#4
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
;utils.c:18: const unsigned char sides =
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
;utils.c:116: const unsigned char _t = terrain(p.x[0], y + p.y[0]);
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
;utils.c:117: const unsigned char _i = generate_item(p.x[0], y + p.y[0]);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;utils.c:63: const unsigned char _n = noise(x, y);
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, l
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
	ld	b, a
	ld	e, b
;utils.c:117: const unsigned char _i = generate_item(p.x[0], y + p.y[0]);
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
;utils.c:118: map[0][y] = _i == _t ? _i + 64 : _t;
	ld	de, #_map
	ldhl	sp,	#18
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	sub	a, b
	jr	NZ, 00422$
	ld	a, b
	add	a, #0x40
	ld	c, a
00422$:
	ld	a, c
	ld	(de), a
;utils.c:115: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00406$
;utils.c:122: for (unsigned char x = 0; x < pixel_x; x++) {
00483$:
	ldhl	sp,	#18
	ld	(hl), #0x00
00409$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00414$
;utils.c:123: const unsigned char _t = terrain(x + p.x[0], p.y[0]);
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,#5
	ld	(hl), a
	ldhl	sp,	#16
	ld	(hl+), a
	inc	hl
	ld	a, (#_p + 0)
	add	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#17
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00424$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
00424$:
	sra	b
	rr	c
	ldhl	sp,	#4
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
	jr	Z, 00425$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00425$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#16
	ld	(hl), c
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#4
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
;utils.c:18: const unsigned char sides =
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
	ldhl	sp,	#4
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
	ldhl	sp,	#4
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
	ldhl	sp,	#4
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
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	add	a, b
	add	a, c
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#7
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
	ldhl	sp,	#2
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
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
;utils.c:18: const unsigned char sides =
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
	ldhl	sp,	#4
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
	ldhl	sp,	#4
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
	ldhl	sp,	#4
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
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	a, c
	ld	(hl-), a
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
;utils.c:18: const unsigned char sides =
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
	ldhl	sp,	#4
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#4
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
;utils.c:18: const unsigned char sides =
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
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#15
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
;utils.c:123: const unsigned char _t = terrain(x + p.x[0], p.y[0]);
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
;utils.c:124: const unsigned char _i = generate_item(x + p.x[0], p.y[0]);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	e, a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
;utils.c:63: const unsigned char _n = noise(x, y);
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, l
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
	ld	b, a
	ld	e, b
;utils.c:124: const unsigned char _i = generate_item(x + p.x[0], p.y[0]);
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
;utils.c:125: map[x][0] = _i == _t ? _i + 64 : _t;
	ldhl	sp,	#18
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
	jr	NZ, 00426$
	ld	a, b
	add	a, #0x40
	ld	c, a
00426$:
	ld	a, c
	ld	(de), a
;utils.c:122: for (unsigned char x = 0; x < pixel_x; x++) {
	ldhl	sp,	#18
	inc	(hl)
	jp	00409$
;utils.c:129: for (unsigned char x = 0; x < pixel_x; x++) {
00499$:
	ldhl	sp,	#18
	ld	(hl), #0x00
00412$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00414$
;utils.c:130: const unsigned char _t = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ld	a, (#(_p + 8) + 0)
	add	a, #0x11
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#16
	ld	(hl+), a
	inc	hl
	ld	a, (#_p + 0)
	add	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#17
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	bit	7, (hl)
	jr	Z, 00428$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
00428$:
	sra	b
	rr	c
	ldhl	sp,	#4
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
	jr	Z, 00429$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00429$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	c, (hl)
	ld	a, b
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
	xor	a, b
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
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#17
	ld	b, (hl)
	inc	b
	ld	e, b
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#7
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
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
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
	xor	a, b
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
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#9
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
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
	ldhl	sp,	#4
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
	ldhl	sp,	#16
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	a, (hl+)
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	c, (hl)
	ld	a, c
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#4
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#5
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
	xor	a, b
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
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	c, e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#4
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
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	ld	a, c
	ldhl	sp,	#13
	add	a, (hl)
	dec	hl
	dec	hl
	add	a, e
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#8
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#6
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
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
	ldhl	sp,	#17
	xor	a, (hl)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#6
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, b
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
	xor	a, b
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
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#13
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
	xor	a, b
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
	ldhl	sp,	#16
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#4
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
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#4
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
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
	xor	a, b
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
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	c, e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#10
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#4
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
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	inc	hl
	ld	e, a
	srl	e
	srl	e
	ld	a, c
	add	a, (hl)
	add	a, e
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#11
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	ldhl	sp,	#17
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, e
	ld	(hl-), a
	ld	a, b
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#7
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
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
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
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
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
	ldhl	sp,	#16
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#7
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
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
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
	ldhl	sp,	#15
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#7
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
	xor	a, b
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
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, b
	rrca
	and	a, #0x80
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
	xor	a, b
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
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
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
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#12
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
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
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
	ldhl	sp,	#15
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ld	c, e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, b
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
	xor	a, b
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, c
	add	a, (hl)
	add	a, e
	ld	c, a
	ld	a, b
	ldhl	sp,	#8
	ld	e, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#16
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#13
	ld	(hl), e
	ld	a, (hl-)
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, d
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
	xor	a, d
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
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#13
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
	ldhl	sp,	#13
	xor	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	dec	hl
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#11
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
	xor	a, b
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
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#12
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
	xor	a, b
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
	inc	hl
	inc	hl
	ld	e, a
	ld	d, #0x00
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
	ld	(hl-), a
	dec	hl
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
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
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#8
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
	xor	a, b
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	ld	e, a
	srl	e
	srl	e
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#17
	ld	c, (hl)
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:130: const unsigned char _t = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	cp	a, #0x64
	jr	NC, 00380$
	ld	a, #0x01
	jr	00382$
00380$:
	cp	a, #0x87
	jr	NC, 00378$
	xor	a, a
	jr	00382$
00378$:
	sub	a, #0xa0
	jr	NC, 00376$
	ld	a, #0x02
	jr	00382$
00376$:
	ld	a, #0x03
00382$:
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:131: const unsigned char _i = generate_item(x + p.x[0], pixel_y - 1 + p.y[0]);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;utils.c:63: const unsigned char _n = noise(x, y);
	ld	a, c
	rrca
	and	a, #0x80
	xor	a, b
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	c, a
	ld	b, c
;utils.c:131: const unsigned char _i = generate_item(x + p.x[0], pixel_y - 1 + p.y[0]);
	ld	a, #0x31
	sub	a, c
	jr	NC, 00399$
	ld	a, c
	sub	a, #0x33
	jr	NC, 00399$
	ldhl	sp,	#14
	ld	(hl), #0x01
	jr	00401$
00399$:
	ld	a, #0x85
	sub	a, b
	jr	NC, 00397$
	ld	a, b
	sub	a, #0x87
	jr	NC, 00397$
	ldhl	sp,	#14
	ld	(hl), #0x00
	jr	00401$
00397$:
	ld	a, #0x9e
	sub	a, b
	jr	NC, 00395$
	ld	a, b
	sub	a, #0xa0
	jr	NC, 00395$
	ldhl	sp,	#14
	ld	(hl), #0x02
	jr	00401$
00395$:
	ld	a, #0xc5
	sub	a, b
	jr	NC, 00393$
	ld	a, b
	sub	a, #0xc9
	jr	NC, 00393$
	ldhl	sp,	#14
	ld	(hl), #0x03
	jr	00401$
00393$:
	ldhl	sp,	#14
	ld	(hl), #0xff
00401$:
;utils.c:132: map[x][pixel_y - 1] = _i == _t ? _i + 64 : _t;
	ldhl	sp,	#18
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
	ld	bc,#0x0011
	add	hl,bc
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NZ, 00430$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	add	a, #0x40
	ld	(hl), a
00430$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
;utils.c:129: for (unsigned char x = 0; x < pixel_x; x++) {
	ld	a, (hl+)
	ld	(de), a
	inc	(hl)
	jp	00412$
;utils.c:135: }
00414$:
;utils.c:136: }
	add	sp, #19
	ret
;utils.c:138: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-20
;utils.c:140: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#18
	ld	(hl), #0x00
00180$:
	ldhl	sp,	#18
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00182$
;utils.c:141: for (unsigned char y = 0; y < pixel_y; y++) {
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
	ldhl	sp,	#19
	ld	(hl), #0x00
00177$:
	ldhl	sp,	#19
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00181$
;utils.c:142: const unsigned char _t = terrain(x + p.x[0], y + p.y[0]);
	ld	a, (#(_p + 8) + 0)
	add	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	c, (hl)
	ld	a, (#_p + 0)
	ldhl	sp,	#18
	add	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#17
	ld	(hl), a
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00184$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00184$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#6
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
	ldhl	sp,	#7
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	c, (hl)
	ld	a, b
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
	xor	a, b
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
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
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
	ldhl	sp,	#16
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
	ldhl	sp,	#17
	ld	a, (hl)
	inc	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
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
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#16
;utils.c:18: const unsigned char sides =
	ld	a, c
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
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
	ld	b, a
	srl	a
	xor	a, b
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
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	inc	hl
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
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
	ldhl	sp,	#11
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
	ldhl	sp,	#17
	xor	a, (hl)
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, bc
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#12
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ldhl	sp,	#17
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	b, a
	srl	a
	xor	a, b
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
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	dec	hl
	rrca
	rrca
	and	a, #0x3f
	ld	b, a
	ld	a, c
	add	a, (hl)
	dec	hl
	dec	hl
	add	a, b
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#10
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#8
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
	ld	b, a
	srl	a
	xor	a, b
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
	ldhl	sp,	#17
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, e
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
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
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
	ldhl	sp,	#11
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
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	sra	b
	rr	c
	ldhl	sp,	#17
;utils.c:18: const unsigned char sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
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
	ld	b, a
	srl	a
	xor	a, b
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
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#12
	xor	a, (hl)
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
	ldhl	sp,	#8
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#13
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ldhl	sp,	#16
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#6
	xor	a, (hl)
	ld	b, a
	srl	a
	xor	a, b
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
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	inc	hl
	ld	e, a
	srl	e
	srl	e
	ld	a, c
	add	a, (hl)
	add	a, e
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#14
	ld	c, (hl)
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, bc
	sra	h
	rr	l
	ld	c, l
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#9
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
	ldhl	sp,	#13
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#10
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
	ldhl	sp,	#15
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
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#17
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#9
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
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#10
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
	ldhl	sp,	#16
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
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
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
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
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
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl+), a
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
	ldhl	sp,	#15
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
	ldhl	sp,	#13
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
	ldhl	sp,	#16
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
	ldhl	sp,	#16
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
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
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
	ldhl	sp,	#15
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#11
	xor	a, (hl)
	ld	b, a
	srl	a
	xor	a, b
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	b, a
	ld	a, (hl+)
	add	a, (hl)
	add	a, b
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	b, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	dec	hl
	dec	hl
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, b
	dec	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, l
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#17
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
	ldhl	sp,	#17
	xor	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, b
	inc	a
	ld	(hl), a
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, b
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
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#18
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#8
	ld	b, (hl)
	inc	b
	ld	e, b
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	inc	hl
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
	ldhl	sp,	#14
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl+), a
	ld	a, b
	rrca
	and	a, #0x80
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
	xor	a, b
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
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#11
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
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
	ldhl	sp,	#16
	xor	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#15
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
	ldhl	sp,	#16
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl+)
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
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
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
	xor	a, b
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#13
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#16
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
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
	ldhl	sp,	#11
	xor	a, (hl)
	ld	b, a
	srl	a
	xor	a, b
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
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#7
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	sra	h
	rr	l
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:142: const unsigned char _t = terrain(x + p.x[0], y + p.y[0]);
	cp	a, #0x64
	jr	NC, 00154$
	ld	e, #0x01
	jr	00156$
00154$:
	cp	a, #0x87
	jr	NC, 00152$
	ld	e, #0x00
	jr	00156$
00152$:
	sub	a, #0xa0
	jr	NC, 00150$
	ld	e, #0x02
	jr	00156$
00150$:
	ld	e, #0x03
00156$:
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:143: const unsigned char _i = generate_item(x + p.x[0], y + p.y[0]);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;utils.c:63: const unsigned char _n = noise(x, y);
	ld	a, c
	rrca
	and	a, #0x80
	xor	a, b
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	c, a
	ld	b, c
;utils.c:143: const unsigned char _i = generate_item(x + p.x[0], y + p.y[0]);
	ld	a, #0x31
	sub	a, c
	jr	NC, 00173$
	ld	a, c
	sub	a, #0x33
	jr	NC, 00173$
	ldhl	sp,	#14
	ld	(hl), #0x01
	jr	00175$
00173$:
	ld	a, #0x85
	sub	a, b
	jr	NC, 00171$
	ld	a, b
	sub	a, #0x87
	jr	NC, 00171$
	ldhl	sp,	#14
	ld	(hl), #0x00
	jr	00175$
00171$:
	ld	a, #0x9e
	sub	a, b
	jr	NC, 00169$
	ld	a, b
	sub	a, #0xa0
	jr	NC, 00169$
	ldhl	sp,	#14
	ld	(hl), #0x02
	jr	00175$
00169$:
	ld	a, #0xc5
	sub	a, b
	jr	NC, 00167$
	ld	a, b
	sub	a, #0xc9
	jr	NC, 00167$
	ldhl	sp,	#14
	ld	(hl), #0x03
	jr	00175$
00167$:
	ldhl	sp,	#14
	ld	(hl), #0xff
00175$:
;utils.c:144: map[x][y] = _i == _t ? _i + 64 : _t;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#17
	sub	a, (hl)
	jr	NZ, 00186$
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	add	a, #0x40
	ld	(hl), a
00186$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
;utils.c:141: for (unsigned char y = 0; y < pixel_y; y++) {
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	(hl)
	jp	00177$
00181$:
;utils.c:140: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#18
	inc	(hl)
	jp	00180$
00182$:
;utils.c:146: }
	add	sp, #20
	ret
;utils.c:148: void generate_map_side() {
;	---------------------------------
; Function generate_map_side
; ---------------------------------
_generate_map_side::
	add	sp, #-4
;utils.c:149: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #(_p + 4)
	ld	c, (hl)
	ld	hl, #_p
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ld	c, a
;utils.c:150: const char diff_y = p.y[1] - p.y[0];
	ld	a, (#(_p + 12) + 0)
	ld	hl, #(_p + 8)
	ld	b, (hl)
	sub	a, b
	ld	b, a
;utils.c:151: if (diff_x < 0) {
	bit	7, c
	jr	Z, 00104$
;utils.c:153: shift_array_left();
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
;utils.c:155: } else if (diff_x > 0) {
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
;utils.c:157: shift_array_right();
	push	bc
	call	_shift_array_right
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	pop	bc
00105$:
;utils.c:160: if (diff_y > 0) {
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
;utils.c:162: shift_array_down();
	call	_shift_array_down
;utils.c:163: generate_side('t');
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	jr	00110$
00109$:
;utils.c:164: } else if (diff_y < 0) {
	bit	7, b
	jr	Z, 00110$
;utils.c:166: shift_array_up();
	call	_shift_array_up
;utils.c:167: generate_side('b');
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	inc	sp
00110$:
;utils.c:170: p.x[1] = p.x[0];
	ld	de, #_p
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
	ld	(hl), a
	ld	de, #(_p + 4)
	ldhl	sp,	#0
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
;utils.c:171: p.y[1] = p.y[0];
	ld	de, #(_p + 8)
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
	ld	(hl), a
	ld	de, #(_p + 12)
	ldhl	sp,	#0
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
;utils.c:172: }
	add	sp, #4
	ret
;utils.c:174: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:175: for (unsigned char i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;utils.c:176: set_bkg_tiles(i, 0, 1, 18, map[i]);
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
;utils.c:175: for (unsigned char i = 0; i < 20; i++)
	inc	c
	jr	00103$
00101$:
;utils.c:177: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;utils.c:178: }
	ret
;utils.c:180: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
;utils.c:182: display_map();
	call	_display_map
;utils.c:183: HIDE_SPRITES; // menu is open
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:184: const unsigned char x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0x81
	ldhl	sp,	#2
;utils.c:185: const unsigned char y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 8) + 0)
	add	a, #0x81
	ld	(hl), a
;utils.c:186: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 22) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:187: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 23) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:188: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
	ld	a, (#(_p + 21) + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (#(_p + 20) + 0)
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
;utils.c:190: printf("\n\n\tposition:\t(%u, %u)", x, y);
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
;utils.c:191: printf("\n\tsteps:\t%u", p.steps);
	ld	de, #(_p + 16)
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
;utils.c:192: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:194: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 8)
	ld	b, (hl)
	ld	hl, #_p
	ld	c, (hl)
;utils.c:6: x ^= (y << 7);
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, c
;utils.c:7: x ^= (x >> 5);
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
;utils.c:8: y ^= (x << 3);
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, b
;utils.c:9: y ^= (y >> 1);
	ld	b, a
	srl	a
	xor	a, b
;utils.c:10: return x ^ y * SEED;
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
;utils.c:194: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
;utils.c:195: }
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
;utils.c:197: void add_item(const unsigned char item) {
;	---------------------------------
; Function add_item
; ---------------------------------
_add_item::
;utils.c:199: if (p.weapons[0] == -1)
	ld	bc, #_p + 20
	ld	a, (bc)
	inc	a
	jr	NZ, 00102$
;utils.c:200: p.weapons[0] = item;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	ret
00102$:
;utils.c:202: p.weapons[1] = item;
	ld	de, #(_p + 21)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;utils.c:203: }
	ret
;utils.c:205: void change_item() {
;	---------------------------------
; Function change_item
; ---------------------------------
_change_item::
;utils.c:206: const char _w = p.weapons[0];
	ld	hl, #_p + 20
	ld	c, (hl)
;utils.c:207: p.weapons[0] = p.weapons[1];
	ld	de, #_p + 21
	ld	a, (de)
	ld	(hl), a
;utils.c:208: p.weapons[1] = _w;
	ld	a, c
	ld	(de), a
;utils.c:209: }
	ret
;utils.c:211: void interact() {
;	---------------------------------
; Function interact
; ---------------------------------
_interact::
	dec	sp
	dec	sp
;utils.c:216: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#0
	ld	(hl), #0xfe
00109$:
	ldhl	sp,	#0
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
	jr	C, 00111$
;utils.c:217: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#0
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
	ldhl	sp,	#1
	ld	(hl), #0xfd
00106$:
	ldhl	sp,	#1
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
;utils.c:219: const unsigned char pos_y = y + center_y / sprite_size;
	ldhl	sp,	#1
	ld	a, (hl)
	add	a, #0x09
;utils.c:220: const unsigned char _i = map[pos_x][pos_y];
	ld	l, a
	ld	h, #0x00
	add	hl, bc
	ld	d, (hl)
;utils.c:221: if (_i >= 64) {
	ld	a, d
	sub	a, #0x40
	jr	C, 00107$
;utils.c:222: add_item(_i);
	push	hl
	push	bc
	push	de
	push	de
	inc	sp
	call	_add_item
	inc	sp
	pop	de
	pop	bc
	pop	hl
;utils.c:224: map[pos_x][pos_y] = _i - 64;
	ld	a, d
	add	a, #0xc0
	ld	(hl), a
;utils.c:225: display_map();
	push	bc
	call	_display_map
	pop	bc
00107$:
;utils.c:217: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#1
	inc	(hl)
	jr	00106$
00110$:
;utils.c:216: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#0
	inc	(hl)
	jr	00109$
00111$:
;utils.c:228: }
	inc	sp
	inc	sp
	ret
;utils.c:230: void attack() {}
;	---------------------------------
; Function attack
; ---------------------------------
_attack::
	ret
;utils.c:232: void update_position(unsigned char j) {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-14
;utils.c:233: bool update = false;
	ldhl	sp,	#0
	ld	(hl), #0x00
;utils.c:234: unsigned char _x = p.x[0];
	ld	a, (#_p + 0)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:235: unsigned char _y = p.y[0];
	ld	de, #(_p + 8)
	ld	a, (de)
	ldhl	sp,	#1
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
;utils.c:236: if (j & J_RIGHT)
	ldhl	sp,	#16
	ld	c, (hl)
	bit	0, c
	jr	Z, 00104$
;utils.c:237: _x++;
	ldhl	sp,	#12
	inc	(hl)
	jr	00105$
00104$:
;utils.c:238: else if (j & J_LEFT)
	bit	1, c
	jr	Z, 00105$
;utils.c:239: _x--;
	ldhl	sp,	#12
	dec	(hl)
00105$:
;utils.c:240: if (j & J_UP)
	bit	2, c
	jr	Z, 00109$
;utils.c:241: _y--;
	ldhl	sp,	#13
	dec	(hl)
	jr	00110$
00109$:
;utils.c:242: else if (j & J_DOWN)
	bit	3, c
	jr	Z, 00110$
;utils.c:243: _y++;
	ldhl	sp,	#13
	inc	(hl)
00110$:
;utils.c:244: if (_x != p.x[0]) {
	ld	de, #_p
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;utils.c:247: p.steps++;
	ld	bc, #_p + 16
;utils.c:244: if (_x != p.x[0]) {
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#9
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#10
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#11
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#12
	sub	a, (hl)
	jr	Z, 00114$
00159$:
;utils.c:245: p.x[1] = p.x[0];
	ld	de, #(_p + 4)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
;utils.c:246: p.x[0] = _x;
	ld	a, (hl+)
	ld	(de), a
	ld	de, #_p
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
;utils.c:247: p.steps++;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#6
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
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	add	a, #0x01
	ld	e, a
	ld	a, d
	adc	a, #0x00
	push	af
	ldhl	sp,	#13
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
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;utils.c:248: update = true;
	ldhl	sp,	#0
	ld	(hl), #0x01
	jp	00115$
00114$:
;utils.c:249: } else if (_y != p.y[0]) {
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#1
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#3
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#4
	sub	a, (hl)
	jr	Z, 00115$
00160$:
;utils.c:252: p.y[1] = p.y[0];
	ld	de, #(_p + 12)
	ldhl	sp,	#1
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
;utils.c:253: p.y[0] = _y;
	ld	de, #(_p + 8)
	ldhl	sp,	#10
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
;utils.c:254: p.steps++;
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#6
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
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	add	a, #0x01
	ld	e, a
	ld	a, d
	adc	a, #0x00
	push	af
	ldhl	sp,	#13
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
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;utils.c:255: update = true;
	ldhl	sp,	#0
	ld	(hl), #0x01
00115$:
;utils.c:257: if (update == true) {
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	jr	NZ, 00118$
;utils.c:258: generate_map_side();
	call	_generate_map_side
;utils.c:259: display_map();
	call	_display_map
00118$:
;utils.c:261: }
	add	sp, #14
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
	ld	hl, #(_p + 12)
	ld	a, #0x7f
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #(_p + 8)
	ld	a, #0x7f
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #(_p + 4)
	ld	a, #0x7f
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
	ld	hl, #_p
	ld	a, #0x7f
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:46: p.steps = p.gold = p.maps = 0;
	ld	hl, #(_p + 23)
	ld	(hl), #0x00
	ld	hl, #(_p + 22)
	ld	(hl), #0x00
	ld	hl, #(_p + 16)
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;main.c:47: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 21)
	ld	(hl), #0xff
	ld	hl, #(_p + 20)
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
	.area _CABS (ABS)