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
	.globl _shift_down
	.globl _shift_up
	.globl _shift_right
	.globl _shift_left
	.globl _terrain
	.globl _closest
	.globl _interpolate_noise
	.globl _interpolate
	.globl _smooth_noise
	.globl _noise
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _start_position
	.globl _SEED
	.globl _p
	.globl _map
	.globl _landscape
	.globl _player_sprite
	.globl _scale
	.globl _screen_y
	.globl _screen_x
	.globl _sprite_size
	.globl _init
	.globl _updateSwitches
	.globl _checkInput
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
_SEED::
	.ds 1
_start_position::
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
;utils.c:5: UINT8 noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function noise
; ---------------------------------
_noise::
;utils.c:7: x = x ^ SEED ^ y;        // the mix of addition and XOR
	ldhl	sp,	#2
	ld	a, (hl)
	ld	hl, #_SEED
	xor	a, (hl)
	ldhl	sp,	#3
	xor	a, (hl)
	dec	hl
;utils.c:8: y = y + x;               // and the use of very few instructions
	ld	(hl+), a
	ld	a, (hl-)
	add	a, (hl)
	inc	hl
;utils.c:9: x = SEED + (y >> 1) ^ x; // ensure high-order bits from b can affect
	ld	(hl), a
	srl	a
	ld	hl, #_SEED
	add	a, (hl)
	ldhl	sp,	#2
	xor	a, (hl)
	ld	(hl), a
;utils.c:10: return x;                // low order bits of other variables
	ld	e, (hl)
;utils.c:11: }
	ret
_sprite_size:
	.db #0x08	; 8
_screen_x:
	.db #0xa0	; 160
_screen_y:
	.db #0x90	; 144
_scale:
	.db #0x01	; 1
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
;utils.c:13: UINT8 smooth_noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function smooth_noise
; ---------------------------------
_smooth_noise::
	add	sp, #-5
;utils.c:15: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ld	b, (hl)
	dec	b
	ldhl	sp,	#7
	ld	e, (hl)
	ld	c, e
	dec	c
	push	bc
	push	de
	push	bc
	call	_noise
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	ldhl	sp,	#0
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, e
	inc	a
	ld	(hl), a
	push	bc
	ld	c, (hl)
	push	bc
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	pop	hl
	push	hl
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (hl-)
	inc	a
	ld	(hl), a
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
	push	bc
	push	de
	ldhl	sp,	#7
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
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#4
	ld	(hl), e
;utils.c:18: const UINT8 sides =
	push	bc
	ldhl	sp,	#10
	ld	b, (hl)
	push	bc
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#7
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
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#5
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
;utils.c:21: const UINT8 center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:22: return corners + sides + center;
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	e, a
;utils.c:23: }
	add	sp, #5
	ret
;utils.c:25: UINT8 interpolate(UINT8 v1, UINT8 v2) {
;	---------------------------------
; Function interpolate
; ---------------------------------
_interpolate::
;utils.c:27: return (v1 + v2) >> 1; // divide by 2
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, #0x00
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	sra	h
	rr	l
	ld	e, l
;utils.c:31: }
	ret
;utils.c:33: UINT8 interpolate_noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function interpolate_noise
; ---------------------------------
_interpolate_noise::
	dec	sp
;utils.c:35: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_smooth_noise
	pop	hl
	ld	b, e
;utils.c:36: UINT8 v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	c, a
	inc	c
	push	bc
	ld	b, (hl)
	push	bc
	call	_smooth_noise
	pop	hl
	ld	a, e
	pop	bc
;utils.c:37: const UINT8 i1 = interpolate(v1, v2);
	push	bc
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_interpolate
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	(hl), e
;utils.c:38: v1 = smooth_noise(x, y + 1);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	b, a
	inc	b
	push	bc
	ld	c, (hl)
	push	bc
	call	_smooth_noise
	pop	hl
	pop	bc
;utils.c:39: v2 = smooth_noise(x + 1, y + 1);
	push	de
	push	bc
	call	_smooth_noise
	pop	hl
	ld	a, e
	pop	de
;utils.c:40: const UINT8 i2 = interpolate(v1, v2);
	ld	d,a
	push	de
	call	_interpolate
	pop	hl
	ld	a, e
;utils.c:41: return interpolate(i1, i2);
	push	af
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl)
	push	af
	inc	sp
	call	_interpolate
	pop	hl
;utils.c:42: }
	inc	sp
	ret
;utils.c:45: unsigned char closest(UINT8 value) {
;	---------------------------------
; Function closest
; ---------------------------------
_closest::
;utils.c:47: if (value < 80)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x50
	jr	NC, 00108$
;utils.c:48: return 0x01; // water
	ld	e, #0x01
	ret
00108$:
;utils.c:49: else if (value < 120)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x78
	jr	NC, 00105$
;utils.c:50: return 0x00; // grass
	ld	e, #0x00
	ret
00105$:
;utils.c:51: else if (value < 160)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0xa0
	jr	NC, 00102$
;utils.c:52: return 0x02; // trees
	ld	e, #0x02
	ret
00102$:
;utils.c:54: return 0x03; // mountains
	ld	e, #0x03
;utils.c:55: }
	ret
;utils.c:57: unsigned char terrain(UINT8 x, UINT8 y) {
;	---------------------------------
; Function terrain
; ---------------------------------
_terrain::
;utils.c:59: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	hl, #_scale
	ld	d, (hl)
	push	de
	push	de
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	__divuchar
	pop	hl
	ld	b, e
	pop	de
	push	bc
	push	de
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	__divuchar
	pop	hl
	ld	a, e
	inc	sp
	push	af
	inc	sp
	call	_interpolate_noise
	pop	hl
	ld	a, e
;utils.c:60: return closest(value);
	push	af
	inc	sp
	call	_closest
	inc	sp
;utils.c:61: }
	ret
;utils.c:63: void shift_left(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_left
; ---------------------------------
_shift_left::
	add	sp, #-10
;utils.c:64: for (int x = 0; x < pixel_x - 1; x++)
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
;utils.c:65: for (int y = 0; y < pixel_y; y++)
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
;utils.c:66: map[x][y] = map[x + 1][y];
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
;utils.c:65: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:64: for (int x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:67: }
	add	sp, #10
	ret
;utils.c:69: void shift_right(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_right
; ---------------------------------
_shift_right::
	add	sp, #-10
;utils.c:70: for (int x = pixel_x - 1; x > 0; x--)
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
;utils.c:71: for (int y = 0; y < pixel_y; y++)
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
;utils.c:72: map[x][y] = map[x - 1][y];
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
;utils.c:71: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:70: for (int x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:73: }
	add	sp, #10
	ret
;utils.c:75: void shift_up(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_up
; ---------------------------------
_shift_up::
	add	sp, #-4
;utils.c:76: for (int y = 0; y < pixel_y - 1; y++)
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
;utils.c:77: for (int x = 0; x < pixel_x; x++)
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
;utils.c:78: map[x][y] = map[x][y + 1];
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
;utils.c:77: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:76: for (int y = 0; y < pixel_y - 1; y++)
	inc	bc
	jr	00107$
00109$:
;utils.c:79: }
	add	sp, #4
	ret
;utils.c:81: void shift_down(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_down
; ---------------------------------
_shift_down::
	add	sp, #-4
;utils.c:82: for (int y = pixel_y - 1; y > 0; y--)
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
;utils.c:83: for (int x = 0; x < pixel_x; x++)
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
;utils.c:84: map[x][y] = map[x][y - 1];
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
;utils.c:83: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:82: for (int y = pixel_y - 1; y > 0; y--)
	dec	bc
	jr	00107$
00109$:
;utils.c:85: }
	add	sp, #4
	ret
;utils.c:87: void generate_side(const char side, const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-7
;utils.c:91: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:89: switch (side) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00133$
;utils.c:95: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:89: switch (side) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00135$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00131$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x74
	jp	NZ,00122$
;utils.c:91: for (int x = 0; x < pixel_x; x++)
	ld	bc, #0x0000
00111$:
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00193$
	bit	7, d
	jr	NZ, 00194$
	cp	a, a
	jr	00194$
00193$:
	bit	7, d
	jr	Z, 00194$
	scf
00194$:
	jp	NC, 00122$
;utils.c:92: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	inc	sp
	inc	sp
	push	hl
	ld	de, #_map
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#(_p + 4) + 0)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, c
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#8
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ldhl	sp,	#4
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:91: for (int x = 0; x < pixel_x; x++)
	inc	bc
	jr	00111$
;utils.c:95: for (int y = 0; y < pixel_y; y++)
00131$:
	xor	a, a
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), a
00114$:
	ldhl	sp,	#5
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
	jr	Z, 00195$
	bit	7, d
	jr	NZ, 00196$
	cp	a, a
	jr	00196$
00195$:
	bit	7, d
	jr	Z, 00196$
	scf
00196$:
	jp	NC, 00122$
;utils.c:96: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
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
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#5
	ld	a, (hl)
	ld	hl, #(_p + 4)
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	dec	a
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#6
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ld	(bc), a
;utils.c:95: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#5
	inc	(hl)
	jr	NZ, 00114$
	inc	hl
	inc	(hl)
	jr	00114$
;utils.c:99: for (int x = 0; x < pixel_x; x++)
00133$:
	ld	bc, #0x0000
00117$:
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00198$
	bit	7, d
	jr	NZ, 00199$
	cp	a, a
	jr	00199$
00198$:
	bit	7, d
	jr	Z, 00199$
	scf
00199$:
	jp	NC, 00122$
;utils.c:100: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	a, l
	add	a, #<(_map)
	ld	e, a
	ld	a, h
	adc	a, #>(_map)
	ld	d, a
	ldhl	sp,	#11
	ld	a, (hl)
	dec	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl+), a
	ld	a, (#(_p + 4) + 0)
	add	a, (hl)
	ld	(hl), a
	ld	a, c
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#8
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ldhl	sp,	#4
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:99: for (int x = 0; x < pixel_x; x++)
	inc	bc
	jr	00117$
;utils.c:103: for (int y = 0; y < pixel_y; y++)
00135$:
	ld	bc, #0x0000
00120$:
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00200$
	bit	7, d
	jr	NZ, 00201$
	cp	a, a
	jr	00201$
00200$:
	bit	7, d
	jr	Z, 00201$
	scf
00201$:
	jr	NC, 00122$
;utils.c:104: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ld	hl, #_map
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, c
	ld	hl, #(_p + 4)
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ld	hl, #_p
	ld	h, (hl)
;	spillPairReg hl
	push	bc
	push	af
	inc	sp
	push	hl
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ldhl	sp,	#5
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:103: for (int y = 0; y < pixel_y; y++)
	inc	bc
	jr	00120$
;utils.c:106: }
00122$:
;utils.c:107: }
	add	sp, #7
	ret
;utils.c:109: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-7
;utils.c:110: const UINT8 pixel_x = screen_x / sprite_size;
	ld	hl, #_sprite_size
	ld	b, (hl)
	ld	a, (#_screen_x)
	push	bc
	push	bc
	inc	sp
	push	af
	inc	sp
	call	__divuchar
	pop	hl
	pop	bc
	ldhl	sp,	#0
	ld	(hl), e
;utils.c:111: const UINT8 pixel_y = screen_y / sprite_size;
	ld	a, (#_screen_y)
	push	bc
	inc	sp
	push	af
	inc	sp
	call	__divuchar
	pop	hl
	ldhl	sp,#6
	ld	(hl), e
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;utils.c:112: const INT8 diff_x = p.x[1] - p.x[0];
	ld	hl, #(_p + 2)
	ld	c, (hl)
	ld	hl, #_p
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ldhl	sp,	#3
	ld	(hl), a
;utils.c:113: const INT8 diff_y = p.y[1] - p.y[0];
	ld	a, (#(_p + 6) + 0)
	ld	hl, #(_p + 4)
	ld	c, (hl)
	sub	a, c
	ldhl	sp,	#4
;utils.c:114: if (p.steps > 0) {
	ld	(hl+), a
	ld	de, #(_p + 8)
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00132$
;utils.c:115: if (diff_x < 0) {
	dec	hl
	dec	hl
	bit	7, (hl)
	jr	Z, 00104$
;utils.c:117: shift_left(pixel_x, pixel_y);
	dec	hl
	dec	hl
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_left
	pop	hl
;utils.c:118: generate_side('r', pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x72
	push	hl
	call	_generate_side
	add	sp, #3
	jr	00105$
00104$:
;utils.c:119: } else if (diff_x > 0) {
	ldhl	sp,	#3
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00171$
	bit	7, d
	jr	NZ, 00172$
	cp	a, a
	jr	00172$
00171$:
	bit	7, d
	jr	Z, 00172$
	scf
00172$:
	jr	NC, 00105$
;utils.c:121: shift_right(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_right
	pop	hl
;utils.c:122: generate_side('l', pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x6c
	push	hl
	call	_generate_side
	add	sp, #3
00105$:
;utils.c:124: if (diff_y < 0) {
	ldhl	sp,	#4
	bit	7, (hl)
	jr	Z, 00109$
;utils.c:126: shift_up(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_up
	pop	hl
;utils.c:127: generate_side('b', pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x62
	push	hl
	call	_generate_side
	add	sp, #3
	jr	00110$
00109$:
;utils.c:128: } else if (diff_y > 0) {
	ldhl	sp,	#4
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00173$
	bit	7, d
	jr	NZ, 00174$
	cp	a, a
	jr	00174$
00173$:
	bit	7, d
	jr	Z, 00174$
	scf
00174$:
	jr	NC, 00110$
;utils.c:130: shift_down(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_down
	pop	hl
;utils.c:131: generate_side('t', pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	push	af
	inc	sp
	ld	h, (hl)
	ld	l, #0x74
	push	hl
	call	_generate_side
	add	sp, #3
00110$:
;utils.c:133: p.x[1] = p.x[0];
	ld	hl, #_p
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_p + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:134: p.y[1] = p.y[0];
	ld	hl, #(_p + 4)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #(_p + 6)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00122$
;utils.c:136: for (UINT8 x = 0; x < pixel_x; x++)
00132$:
	ldhl	sp,	#6
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00122$
;utils.c:137: for (UINT8 y = 0; y < pixel_y; y++)
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
00117$:
	ld	a, c
	ldhl	sp,	#1
	sub	a, (hl)
	jr	NC, 00121$
;utils.c:138: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	inc	hl
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
	ld	(hl+), a
	ld	a, (#(_p + 4) + 0)
	add	a, c
	ld	b, a
	ld	a, (#_p + 0)
	add	a, (hl)
	push	bc
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ldhl	sp,	#4
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:137: for (UINT8 y = 0; y < pixel_y; y++)
	inc	c
	jr	00117$
00121$:
;utils.c:136: for (UINT8 x = 0; x < pixel_x; x++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00120$
00122$:
;utils.c:139: }
	add	sp, #7
	ret
;utils.c:141: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:142: for (UINT8 i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	ret	NC
;utils.c:143: set_bkg_tiles(i, 0, 1, 18, map[i]);
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
;utils.c:142: for (UINT8 i = 0; i < 20; i++)
	inc	c
;utils.c:144: }
	jr	00103$
;utils.c:146: void update_position() {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-5
;utils.c:147: bool update = false;
	ldhl	sp,	#2
	ld	(hl), #0x00
;utils.c:148: UINT8 _x = p.x[0];
	ld	hl, #_p
	ld	c, (hl)
;utils.c:149: UINT8 _y = p.y[0];
	ld	a, (#(_p + 4) + 0)
	ldhl	sp,	#4
	ld	(hl), a
;utils.c:150: if (joypad() & J_RIGHT)
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;utils.c:151: _x++;
	inc	c
	jr	00105$
00104$:
;utils.c:152: else if (joypad() & J_LEFT)
	call	_joypad
	bit	1, e
	jr	Z, 00105$
;utils.c:153: _x--;
	dec	c
00105$:
;utils.c:154: if (joypad() & J_UP)
	call	_joypad
	bit	2, e
	jr	Z, 00109$
;utils.c:155: _y--;
	ldhl	sp,	#4
	dec	(hl)
	jr	00110$
00109$:
;utils.c:156: else if (joypad() & J_DOWN)
	call	_joypad
	bit	3, e
	jr	Z, 00110$
;utils.c:157: _y++;
	ldhl	sp,	#4
	inc	(hl)
00110$:
;utils.c:158: if (_x != p.x[0]) {
	ld	de, #_p
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
;utils.c:161: p.steps++;
;utils.c:158: if (_x != p.x[0]) {
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
;utils.c:159: p.x[1] = p.x[0];
	ld	de, #(_p + 2)
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:160: p.x[0] = _x;
	ld	hl, #_p
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:161: p.steps++;
	ld	hl, #(_p + 8)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_p + 8)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:162: update = true;
	ldhl	sp,	#2
	ld	(hl), #0x01
	jr	00115$
00114$:
;utils.c:163: } else if (_y != p.y[0]) {
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
;utils.c:164: p.y[1] = p.y[0];
	ld	hl, #(_p + 6)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:165: p.y[0] = _y;
	ld	de, #(_p + 4)
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;utils.c:166: p.steps++;
	ld	hl, #(_p + 8)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ld	hl, #(_p + 8)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;utils.c:167: update = true;
	ldhl	sp,	#2
	ld	(hl), #0x01
00115$:
;utils.c:169: if (update == true) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00118$
;utils.c:170: generate_map();
	call	_generate_map
;utils.c:171: display_map();
	call	_display_map
00118$:
;utils.c:173: }
	add	sp, #5
	ret
;utils.c:175: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	dec	sp
	dec	sp
;utils.c:176: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;utils.c:177: const UINT8 x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	ld	hl, #_start_position
	sub	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
;utils.c:178: const UINT8 y = p.y[0] - start_position;
	ld	a, (#(_p + 4) + 0)
	ld	hl, #_start_position
	sub	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;utils.c:179: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 12) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;utils.c:180: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 13) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;utils.c:181: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
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
;utils.c:183: printf("\n\n\tposition:\t(%u, %u)", x, y);
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
;utils.c:184: printf("\n\tsteps:\t%u", p.steps);
	ld	hl, #_p + 8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	de, #___str_4
	push	de
	call	_printf
	add	sp, #4
;utils.c:185: printf("\n\tseed:\t%u", SEED);
	ld	hl, #_SEED
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;utils.c:187: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 4)
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
;utils.c:188: }
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
;main.c:18: checkInput();     // Check for user input (and act on it)
	call	_checkInput
;main.c:19: updateSwitches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are on
	call	_updateSwitches
;main.c:21: wait_vbl_done();  // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;main.c:23: }
	jr	00102$
;main.c:25: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
	add	sp, #-3
;main.c:26: DISPLAY_ON; // Turn on the display
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
;main.c:42: move_sprite(0, (screen_x + sprite_size) / 2, (screen_y + sprite_size) / 2);
	ld	hl, #_screen_y
	ld	c, (hl)
	ld	b, #0x00
	ld	a, (#_sprite_size)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	pop	hl
	push	hl
	add	hl, bc
;	spillPairReg hl
;	spillPairReg hl
	ld	c,l
	ld	b,h
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00105$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00105$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#2
	ld	(hl), c
	ld	hl, #_screen_x
	ld	c, (hl)
	ld	b, #0x00
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00106$
	inc	bc
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
00106$:
	ld	c, h
	sra	l
	rr	c
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1399: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
;/home/spence/Documents/gbdk-2020/build/gbdk/include/gb/gb.h:1400: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
;main.c:45: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	hl, #_start_position
	ld	c, (hl)
	ld	b, #0x00
	ld	hl, #(_p + 6)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	hl, #(_p + 4)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	hl, #(_p + 2)
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ld	hl, #_p
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
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
	call	_display_map
;main.c:58: }
	add	sp, #3
	ret
___str_7:
	.db 0x0a
	.db 0x09
	.ascii "Welcome to"
	.db 0x0a
	.db 0x09
	.ascii "Pirate's Folly"
	.db 0x00
;main.c:60: void updateSwitches() {
;	---------------------------------
; Function updateSwitches
; ---------------------------------
_updateSwitches::
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
;main.c:66: void checkInput() {
;	---------------------------------
; Function checkInput
; ---------------------------------
_checkInput::
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
__xinit__SEED:
	.db #0x39	; 57	'9'
__xinit__start_position:
	.db #0x00	; 0
	.area _CABS (ABS)
