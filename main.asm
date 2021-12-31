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
	.globl _show_menu
	.globl _update_position
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
	.ds 14
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
;utils.c:61: void shift_array_left(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-10
;utils.c:62: for (int x = 0; x < pixel_x - 1; x++)
	ld	bc, #0x0000
00107$:
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	dec	hl
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
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
	jp	NC, 00109$
;utils.c:63: for (int y = 0; y < pixel_y; y++)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	inc	bc
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00104$:
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00108$
;utils.c:64: map[x][y] = map[x + 1][y];
	pop	de
	push	de
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;utils.c:63: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:62: for (int x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:65: }
	add	sp, #10
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
;utils.c:67: void shift_array_right(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-10
;utils.c:68: for (int x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
00107$:
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
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
	jp	NC, 00109$
;utils.c:69: for (int y = 0; y < pixel_y; y++)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	de, #0x0001
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
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
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00104$:
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00108$
;utils.c:70: map[x][y] = map[x - 1][y];
	pop	de
	push	de
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;utils.c:69: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:68: for (int x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:71: }
	add	sp, #10
	ret
;utils.c:73: void shift_array_up(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
	add	sp, #-4
;utils.c:74: for (int y = 0; y < pixel_y - 1; y++)
	ld	bc, #0x0000
00107$:
	ldhl	sp,	#7
	ld	l, (hl)
	ld	h, #0x00
	dec	hl
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
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
	jr	NC, 00109$
;utils.c:75: for (int x = 0; x < pixel_x; x++)
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
00104$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00108$
;utils.c:76: map[x][y] = map[x][y + 1];
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	a, c
	inc	a
	add	a, e
	ld	e, a
	ld	a, #0x00
	adc	a, d
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;utils.c:75: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:74: for (int y = 0; y < pixel_y - 1; y++)
	inc	bc
	jr	00107$
00109$:
;utils.c:77: }
	add	sp, #4
	ret
;utils.c:79: void shift_array_down(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
	add	sp, #-4
;utils.c:80: for (int y = pixel_y - 1; y > 0; y--)
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
00107$:
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
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
	jr	NC, 00109$
;utils.c:81: for (int x = 0; x < pixel_x; x++)
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
00104$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#2
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
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
	jr	NC, 00108$
;utils.c:82: map[x][y] = map[x][y - 1];
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
	ld	l, e
	ld	h, d
	add	hl, bc
	ld	a, c
	dec	a
	add	a, e
	ld	e, a
	ld	a, #0x00
	adc	a, d
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;utils.c:81: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:80: for (int y = pixel_y - 1; y > 0; y--)
	dec	bc
	jr	00107$
00109$:
;utils.c:83: }
	add	sp, #4
	ret
;utils.c:85: void generate_side(const char side, const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-22
;utils.c:89: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#25
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:87: switch (side) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00362$
;utils.c:93: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#26
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:87: switch (side) {
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00367$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x72
	jp	Z,00357$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x74
	jp	NZ,00342$
;utils.c:89: for (int x = 0; x < pixel_x; x++)
	ld	bc, #_map+0
	xor	a, a
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), a
00331$:
	ldhl	sp,	#20
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00473$
	bit	7, d
	jr	NZ, 00474$
	cp	a, a
	jr	00474$
00473$:
	bit	7, d
	jr	Z, 00474$
	scf
00474$:
	jp	NC, 00342$
;utils.c:90: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ldhl	sp,#20
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#(_p + 4) + 0)
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#19
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#18
	ld	a, e
	ld	(hl+), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#13
	ld	(hl), e
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#11
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#8
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, (hl-)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	dec	hl
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
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
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:33: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	add	a, (hl)
	add	a, e
	ldhl	sp,	#14
	ld	(hl), a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#10
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	ld	a, d
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	add	a, (hl)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#16
	ld	a, (hl)
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
	ldhl	sp,	#12
	add	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
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
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	d, a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#19
	ld	a, (hl)
	add	a, e
	add	a, d
;utils.c:35: const UINT8 i1 = interpolate(v1, v2);
	ldhl	sp,	#14
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
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
	ldhl	sp,	#18
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ld	(hl+), a
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	sra	d
	rr	e
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
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
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
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
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#9
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	d, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl), a
	dec	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#15
	ld	(hl), d
	ld	a, (hl-)
	dec	hl
	dec	a
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#18
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
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
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#14
	ld	(hl+), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	inc	hl
	inc	hl
	add	a, e
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
;utils.c:38: const UINT8 i2 = interpolate(v1, v2);
	ldhl	sp,	#9
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
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#19
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
;utils.c:44: if (value < 100)
	cp	a, #0x64
	jr	NC, 00161$
;utils.c:45: return 0x01; // water
	ld	a, #0x01
	jr	00163$
00161$:
;utils.c:46: else if (value < 130)
	cp	a, #0x82
	jr	NC, 00159$
;utils.c:47: return 0x00; // grass
	xor	a, a
	jr	00163$
00159$:
;utils.c:48: else if (value < 150)
	sub	a, #0x96
	jr	NC, 00157$
;utils.c:49: return 0x02; // trees
	ld	a, #0x02
	jr	00163$
00157$:
;utils.c:51: return 0x03; // mountains
	ld	a, #0x03
;utils.c:58: return closest(value);
00163$:
;utils.c:90: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ldhl	sp,	#6
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:89: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#20
	inc	(hl)
	jp	NZ,00331$
	inc	hl
	inc	(hl)
	jp	00331$
;utils.c:93: for (int y = 0; y < pixel_y; y++)
00357$:
	ld	bc, #0x0000
00334$:
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00476$
	bit	7, d
	jr	NZ, 00477$
	cp	a, a
	jr	00477$
00476$:
	bit	7, d
	jr	Z, 00477$
	scf
00477$:
	jp	NC, 00342$
;utils.c:94: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0001
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#21
	ld	(hl-), a
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	ld	a, #<(_map)
	add	a, l
	ld	e, a
	ld	a, #>(_map)
	adc	a, h
	ld	d, a
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, c
	ld	hl, #(_p + 4)
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#25
	ld	a, (hl)
	dec	a
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#21
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#20
	ld	a, e
	ld	(hl+), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#20
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	(hl), a
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#13
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#18
	ld	a, (hl)
	inc	a
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#21
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#19
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, (hl-)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#13
	ld	e, (hl)
	ldhl	sp,	#19
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	dec	hl
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#19
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
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
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:33: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#21
	ld	a, (hl-)
	dec	hl
	add	a, (hl)
	add	a, e
	ldhl	sp,	#16
	ld	(hl), a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#13
	ld	e, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#21
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#20
	ld	(hl), a
	ldhl	sp,	#13
	ld	e, (hl)
	ldhl	sp,	#18
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#21
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#21
	ld	e, (hl)
	dec	hl
	add	a, e
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
	ldhl	sp,	#21
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	add	a, (hl)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#18
	ld	a, (hl)
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
	ldhl	sp,	#14
	add	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	d, a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#21
	ld	a, (hl)
	add	a, e
	add	a, d
;utils.c:35: const UINT8 i1 = interpolate(v1, v2);
	ldhl	sp,	#16
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
	ldhl	sp,	#21
	ld	(hl), e
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#20
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#16
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#16
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
	ldhl	sp,	#20
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	add	a, e
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
	ld	(hl+), a
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#20
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#10
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
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
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
	ldhl	sp,	#19
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#13
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#20
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#11
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	d, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#20
	ld	(hl), a
	dec	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#17
	ld	(hl), d
	ld	a, (hl-)
	dec	hl
	dec	a
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#20
	ld	a, (hl)
	inc	a
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#20
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#20
	ld	e, (hl)
	dec	hl
	add	a, e
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
	ldhl	sp,	#20
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#13
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#14
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#16
	ld	(hl+), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	inc	hl
	inc	hl
	add	a, e
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
;utils.c:38: const UINT8 i2 = interpolate(v1, v2);
	ldhl	sp,	#11
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
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#21
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
;utils.c:44: if (value < 100)
	cp	a, #0x64
	jr	NC, 00216$
;utils.c:45: return 0x01; // water
	ld	a, #0x01
	jr	00218$
00216$:
;utils.c:46: else if (value < 130)
	cp	a, #0x82
	jr	NC, 00214$
;utils.c:47: return 0x00; // grass
	xor	a, a
	jr	00218$
00214$:
;utils.c:48: else if (value < 150)
	sub	a, #0x96
	jr	NC, 00212$
;utils.c:49: return 0x02; // trees
	ld	a, #0x02
	jr	00218$
00212$:
;utils.c:51: return 0x03; // mountains
	ld	a, #0x03
;utils.c:58: return closest(value);
00218$:
;utils.c:94: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	ldhl	sp,	#8
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:93: for (int y = 0; y < pixel_y; y++)
	inc	bc
	jp	00334$
;utils.c:97: for (int x = 0; x < pixel_x; x++)
00362$:
	xor	a, a
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), a
00337$:
	ldhl	sp,	#20
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00478$
	bit	7, d
	jr	NZ, 00479$
	cp	a, a
	jr	00479$
00478$:
	bit	7, d
	jr	Z, 00479$
	scf
00479$:
	jp	NC, 00342$
;utils.c:98: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ldhl	sp,#20
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc,#_map
	add	hl,bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#26
	ld	c, (hl)
	dec	c
	ld	l, c
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#(_p + 4) + 0)
	add	a, c
	ld	b, a
	ldhl	sp,	#20
	ld	c, (hl)
	ld	a, (#_p + 0)
	add	a, c
	ld	c, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	e, b
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#18
	ld	(hl), e
	ld	b, #0x00
	ld	de, #0x0003
	push	de
	push	bc
	call	__divsint
	add	sp, #4
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	a, (hl-)
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#14
	ld	(hl+), a
	ld	a, (hl+)
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#19
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#19
	xor	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#13
	xor	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#19
	xor	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#19
	ld	(hl), a
	ldhl	sp,	#14
	xor	a, (hl)
	ldhl	sp,	#19
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
	ldhl	sp,	#13
	ld	c, (hl)
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#19
	ld	(hl), c
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	ldhl	sp,	#17
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	(hl), a
	ld	a, (hl-)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	l, a
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#18
	ld	a, (hl)
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
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:33: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#19
	ld	a, (hl)
	add	a, c
	add	a, e
	ldhl	sp,	#14
	ld	(hl), a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#19
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	(hl), a
	ldhl	sp,	#15
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	ld	a, (hl+)
	xor	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#3
	xor	a, (hl)
	ldhl	sp,	#18
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	inc	hl
	swap	a
	rrca
	and	a, #0x07
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
	ldhl	sp,	#18
	ld	c, (hl)
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#15
	ld	a, (hl)
	inc	a
	ldhl	sp,	#19
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#19
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#18
;utils.c:19: const UINT8 sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ldhl	sp,	#12
	add	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#19
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	add	a, (hl)
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
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#10
	ld	a, (hl)
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
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#18
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:35: const UINT8 i1 = interpolate(v1, v2);
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
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#19
	ld	(hl), c
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl), a
	ld	c, (hl)
	dec	c
	ld	e, c
	ldhl	sp,	#9
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ldhl	sp,	#16
	ld	(hl+), a
	ld	(hl), #0x00
	ld	e, c
	ldhl	sp,	#10
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, c
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#16
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
	ldhl	sp,	#18
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ld	(hl+), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#15
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
	ldhl	sp,	#18
	ld	(hl), b
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
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
	ld	a, c
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
	add	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#13
	add	a, (hl)
	inc	hl
	inc	hl
	ld	d, #0x00
	ld	e, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
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
	ldhl	sp,	#13
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
	ld	a, (hl)
	add	a, b
	add	a, c
	ldhl	sp,	#9
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	c, a
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#12
	ld	(hl), c
	ld	a, (hl+)
	dec	a
	ld	(hl), a
	ldhl	sp,	#16
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl+), a
	dec	a
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, (hl+)
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
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#8
	xor	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	rrca
	and	a, #0x80
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	inc	hl
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	(hl+), a
	inc	hl
	swap	a
	rrca
	and	a, #0x07
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
	ldhl	sp,	#17
	ld	c, (hl)
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#14
	ld	a, (hl)
	inc	a
	ldhl	sp,	#18
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#13
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	inc	a
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	dec	hl
	dec	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl+), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	(hl), c
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#18
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, c
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#16
	ld	a, (hl)
	add	a, b
	add	a, c
;utils.c:38: const UINT8 i2 = interpolate(v1, v2);
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
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#19
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
;utils.c:44: if (value < 100)
	cp	a, #0x64
	jr	NC, 00271$
;utils.c:45: return 0x01; // water
	ld	c, #0x01
	jr	00273$
00271$:
;utils.c:46: else if (value < 130)
	cp	a, #0x82
	jr	NC, 00269$
;utils.c:47: return 0x00; // grass
	ld	c, #0x00
	jr	00273$
00269$:
;utils.c:48: else if (value < 150)
	sub	a, #0x96
	jr	NC, 00267$
;utils.c:49: return 0x02; // trees
	ld	c, #0x02
	jr	00273$
00267$:
;utils.c:51: return 0x03; // mountains
	ld	c, #0x03
;utils.c:58: return closest(value);
00273$:
;utils.c:98: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;utils.c:97: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#20
	inc	(hl)
	jp	NZ,00337$
	inc	hl
	inc	(hl)
	jp	00337$
;utils.c:101: for (int y = 0; y < pixel_y; y++)
00367$:
	xor	a, a
	ldhl	sp,	#20
	ld	(hl+), a
	ld	(hl), a
00340$:
	ldhl	sp,	#20
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00481$
	bit	7, d
	jr	NZ, 00482$
	cp	a, a
	jr	00482$
00481$:
	bit	7, d
	jr	Z, 00482$
	scf
00482$:
	jp	NC, 00342$
;utils.c:102: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ld	de, #_map
	ldhl	sp,	#20
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
	ldhl	sp,	#20
	ld	c, (hl)
	ld	a, (#(_p + 4) + 0)
	add	a, c
	ld	hl, #_p
	ld	c, (hl)
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	ld	e, a
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#18
	ld	(hl), e
	ld	b, #0x00
	ld	de, #0x0003
	push	de
	push	bc
	call	__divsint
	add	sp, #4
	ldhl	sp,	#15
	ld	(hl), e
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	a, (hl-)
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	(hl), a
	dec	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	b, (hl)
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, b
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	b, a
	ld	a, c
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
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
	add	a, b
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	d, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, d
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#19
	ld	(hl), c
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	ldhl	sp,	#17
	ld	a, (hl+)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	(hl), a
	ld	b, (hl)
	ld	a, b
	swap	a
	rrca
	and	a, #0x07
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
	add	a, c
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
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
	ld	e, (hl)
	add	a, e
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#10
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#4
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
	ldhl	sp,	#13
	ld	e, (hl)
	ld	a, c
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	ld	b, c
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
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
	ld	b, e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#18
	ld	a, (hl)
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
	ld	(hl+), a
	ld	(hl), c
	ld	a, (hl-)
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	c, a
;utils.c:33: UINT8 v1 = smooth_noise(x, y);
	ld	a, b
	ldhl	sp,	#19
	add	a, (hl)
	add	a, c
	ldhl	sp,	#16
	ld	(hl), a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#12
	ld	c, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#17
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	b, a
	ld	a, l
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#18
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#10
	ld	b, (hl)
	ld	a, c
	rrca
	and	a, #0x80
	xor	a, c
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
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
	add	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#13
	ld	e, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#18
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
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
	ldhl	sp,	#19
;utils.c:19: const UINT8 sides =
	ld	a, c
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ldhl	sp,	#14
	add	a, (hl)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#18
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#14
	add	a, (hl)
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
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
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
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#12
	ld	a, (hl)
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
	add	a, (hl)
	ld	e, a
	srl	e
	srl	e
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ld	a, c
	ldhl	sp,	#19
	add	a, (hl)
	add	a, e
;utils.c:35: const UINT8 i1 = interpolate(v1, v2);
	ldhl	sp,	#16
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
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#17
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#4
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
	ldhl	sp,	#19
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#18
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#18
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#4
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#4
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
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
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
	add	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#10
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
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
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
	add	a, (hl)
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
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#13
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
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
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	b, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
	ld	a, (hl+)
	add	a, (hl)
	add	a, b
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	b, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#19
	ld	(hl), a
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl+)
	ld	e, a
	ld	a, b
	dec	a
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, b
	inc	a
	ldhl	sp,	#14
	ld	(hl), a
	ld	b, (hl)
	ldhl	sp,	#10
	ld	e, (hl)
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, b
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#17
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
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
	ld	b, a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#18
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
	ldhl	sp,	#15
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#15
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#10
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#3
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
	ld	(hl+), a
	ld	e, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#17
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, b
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
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#13
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ld	e, b
	add	a, e
	ld	e, a
	srl	e
	srl	e
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
;utils.c:38: const UINT8 i2 = interpolate(v1, v2);
	ldhl	sp,	#5
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	sra	h
	rr	l
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:44: if (value < 100)
	cp	a, #0x64
	jr	NC, 00326$
;utils.c:45: return 0x01; // water
	ld	c, #0x01
	jr	00328$
00326$:
;utils.c:46: else if (value < 130)
	cp	a, #0x82
	jr	NC, 00324$
;utils.c:47: return 0x00; // grass
	ld	c, #0x00
	jr	00328$
00324$:
;utils.c:48: else if (value < 150)
	sub	a, #0x96
	jr	NC, 00322$
;utils.c:49: return 0x02; // trees
	ld	c, #0x02
	jr	00328$
00322$:
;utils.c:51: return 0x03; // mountains
	ld	c, #0x03
;utils.c:58: return closest(value);
00328$:
;utils.c:102: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;utils.c:101: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#20
	inc	(hl)
	jp	NZ,00340$
	inc	hl
	inc	(hl)
	jp	00340$
;utils.c:104: }
00342$:
;utils.c:105: }
	add	sp, #22
	ret
;utils.c:107: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-20
;utils.c:110: const INT8 diff_x = p.x[1] - p.x[0];
	ld	hl, #(_p + 2)
	ld	c, (hl)
	ld	hl, #_p
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ldhl	sp,	#18
	ld	(hl), a
;utils.c:111: const INT8 diff_y = p.y[1] - p.y[0];
	ld	a, (#(_p + 6) + 0)
	ld	hl, #(_p + 4)
	ld	c, (hl)
	sub	a, c
	ldhl	sp,	#19
	ld	(hl), a
;utils.c:112: if (p.steps > 0) {
	ld	hl, #_p + 8
	ld	a, (hl+)
	or	a,(hl)
	jp	Z, 00190$
;utils.c:113: if (diff_x < 0) {
	ldhl	sp,	#18
	bit	7, (hl)
	jr	Z, 00104$
;utils.c:115: shift_array_left(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_left
	pop	hl
;utils.c:116: generate_side('r', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x72
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00105$
00104$:
;utils.c:117: } else if (diff_x > 0) {
	ldhl	sp,	#18
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00241$
	bit	7, d
	jr	NZ, 00242$
	cp	a, a
	jr	00242$
00241$:
	bit	7, d
	jr	Z, 00242$
	scf
00242$:
	jr	NC, 00105$
;utils.c:119: shift_array_right(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_right
	pop	hl
;utils.c:120: generate_side('l', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00105$:
;utils.c:122: if (diff_y < 0) {
	ldhl	sp,	#19
	bit	7, (hl)
	jr	Z, 00109$
;utils.c:124: shift_array_up(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_up
	pop	hl
;utils.c:125: generate_side('b', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00110$
00109$:
;utils.c:126: } else if (diff_y > 0) {
	ldhl	sp,	#19
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00243$
	bit	7, d
	jr	NZ, 00244$
	cp	a, a
	jr	00244$
00243$:
	bit	7, d
	jr	Z, 00244$
	scf
00244$:
	jr	NC, 00110$
;utils.c:128: shift_array_down(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_down
	pop	hl
;utils.c:129: generate_side('t', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00110$:
;utils.c:132: p.x[1] = p.x[0];
	ld	hl, #_p
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_p + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:133: p.y[1] = p.y[0];
	ld	hl, #(_p + 4)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_p + 6)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jp	00177$
;utils.c:136: for (UINT8 x = 0; x < pixel_x; x++)
00190$:
	ld	c, #0x00
00175$:
	ld	a, c
	sub	a, #0x14
	jp	NC, 00177$
;utils.c:137: for (UINT8 y = 0; y < pixel_y; y++)
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
	ldhl	sp,	#20
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_map
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	b, #0x00
00172$:
	ld	a, b
	sub	a, #0x12
	jp	NC, 00176$
;utils.c:138: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, b
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#(_p + 4) + 0)
	add	a, b
	ldhl	sp,	#18
	ld	(hl+), a
	ld	a, (#_p + 0)
	add	a, c
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	(hl-), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#18
	ld	a, e
	ld	(hl+), a
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	ld	hl, #0x0003
	push	hl
	push	de
	call	__divsint
	add	sp, #4
	pop	bc
	ldhl	sp,	#13
	ld	(hl), e
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	(hl), a
	dec	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#11
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	inc	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#16
	ld	a, (hl)
	inc	a
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#17
	ld	(hl+), a
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ld	(hl), a
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#8
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ld	a, (hl-)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#17
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	dec	hl
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ld	a, e
	ld	(hl+), a
	ld	a, (hl)
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
	ld	(hl), a
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl-)
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:33: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	add	a, (hl)
	add	a, e
	ldhl	sp,	#14
	ld	(hl), a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#10
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#17
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, l
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	e, (hl)
	ld	a, d
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#16
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#19
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#19
	ld	e, (hl)
	dec	hl
	add	a, e
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#15
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#12
	add	a, (hl)
	ld	e, a
	ld	d, #0x00
	ldhl	sp,	#16
	ld	a, (hl)
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
	ldhl	sp,	#12
	add	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
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
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#8
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	d, #0x00
	ld	e, a
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	inc	hl
	inc	hl
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	d, a
;utils.c:34: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#19
	ld	a, (hl)
	add	a, e
	add	a, d
;utils.c:35: const UINT8 i1 = interpolate(v1, v2);
	ldhl	sp,	#14
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
	ldhl	sp,	#19
	ld	(hl), e
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#11
	ld	a, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl-), a
	dec	hl
	dec	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#14
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#17
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#14
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
	ldhl	sp,	#18
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#9
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ld	(hl+), a
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl-), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	sra	d
	rr	e
	ldhl	sp,	#18
	ld	(hl), e
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
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
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	inc	hl
	ld	d, #0x00
	ld	e, a
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
	ldhl	sp,	#17
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
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
	ldhl	sp,	#17
	ld	(hl), e
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	add	a, (hl)
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#18
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
	ldhl	sp,	#9
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	d, (hl)
;utils.c:16: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#18
	ld	(hl), a
	dec	a
	ldhl	sp,	#12
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#15
	ld	(hl), d
	ld	a, (hl-)
	dec	hl
	dec	a
	ld	(hl), a
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, l
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
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	e, (hl)
	ld	a, d
	rrca
	and	a, #0x80
	xor	a, d
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	add	a, e
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
	ldhl	sp,	#18
	ld	a, (hl)
	inc	a
	ldhl	sp,	#15
	ld	(hl), a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, e
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#15
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
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
;utils.c:19: const UINT8 sides =
	ldhl	sp,	#11
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	dec	hl
	add	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	e, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ld	(hl), a
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#12
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	add	a, e
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
	ld	e, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	d, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, d
	ldhl	sp,	#14
	ld	(hl+), a
	ld	a, e
	rrca
	and	a, #0x80
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
	inc	hl
	inc	hl
	add	a, e
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
;utils.c:22: const UINT8 center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
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
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#11
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
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
	ld	e, (hl)
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	inc	hl
	inc	hl
	add	a, e
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
	ld	a, (hl-)
	add	a, (hl)
	add	a, e
;utils.c:38: const UINT8 i2 = interpolate(v1, v2);
	ldhl	sp,	#9
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
;utils.c:57: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#19
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
;utils.c:44: if (value < 100)
	cp	a, #0x64
	jr	NC, 00167$
;utils.c:45: return 0x01; // water
	ld	a, #0x01
	jr	00169$
00167$:
;utils.c:46: else if (value < 130)
	cp	a, #0x82
	jr	NC, 00165$
;utils.c:47: return 0x00; // grass
	xor	a, a
	jr	00169$
00165$:
;utils.c:48: else if (value < 150)
	sub	a, #0x96
	jr	NC, 00163$
;utils.c:49: return 0x02; // trees
	ld	a, #0x02
	jr	00169$
00163$:
;utils.c:51: return 0x03; // mountains
	ld	a, #0x03
;utils.c:58: return closest(value);
00169$:
;utils.c:138: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	ldhl	sp,	#6
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:137: for (UINT8 y = 0; y < pixel_y; y++)
	inc	b
	jp	00172$
00176$:
;utils.c:136: for (UINT8 x = 0; x < pixel_x; x++)
	inc	c
	jp	00175$
00177$:
;utils.c:140: }
	add	sp, #20
	ret
;utils.c:142: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:143: for (UINT8 i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	ret	NC
;utils.c:144: set_bkg_tiles(i, 0, 1, 18, map[i]);
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
;utils.c:143: for (UINT8 i = 0; i < 20; i++)
	inc	c
;utils.c:145: }
	jr	00103$
;utils.c:147: void update_position() {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-5
;utils.c:148: bool update = false;
	ldhl	sp,	#2
	ld	(hl), #0x00
;utils.c:149: UINT8 _x = p.x[0];
	ld	hl, #_p
	ld	c, (hl)
;utils.c:150: UINT8 _y = p.y[0];
	ld	a, (#(_p + 4) + 0)
	ldhl	sp,	#4
	ld	(hl), a
;utils.c:151: if (joypad() & J_RIGHT)
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;utils.c:152: _x++;
	inc	c
	jr	00105$
00104$:
;utils.c:153: else if (joypad() & J_LEFT)
	call	_joypad
	bit	1, e
	jr	Z, 00105$
;utils.c:154: _x--;
	dec	c
00105$:
;utils.c:155: if (joypad() & J_UP)
	call	_joypad
	bit	2, e
	jr	Z, 00109$
;utils.c:156: _y--;
	ldhl	sp,	#4
	dec	(hl)
	jr	00110$
00109$:
;utils.c:157: else if (joypad() & J_DOWN)
	call	_joypad
	bit	3, e
	jr	Z, 00110$
;utils.c:158: _y++;
	ldhl	sp,	#4
	inc	(hl)
00110$:
;utils.c:159: if (_x != p.x[0]) {
	ld	de, #_p
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
;utils.c:162: p.steps++;
;utils.c:159: if (_x != p.x[0]) {
	ld	(hl-), a
	ld	b, #0x00
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00159$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00114$
00159$:
;utils.c:160: p.x[1] = p.x[0];
	ld	de, #(_p + 2)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:161: p.x[0] = _x;
	ld	hl, #_p
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:162: p.steps++;
	ld	hl, #(_p + 8)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_p + 8)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:163: update = true;
	ldhl	sp,	#2
	ld	(hl), #0x01
	jr	00115$
00114$:
;utils.c:164: } else if (_y != p.y[0]) {
	ld	hl, #(_p + 4)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	sub	a, c
	jr	NZ, 00160$
	inc	hl
	ld	a, (hl)
	sub	a, b
	jr	Z, 00115$
00160$:
;utils.c:165: p.y[1] = p.y[0];
	ld	hl, #(_p + 6)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:166: p.y[0] = _y;
	ld	de, #(_p + 4)
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:167: p.steps++;
	ld	hl, #(_p + 8)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_p + 8)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:168: update = true;
	ldhl	sp,	#2
	ld	(hl), #0x01
00115$:
;utils.c:170: if (update == true) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00118$
;utils.c:171: generate_map();
	call	_generate_map
;utils.c:172: display_map();
	call	_display_map
00118$:
;utils.c:174: }
	add	sp, #5
	ret
;utils.c:176: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	dec	sp
	dec	sp
;utils.c:177: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:178: const UINT8 x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0xd8
	ldhl	sp,	#0
;utils.c:179: const UINT8 y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 4) + 0)
	add	a, #0xd8
	ld	(hl), a
;utils.c:180: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 12) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:181: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 13) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:182: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
	ld	a, (#(_p + 11) + 0)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, (#(_p + 10) + 0)
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
;utils.c:184: printf("\n\n\tposition:\t(%u, %u)", x, y);
	ldhl	sp,	#1
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
;utils.c:185: printf("\n\tsteps:\t%u", p.steps);
	ld	hl, #_p + 8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;utils.c:186: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:188: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 4)
	ld	b, (hl)
	ld	hl, #_p
	ld	c, (hl)
;utils.c:7: x ^= (x << 7);
	ld	a, c
	rrca
	and	a, #0x80
	xor	a, c
;utils.c:8: x ^= (x >> 5);
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
	ld	c, a
;utils.c:9: y ^= (y << 7);
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, b
;utils.c:10: y ^= (y >> 5);
	ld	b, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, b
;utils.c:11: return x + y * SEED;
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	add	a, c
;utils.c:188: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
;utils.c:189: }
	add	sp, #6
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
;main.c:14: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:15: init();
	call	_init
;main.c:17: while (1) {
00102$:
;main.c:18: check_input();     // Check for user input (and act on it)
	call	_check_input
;main.c:19: update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
	call	_update_switches
;main.c:21: wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;main.c:23: }
	jr	00102$
;main.c:25: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;main.c:26: DISPLAY_ON; // Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:28: font_init();                   // Initialize font
	call	_font_init
;main.c:29: font_set(font_load(font_ibm)); // Set and load the font
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;main.c:32: set_bkg_data(0, 4, landscape);
	ld	de, #_landscape
	push	de
	ld	hl, #0x400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:35: set_sprite_data(0, 0, player_sprite);
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
;main.c:45: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	hl, #(_p + 6)
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #(_p + 4)
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #(_p + 2)
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #_p
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:47: p.steps = p.gold = p.maps = 0;
	ld	hl, #(_p + 13)
	ld	(hl), #0x00
	ld	hl, #(_p + 12)
	ld	(hl), #0x00
	ld	hl, #(_p + 8)
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;main.c:48: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 11)
	ld	(hl), #0xff
	ld	hl, #(_p + 10)
	ld	(hl), #0xff
;main.c:51: printf("\n\tWelcome to\n\tPirate's Folly");
	ld	de, #___str_7
	push	de
	call	_printf
	pop	hl
;main.c:55: generate_map();
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
;main.c:62: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:63: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:64: }
	ret
;main.c:66: void check_input() {
;	---------------------------------
; Function check_input
; ---------------------------------
_check_input::
;main.c:67: if (joypad() & J_START)
	call	_joypad
	ld	a, e
	rlca
;main.c:68: show_menu();
	jp	C,_show_menu
;main.c:69: else if (joypad())
	call	_joypad
	ld	a, e
	or	a, a
;main.c:70: update_position();
	jp	NZ,_update_position
;main.c:71: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
