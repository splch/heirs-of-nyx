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
	.globl _inventory
	.globl _show_menu
	.globl _display_map
	.globl _generate_map
	.globl _generate_side
	.globl _shift_array_down
	.globl _shift_array_up
	.globl _shift_array_right
	.globl _shift_array_left
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
;utils.c:60: void shift_array_left(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-7
;utils.c:62: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#6
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#9
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
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
	jr	NC, 00109$
;utils.c:63: for (unsigned char y = 0; y < pixel_y; y++)
	ldhl	sp,	#6
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
	ld	c, #0x00
00104$:
	ld	a, c
	ldhl	sp,	#10
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:64: map[x][y] = map[x + 1][y];
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, c
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	push	hl
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
	ld	e, c
	ld	d, #0x00
	add	hl, de
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
;utils.c:63: for (unsigned char y = 0; y < pixel_y; y++)
	inc	c
	jr	00104$
00108$:
;utils.c:62: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00107$
00109$:
;utils.c:65: }
	add	sp, #7
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
;utils.c:67: void shift_array_right(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;utils.c:69: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#6
	ld	c, (hl)
	dec	c
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;utils.c:70: for (unsigned char y = 0; y < pixel_y; y++)
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
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:71: map[x][y] = map[x - 1][y];
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
;utils.c:70: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:69: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;utils.c:72: }
	add	sp, #4
	ret
;utils.c:74: void shift_array_up(const unsigned char pixel_x, const unsigned char pixel_y) {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
	add	sp, #-4
;utils.c:75: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ldhl	sp,	#2
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
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
	jr	NC, 00109$
;utils.c:76: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#3
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:77: map[x][y] = map[x][y + 1];
	ldhl	sp,	#3
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
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	inc	l
	ld	h, #0x00
	add	hl, bc
	ld	a, (hl)
	ld	(de), a
;utils.c:76: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00108$:
;utils.c:75: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ldhl	sp,	#2
	inc	(hl)
	jr	00107$
00109$:
;utils.c:78: }
	add	sp, #4
	ret
;utils.c:80: void shift_array_down(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;utils.c:82: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ldhl	sp,	#3
	ld	c, (hl)
	dec	c
00107$:
	ld	a, c
	or	a, a
	ret	Z
;utils.c:83: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:84: map[x][y] = map[x][y - 1];
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
;utils.c:83: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:82: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;utils.c:85: }
	jr	00107$
;utils.c:87: void generate_side(const char side, const unsigned char pixel_x,
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-19
;utils.c:90: switch (side) {
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00383$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00369$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00362$
	ldhl	sp,	#21
	ld	a, (hl)
	sub	a, #0x74
	jp	Z,00376$
	jp	00342$
;utils.c:92: for (unsigned char y = 0; y < pixel_y; y++)
00362$:
	ld	bc, #_map+0
	ldhl	sp,	#18
	ld	(hl), #0x00
00331$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#23
	sub	a, (hl)
	jp	NC, 00342$
;utils.c:93: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	dec	hl
	ld	l, (hl)
	ld	h, #0x00
	dec	hl
	ld	e, l
	ld	d, h
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#18
	ld	l, (hl)
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
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#18
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(hl), a
	ldhl	sp,	#22
	ld	a, (hl)
	dec	a
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
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
	jr	Z, 00344$
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
00344$:
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
	jr	Z, 00345$
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
00345$:
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
;utils.c:43: if (value < 100)
	cp	a, #0x64
	jr	NC, 00161$
;utils.c:44: return 0x01; // water
	ld	a, #0x01
	jr	00163$
00161$:
;utils.c:45: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00159$
;utils.c:46: return 0x00; // grass
	xor	a, a
	jr	00163$
00159$:
;utils.c:47: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00157$
;utils.c:48: return 0x02; // trees
	ld	a, #0x02
	jr	00163$
00157$:
;utils.c:50: return 0x03; // mountains
	ld	a, #0x03
;utils.c:57: return closest(value);
00163$:
;utils.c:93: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	ldhl	sp,	#2
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:92: for (unsigned char y = 0; y < pixel_y; y++)
	ldhl	sp,	#18
	inc	(hl)
	jp	00331$
;utils.c:96: for (unsigned char y = 0; y < pixel_y; y++)
00369$:
	ldhl	sp,	#18
	ld	(hl), #0x00
00334$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#23
	sub	a, (hl)
	jp	NC, 00342$
;utils.c:97: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ld	de, #_map
	ldhl	sp,	#18
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#18
	add	a, (hl)
	ld	c, a
	ld	a, (#_p + 0)
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
	jr	Z, 00346$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00346$:
	ld	c, l
	ld	b, h
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
	jr	Z, 00347$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00347$:
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
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#15
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
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
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
	ldhl	sp,	#13
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
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
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
	xor	a, b
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#12
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
	ldhl	sp,	#15
	ld	(hl), b
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#8
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#17
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
	xor	a, b
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
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
	ld	(hl), a
	ld	a, c
	rrca
	and	a, #0x80
	ldhl	sp,	#16
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
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
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
;utils.c:43: if (value < 100)
	cp	a, #0x64
	jr	NC, 00216$
;utils.c:44: return 0x01; // water
	ld	c, #0x01
	jr	00218$
00216$:
;utils.c:45: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00214$
;utils.c:46: return 0x00; // grass
	ld	c, #0x00
	jr	00218$
00214$:
;utils.c:47: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00212$
;utils.c:48: return 0x02; // trees
	ld	c, #0x02
	jr	00218$
00212$:
;utils.c:50: return 0x03; // mountains
	ld	c, #0x03
;utils.c:57: return closest(value);
00218$:
;utils.c:97: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;utils.c:96: for (unsigned char y = 0; y < pixel_y; y++)
	ldhl	sp,	#18
	inc	(hl)
	jp	00334$
;utils.c:100: for (unsigned char x = 0; x < pixel_x; x++)
00376$:
	ldhl	sp,	#18
	ld	(hl), #0x00
00337$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#22
	sub	a, (hl)
	jp	NC, 00342$
;utils.c:101: map[x][0] = terrain(x + p.x[0], p.y[0]);
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
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ld	hl, #(_p + 8)
	ld	c, (hl)
	ld	a, (#_p + 0)
	ldhl	sp,	#18
	add	a, (hl)
	dec	hl
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
	jr	Z, 00348$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00348$:
	ld	c, l
	ld	b, h
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
	jr	Z, 00349$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00349$:
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
;utils.c:43: if (value < 100)
	cp	a, #0x64
	jr	NC, 00271$
;utils.c:44: return 0x01; // water
	ld	c, #0x01
	jr	00273$
00271$:
;utils.c:45: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00269$
;utils.c:46: return 0x00; // grass
	ld	c, #0x00
	jr	00273$
00269$:
;utils.c:47: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00267$
;utils.c:48: return 0x02; // trees
	ld	c, #0x02
	jr	00273$
00267$:
;utils.c:50: return 0x03; // mountains
	ld	c, #0x03
;utils.c:57: return closest(value);
00273$:
;utils.c:101: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;utils.c:100: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#18
	inc	(hl)
	jp	00337$
;utils.c:104: for (unsigned char x = 0; x < pixel_x; x++)
00383$:
	ld	c, #0x00
00340$:
	ld	a, c
	ldhl	sp,	#22
	sub	a, (hl)
	jp	NC, 00342$
;utils.c:105: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	a, #<(_map)
	add	a, l
	ld	e, a
	ld	a, #>(_map)
	adc	a, h
	ld	d, a
	ldhl	sp,	#23
	ld	b, (hl)
	dec	b
	ld	l, b
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#(_p + 8) + 0)
	add	a, b
	ld	b, a
	ld	a, (#_p + 0)
	add	a, c
	ldhl	sp,	#14
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl+), a
	ld	a, b
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
	jr	Z, 00350$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
00350$:
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	b, a
	ld	e, (hl)
	sra	e
	rr	b
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	inc	hl
	bit	7, (hl)
	jr	Z, 00351$
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
00351$:
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	sra	d
	rr	e
	ldhl	sp,	#6
	ld	(hl), e
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl), b
	ld	a, (hl)
	dec	a
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	d, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
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
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#9
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
	ldhl	sp,	#15
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
	ldhl	sp,	#15
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
	ldhl	sp,	#18
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
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
	ldhl	sp,	#10
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
	ldhl	sp,	#16
;utils.c:18: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	xor	a, (hl)
	ldhl	sp,	#14
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#9
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
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#7
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
	ldhl	sp,	#15
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
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#6
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	xor	a, (hl)
;utils.c:32: unsigned char v1 = smooth_noise(x, y);
	dec	hl
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#13
	ld	(hl), a
;utils.c:33: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#9
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#16
	ld	(hl-), a
	dec	hl
	dec	a
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
	ldhl	sp,	#18
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
	ldhl	sp,	#18
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
	ldhl	sp,	#16
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
	ldhl	sp,	#16
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
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#10
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
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#10
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
	ldhl	sp,	#18
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
	ldhl	sp,	#18
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
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#11
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
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
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
	inc	hl
	ld	d, #0x00
	ld	e, a
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
	ldhl	sp,	#7
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
	ldhl	sp,	#17
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
	ldhl	sp,	#17
	xor	a, (hl)
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
	ldhl	sp,	#10
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#12
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
	xor	a, b
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
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
;utils.c:34: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#13
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
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#10
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
	ldhl	sp,	#8
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
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
	ldhl	sp,	#11
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
	inc	hl
	ld	a, (hl)
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
	ldhl	sp,	#10
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
	ldhl	sp,	#11
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
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
	ldhl	sp,	#11
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
	ldhl	sp,	#6
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#6
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
	ldhl	sp,	#11
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
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#6
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
	ldhl	sp,	#10
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
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	b, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#17
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	e, (hl)
	ld	a, b
	dec	a
	ldhl	sp,	#11
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
	ld	(hl), #0x00
	ld	a, b
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	b, (hl)
	ldhl	sp,	#8
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
	ldhl	sp,	#17
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#12
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
	ldhl	sp,	#10
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
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
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
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
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
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
	ldhl	sp,	#11
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
	ldhl	sp,	#10
	ld	a, (hl-)
	rrca
	and	a, #0x80
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
	ldhl	sp,	#10
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
	ld	a, l
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
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
;utils.c:43: if (value < 100)
	cp	a, #0x64
	jr	NC, 00326$
;utils.c:44: return 0x01; // water
	ld	b, #0x01
	jr	00328$
00326$:
;utils.c:45: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00324$
;utils.c:46: return 0x00; // grass
	ld	b, #0x00
	jr	00328$
00324$:
;utils.c:47: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00322$
;utils.c:48: return 0x02; // trees
	ld	b, #0x02
	jr	00328$
00322$:
;utils.c:50: return 0x03; // mountains
	ld	b, #0x03
;utils.c:57: return closest(value);
00328$:
;utils.c:105: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
;utils.c:104: for (unsigned char x = 0; x < pixel_x; x++)
	inc	c
	jp	00340$
;utils.c:107: }
00342$:
;utils.c:108: }
	add	sp, #19
	ret
;utils.c:110: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-18
;utils.c:113: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #(_p + 4)
	ld	c, (hl)
	ld	hl, #_p
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:114: const char diff_y = p.y[1] - p.y[0];
	ld	a, (#(_p + 12) + 0)
	ld	hl, #(_p + 8)
	ld	c, (hl)
	sub	a, c
	ldhl	sp,	#13
;utils.c:115: if (p.steps > 0) {
	ld	(hl+), a
	ld	de, #(_p + 16)
	ld	a, (de)
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
	ld	a, (hl-)
	or	a, (hl)
	dec	hl
	or	a, (hl)
	dec	hl
	or	a, (hl)
	jp	Z, 00194$
;utils.c:116: if (diff_x < 0) {
	dec	hl
	dec	hl
	bit	7, (hl)
	jr	Z, 00104$
;utils.c:118: shift_array_left(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_left
	pop	hl
;utils.c:119: generate_side('r', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x72
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00105$
00104$:
;utils.c:120: } else if (diff_x > 0) {
	ldhl	sp,	#12
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00253$
	bit	7, d
	jr	NZ, 00254$
	cp	a, a
	jr	00254$
00253$:
	bit	7, d
	jr	Z, 00254$
	scf
00254$:
	jr	NC, 00105$
;utils.c:122: shift_array_right(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_right
	pop	hl
;utils.c:123: generate_side('l', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00105$:
;utils.c:125: if (diff_y > 0) {
	ldhl	sp,	#13
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00255$
	bit	7, d
	jr	NZ, 00256$
	cp	a, a
	jr	00256$
00255$:
	bit	7, d
	jr	Z, 00256$
	scf
00256$:
	jr	NC, 00109$
;utils.c:127: shift_array_down(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_down
	pop	hl
;utils.c:128: generate_side('t', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00110$
00109$:
;utils.c:129: } else if (diff_y < 0) {
	ldhl	sp,	#13
	bit	7, (hl)
	jr	Z, 00110$
;utils.c:131: shift_array_up(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_up
	pop	hl
;utils.c:132: generate_side('b', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00110$:
;utils.c:135: p.x[1] = p.x[0];
	ld	de, #_p
	ld	a, (de)
	ldhl	sp,	#14
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
	ldhl	sp,	#14
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
;utils.c:136: p.y[1] = p.y[0];
	ld	de, #(_p + 8)
	ld	a, (de)
	ldhl	sp,	#14
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
	ldhl	sp,	#14
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
	jp	00177$
;utils.c:139: for (unsigned char x = 0; x < pixel_x; x++)
00194$:
	ldhl	sp,	#16
	ld	(hl), #0x00
00175$:
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x14
	jp	NC, 00177$
;utils.c:140: for (unsigned char y = 0; y < pixel_y; y++)
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
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#17
	ld	(hl), #0x00
00172$:
	ldhl	sp,	#17
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00176$
;utils.c:141: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	pop	de
	push	de
	ld	l, (hl)
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
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#17
	add	a, (hl)
	dec	hl
	ld	c, a
	ld	a, (#_p + 0)
	add	a, (hl)
	dec	hl
	ld	(hl), a
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00179$
	inc	hl
	ld	c, l
	ld	b, h
00179$:
	sra	b
	rr	c
	ldhl	sp,	#4
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
	jr	Z, 00180$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00180$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#5
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#14
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
	ldhl	sp,	#14
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
	ldhl	sp,	#7
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
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#10
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
	ldhl	sp,	#4
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
	ldhl	sp,	#8
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#15
	ld	(hl-), a
	dec	hl
	dec	a
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
	ldhl	sp,	#15
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
	ldhl	sp,	#9
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
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#4
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
	ldhl	sp,	#14
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
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#15
	ld	(hl), c
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#9
	ld	a, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#14
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	c, (hl)
	ld	a, c
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
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
	ld	b, #0x00
	ldhl	sp,	#12
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
	ldhl	sp,	#14
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
	ldhl	sp,	#13
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
	ldhl	sp,	#14
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
	ld	(hl), c
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
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
	ldhl	sp,	#11
	ld	(hl-), a
	dec	hl
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
	ldhl	sp,	#11
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
	ldhl	sp,	#5
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#11
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
	ldhl	sp,	#11
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
	ldhl	sp,	#5
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
	ldhl	sp,	#9
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
	ldhl	sp,	#13
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
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
	ldhl	sp,	#13
	xor	a, (hl)
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	rrca
	rrca
	and	a, #0x3f
	ld	b, a
	ld	a, c
	add	a, (hl)
	add	a, b
	ldhl	sp,	#7
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	c, (hl)
;utils.c:15: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#14
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	b, (hl)
	ldhl	sp,	#13
	ld	(hl), c
	ld	a, (hl-)
	dec	hl
	dec	a
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
	ldhl	sp,	#13
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
	ld	a, (hl-)
	inc	a
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
	ldhl	sp,	#13
	ld	a, (hl-)
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
	ld	(hl), c
;utils.c:18: const unsigned char sides =
	ldhl	sp,	#9
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
	ld	(hl-), a
	dec	hl
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
	ldhl	sp,	#13
	ld	(hl), c
;utils.c:21: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#9
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#9
	xor	a, (hl)
	ld	c, a
	srl	a
	xor	a, c
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
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	dec	hl
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	(hl), a
	rrca
	rrca
	and	a, #0x3f
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl+), a
	ld	a, (hl+)
	add	a, (hl)
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	add	a, (hl)
	inc	hl
	inc	hl
	ld	(hl), a
;utils.c:37: const unsigned char i2 = interpolate(v1, v2);
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
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
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
;utils.c:56: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
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
	sra	(hl)
	dec	hl
	rr	(hl)
	ld	a, (hl+)
;utils.c:43: if (value < 100)
	ld	(hl), a
	sub	a, #0x64
	jr	NC, 00167$
;utils.c:44: return 0x01; // water
	ld	(hl), #0x01
	jr	00169$
00167$:
;utils.c:45: else if (value < 135)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0x87
	jr	NC, 00165$
;utils.c:46: return 0x00; // grass
	ld	(hl), #0x00
	jr	00169$
00165$:
;utils.c:47: else if (value < 160)
	ldhl	sp,	#15
	ld	a, (hl)
	sub	a, #0xa0
	jr	NC, 00163$
;utils.c:48: return 0x02; // trees
	ld	(hl), #0x02
	jr	00169$
00163$:
;utils.c:50: return 0x03; // mountains
	ldhl	sp,	#15
	ld	(hl), #0x03
;utils.c:57: return closest(value);
00169$:
;utils.c:141: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
;utils.c:140: for (unsigned char y = 0; y < pixel_y; y++)
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	(hl)
	jp	00172$
00176$:
;utils.c:139: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#16
	inc	(hl)
	jp	00175$
00177$:
;utils.c:143: }
	add	sp, #18
	ret
;utils.c:145: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:146: for (unsigned char i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;utils.c:147: set_bkg_tiles(i, 0, 1, 18, map[i]);
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
;utils.c:146: for (unsigned char i = 0; i < 20; i++)
	inc	c
	jr	00103$
00101$:
;utils.c:148: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;utils.c:149: }
	ret
;utils.c:151: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
;utils.c:153: display_map();
	call	_display_map
;utils.c:154: HIDE_SPRITES; // menu is open
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:155: const unsigned char x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0x81
	ldhl	sp,	#2
;utils.c:156: const unsigned char y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 8) + 0)
	add	a, #0x81
	ld	(hl), a
;utils.c:157: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 22) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:158: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 23) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:159: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
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
;utils.c:161: printf("\n\n\tposition:\t(%u, %u)", x, y);
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
;utils.c:162: printf("\n\tsteps:\t%u", p.steps);
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
;utils.c:163: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:165: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
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
;utils.c:165: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
;utils.c:166: }
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
;utils.c:168: void inventory() {}
;	---------------------------------
; Function inventory
; ---------------------------------
_inventory::
	ret
;utils.c:170: void interact() {}
;	---------------------------------
; Function interact
; ---------------------------------
_interact::
	ret
;utils.c:172: void attack() {}
;	---------------------------------
; Function attack
; ---------------------------------
_attack::
	ret
;utils.c:174: void update_position(unsigned char j) {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-14
;utils.c:175: bool update = false;
	ldhl	sp,	#0
	ld	(hl), #0x00
;utils.c:176: unsigned char _x = p.x[0];
	ld	a, (#_p + 0)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:177: unsigned char _y = p.y[0];
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
;utils.c:178: if (j & J_RIGHT)
	ldhl	sp,	#16
	ld	c, (hl)
	bit	0, c
	jr	Z, 00104$
;utils.c:179: _x++;
	ldhl	sp,	#12
	inc	(hl)
	jr	00105$
00104$:
;utils.c:180: else if (j & J_LEFT)
	bit	1, c
	jr	Z, 00105$
;utils.c:181: _x--;
	ldhl	sp,	#12
	dec	(hl)
00105$:
;utils.c:182: if (j & J_UP)
	bit	2, c
	jr	Z, 00109$
;utils.c:183: _y--;
	ldhl	sp,	#13
	dec	(hl)
	jr	00110$
00109$:
;utils.c:184: else if (j & J_DOWN)
	bit	3, c
	jr	Z, 00110$
;utils.c:185: _y++;
	ldhl	sp,	#13
	inc	(hl)
00110$:
;utils.c:186: if (_x != p.x[0]) {
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
;utils.c:189: p.steps++;
	ld	bc, #_p + 16
;utils.c:186: if (_x != p.x[0]) {
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
;utils.c:187: p.x[1] = p.x[0];
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
;utils.c:188: p.x[0] = _x;
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
;utils.c:189: p.steps++;
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
;utils.c:190: update = true;
	ldhl	sp,	#0
	ld	(hl), #0x01
	jp	00115$
00114$:
;utils.c:191: } else if (_y != p.y[0]) {
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
;utils.c:194: p.y[1] = p.y[0];
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
;utils.c:195: p.y[0] = _y;
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
;utils.c:196: p.steps++;
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
;utils.c:197: update = true;
	ldhl	sp,	#0
	ld	(hl), #0x01
00115$:
;utils.c:199: if (update == true) {
	ldhl	sp,	#0
	ld	a, (hl)
	dec	a
	jr	NZ, 00118$
;utils.c:200: generate_map();
	call	_generate_map
;utils.c:201: display_map();
	call	_display_map
00118$:
;utils.c:203: }
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
	ld	a, #0x4c
	ld	(hl+), a
	ld	(hl), #0x54
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
;main.c:70: inventory();
	push	bc
	call	_inventory
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
