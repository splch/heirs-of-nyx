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
	.globl _time
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _load_map
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
	.globl _update_position
	.globl _rand
	.globl _initrand
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _start_position
	.globl _SEED
	.globl _start_time
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
	.ds 9
_start_time::
	.ds 2
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
;utils.c:5: void update_position() {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	dec	sp
;utils.c:6: UINT8 _x = p.x[0];
	ld	hl, #_p
	ld	c, (hl)
;utils.c:7: UINT8 _y = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#0
	ld	(hl), a
;utils.c:8: if (joypad() & J_RIGHT)
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00110$
;utils.c:9: _x++;
	inc	c
	jr	00111$
00110$:
;utils.c:10: else if (joypad() & J_UP)
	call	_joypad
	bit	2, e
	jr	Z, 00107$
;utils.c:11: _y--;
	ldhl	sp,	#0
	dec	(hl)
	jr	00111$
00107$:
;utils.c:12: else if (joypad() & J_LEFT)
	call	_joypad
	bit	1, e
	jr	Z, 00104$
;utils.c:13: _x--;
	dec	c
	jr	00111$
00104$:
;utils.c:14: else if (joypad() & J_DOWN)
	call	_joypad
	bit	3, e
	jr	Z, 00111$
;utils.c:15: _y++;
	ldhl	sp,	#0
	inc	(hl)
00111$:
;utils.c:16: if (_x != p.x[0]) {
	ld	hl, #_p
	ld	b, (hl)
;utils.c:19: p.steps++;
;utils.c:16: if (_x != p.x[0]) {
	ld	a, c
	sub	a, b
	jr	Z, 00115$
;utils.c:17: p.x[1] = p.x[0];
	ld	hl, #(_p + 1)
	ld	(hl), b
;utils.c:18: p.x[0] = _x;
	ld	hl, #_p
	ld	(hl), c
;utils.c:19: p.steps++;
	ld	a, (#(_p + 4) + 0)
	inc	a
	ld	(#(_p + 4)),a
	jr	00117$
00115$:
;utils.c:20: } else if (_y != p.y[0]) {
	ld	hl, #(_p + 2)
	ld	c, (hl)
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	jr	Z, 00117$
;utils.c:21: p.y[1] = p.y[0];
	ld	hl, #(_p + 3)
	ld	(hl), c
;utils.c:22: p.y[0] = _y;
	ld	de, #(_p + 2)
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;utils.c:23: p.steps++;
	ld	a, (#(_p + 4) + 0)
	inc	a
	ld	(#(_p + 4)),a
00117$:
;utils.c:25: }
	inc	sp
	ret
_sprite_size:
	.db #0x08	; 8
_screen_x:
	.db #0xa0	; 160
_screen_y:
	.db #0x90	; 144
_scale:
	.db #0x02	; 2
_player_sprite:
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x6c	; 108	'l'
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x7c	; 124
	.db #0x44	; 68	'D'
	.db #0x38	; 56	'8'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x00	; 0
_landscape:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x50	; 80	'P'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0xaa	; 170
	.db #0x00	; 0
	.db #0xa0	; 160
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
;utils.c:27: UINT8 noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function noise
; ---------------------------------
_noise::
;utils.c:29: initrand(x + y * SEED);
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	a, (#_SEED)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	__muluchar
	pop	hl
	pop	bc
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	call	_initrand
	inc	sp
	inc	sp
;utils.c:30: return rand();
;utils.c:34: }
	jp	_rand
;utils.c:36: UINT8 smooth_noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function smooth_noise
; ---------------------------------
_smooth_noise::
	add	sp, #-5
;utils.c:38: const UINT8 corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
;utils.c:41: const UINT8 sides =
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
;utils.c:44: const UINT8 center = noise(x, y) >> 2; // divide by 4
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
;utils.c:45: return corners + sides + center;
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	e, a
;utils.c:46: }
	add	sp, #5
	ret
;utils.c:48: UINT8 interpolate(UINT8 v1, UINT8 v2) {
;	---------------------------------
; Function interpolate
; ---------------------------------
_interpolate::
;utils.c:50: return (v1 + v2) >> 1; // divide by 2
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
;utils.c:54: }
	ret
;utils.c:56: UINT8 interpolate_noise(UINT8 x, UINT8 y) {
;	---------------------------------
; Function interpolate_noise
; ---------------------------------
_interpolate_noise::
	dec	sp
;utils.c:58: UINT8 v1 = smooth_noise(x, y);
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_smooth_noise
	pop	hl
	ld	b, e
;utils.c:59: UINT8 v2 = smooth_noise(x + 1, y);
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
;utils.c:60: const UINT8 i1 = interpolate(v1, v2);
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
;utils.c:61: v1 = smooth_noise(x, y + 1);
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
;utils.c:62: v2 = smooth_noise(x + 1, y + 1);
	push	de
	push	bc
	call	_smooth_noise
	pop	hl
	ld	a, e
	pop	de
;utils.c:63: const UINT8 i2 = interpolate(v1, v2);
	ld	d,a
	push	de
	call	_interpolate
	pop	hl
	ld	a, e
;utils.c:64: return interpolate(i1, i2);
	push	af
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl)
	push	af
	inc	sp
	call	_interpolate
	pop	hl
;utils.c:65: }
	inc	sp
	ret
;utils.c:68: unsigned char closest(UINT8 value) {
;	---------------------------------
; Function closest
; ---------------------------------
_closest::
;utils.c:69: if (value < 110)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x6e
	jr	NC, 00108$
;utils.c:70: return 0x01; // water
	ld	e, #0x01
	ret
00108$:
;utils.c:71: else if (value < 150)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x96
	jr	NC, 00105$
;utils.c:72: return 0x02; // grass
	ld	e, #0x02
	ret
00105$:
;utils.c:73: else if (value < 160)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0xa0
	jr	NC, 00102$
;utils.c:74: return 0x03; // trees
	ld	e, #0x03
	ret
00102$:
;utils.c:76: return 0x04; // mountains
	ld	e, #0x04
;utils.c:77: }
	ret
;utils.c:79: unsigned char terrain(UINT8 x, UINT8 y) {
;	---------------------------------
; Function terrain
; ---------------------------------
_terrain::
;utils.c:82: const UINT8 value = interpolate_noise(x / scale, y / scale);
	ld	a, #0x02
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	__divuchar
	pop	hl
	ld	b, e
	push	bc
	ld	a, #0x02
	push	af
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
;utils.c:83: return closest(value);
	push	af
	inc	sp
	call	_closest
	inc	sp
;utils.c:84: }
	ret
;utils.c:86: void shift_left(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_left
; ---------------------------------
_shift_left::
	add	sp, #-10
;utils.c:87: for (int x = 0; x < pixel_x - 1; x++)
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
;utils.c:88: for (int y = 0; y < pixel_y; y++)
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
;utils.c:89: map[x][y] = map[x + 1][y];
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
;utils.c:88: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:87: for (int x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:90: }
	add	sp, #10
	ret
;utils.c:92: void shift_right(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_right
; ---------------------------------
_shift_right::
	add	sp, #-10
;utils.c:93: for (int x = pixel_x - 1; x > 0; x--)
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
;utils.c:94: for (int y = 0; y < pixel_y; y++)
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
;utils.c:95: map[x][y] = map[x - 1][y];
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
;utils.c:94: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:93: for (int x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	jp	00107$
00109$:
;utils.c:96: }
	add	sp, #10
	ret
;utils.c:98: void shift_up(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_up
; ---------------------------------
_shift_up::
	add	sp, #-4
;utils.c:99: for (int y = 0; y < pixel_y - 1; y++)
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
;utils.c:100: for (int x = 0; x < pixel_x; x++)
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
;utils.c:101: map[x][y] = map[x][y + 1];
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
;utils.c:100: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:99: for (int y = 0; y < pixel_y - 1; y++)
	inc	bc
	jr	00107$
00109$:
;utils.c:102: }
	add	sp, #4
	ret
;utils.c:104: void shift_down(const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function shift_down
; ---------------------------------
_shift_down::
	add	sp, #-4
;utils.c:105: for (int y = pixel_y - 1; y > 0; y--)
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
;utils.c:106: for (int x = 0; x < pixel_x; x++)
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
;utils.c:107: map[x][y] = map[x][y - 1];
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
;utils.c:106: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00108$:
;utils.c:105: for (int y = pixel_y - 1; y > 0; y--)
	dec	bc
	jr	00107$
00109$:
;utils.c:108: }
	add	sp, #4
	ret
;utils.c:110: void generate_side(const char side, const UINT8 pixel_x, const UINT8 pixel_y) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-11
;utils.c:114: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:117: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
;utils.c:112: switch (side) {
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00133$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00135$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00131$
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x74
	jp	NZ,00122$
;utils.c:114: for (int x = 0; x < pixel_x; x++)
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00111$:
	ldhl	sp,	#9
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
	jr	NC, 00131$
;utils.c:115: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ldhl	sp,#9
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
	inc	sp
	inc	sp
	push	hl
	ld	de, #_map
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
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ldhl	sp,	#9
	ld	c, (hl)
	ld	a, (#_p + 0)
	add	a, c
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	c, e
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;utils.c:114: for (int x = 0; x < pixel_x; x++)
	ldhl	sp,	#9
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
;utils.c:117: for (int y = 0; y < pixel_y; y++)
00131$:
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00114$:
	ldhl	sp,	#9
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
	jr	Z, 00196$
	bit	7, d
	jr	NZ, 00197$
	cp	a, a
	jr	00197$
00196$:
	bit	7, d
	jr	Z, 00197$
	scf
00197$:
	jr	NC, 00133$
;utils.c:118: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
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
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	de, #_map
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#9
	ld	a, (hl)
	ld	hl, #(_p + 2)
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	dec	a
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#10
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
;utils.c:117: for (int y = 0; y < pixel_y; y++)
	ldhl	sp,	#9
	inc	(hl)
	jp	NZ,00114$
	inc	hl
	inc	(hl)
	jp	00114$
;utils.c:120: for (int x = 0; x < pixel_x; x++)
00133$:
	ld	bc, #0x0000
00117$:
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00199$
	bit	7, d
	jr	NZ, 00200$
	cp	a, a
	jr	00200$
00199$:
	bit	7, d
	jr	Z, 00200$
	scf
00200$:
	jr	NC, 00135$
;utils.c:121: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
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
	ldhl	sp,	#15
	ld	a, (hl)
	dec	a
	ldhl	sp,	#10
	ld	(hl), a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, (hl)
	ld	(hl), a
	ld	a, c
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#12
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
	ldhl	sp,	#8
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:120: for (int x = 0; x < pixel_x; x++)
	inc	bc
	jr	00117$
;utils.c:123: for (int y = 0; y < pixel_y; y++)
00135$:
	ld	bc, #0x0000
00120$:
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00201$
	bit	7, d
	jr	NZ, 00202$
	cp	a, a
	jr	00202$
00201$:
	bit	7, d
	jr	Z, 00202$
	scf
00202$:
	jr	NC, 00122$
;utils.c:124: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ld	hl, #_map
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, c
	ld	hl, #(_p + 2)
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
	ldhl	sp,	#9
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:123: for (int y = 0; y < pixel_y; y++)
	inc	bc
	jr	00120$
;utils.c:125: }
00122$:
;utils.c:126: }
	add	sp, #11
	ret
;utils.c:128: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-7
;utils.c:129: const UINT8 pixel_x = screen_x / sprite_size;
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
;utils.c:130: const UINT8 pixel_y = screen_y / sprite_size;
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
;utils.c:131: const INT8 diff_x = p.x[1] - p.x[0];
	ld	hl, #_p
	ld	c, (hl)
	ld	a, (#(_p + 1) + 0)
	sub	a, c
	ldhl	sp,	#4
	ld	(hl), a
;utils.c:132: const INT8 diff_y = p.y[1] - p.y[0];
	ld	hl, #(_p + 2)
	ld	c, (hl)
	ld	a, (#(_p + 3) + 0)
	sub	a, c
	ldhl	sp,	#5
	ld	(hl), a
;utils.c:133: if (p.steps > 0) {
	ld	a, (#(_p + 4) + 0)
	ldhl	sp,#6
	ld	(hl), a
	or	a, a
	jp	Z, 00132$
;utils.c:134: if (diff_x < 0) {
	dec	hl
	dec	hl
	bit	7, (hl)
	jr	Z, 00104$
;utils.c:136: shift_left(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_left
	pop	hl
;utils.c:137: generate_side('r', pixel_x, pixel_y);
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
;utils.c:138: } else if (diff_x > 0) {
	ldhl	sp,	#4
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
;utils.c:140: shift_right(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_right
	pop	hl
;utils.c:141: generate_side('l', pixel_x, pixel_y);
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
;utils.c:143: if (diff_y < 0) {
	ldhl	sp,	#5
	bit	7, (hl)
	jr	Z, 00109$
;utils.c:145: shift_up(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_up
	pop	hl
;utils.c:146: generate_side('b', pixel_x, pixel_y);
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
;utils.c:147: } else if (diff_y > 0) {
	ldhl	sp,	#5
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
;utils.c:149: shift_down(pixel_x, pixel_y);
	ldhl	sp,	#1
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_shift_down
	pop	hl
;utils.c:150: generate_side('t', pixel_x, pixel_y);
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
;utils.c:152: p.x[1] = p.x[0];
	ld	bc, #_p + 1
	ld	a, (#_p + 0)
	ld	(bc), a
;utils.c:153: p.y[1] = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ld	(#(_p + 3)),a
	jr	00122$
;utils.c:155: for (UINT8 x = 0; x < pixel_x; x++)
00132$:
	ldhl	sp,	#6
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	jr	NC, 00122$
;utils.c:156: for (UINT8 y = 0; y < pixel_y; y++)
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
;utils.c:157: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
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
	ld	a, (#(_p + 2) + 0)
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
;utils.c:156: for (UINT8 y = 0; y < pixel_y; y++)
	inc	c
	jr	00117$
00121$:
;utils.c:155: for (UINT8 x = 0; x < pixel_x; x++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00120$
00122$:
;utils.c:158: }
	add	sp, #7
	ret
;utils.c:160: void load_map() {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
;utils.c:161: for (UINT8 i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	ret	NC
;utils.c:162: set_bkg_tiles(0, 0, 20, 18, map[i]);
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
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;utils.c:161: for (UINT8 i = 0; i < 20; i++)
	inc	c
;utils.c:163: }
	jr	00103$
;main.c:19: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:20: init();
	call	_init
;main.c:22: while (1) {
00102$:
;main.c:23: checkInput();     // Check for user input (and act on it)
	call	_checkInput
;main.c:24: updateSwitches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are on
	call	_updateSwitches
;main.c:26: wait_vbl_done();  // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;main.c:28: }
	jr	00102$
;main.c:30: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
	add	sp, #-3
;main.c:31: DISPLAY_ON; // Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:33: font_init();                   // Initialize font
	call	_font_init
;main.c:34: font_set(font_load(font_ibm)); // Set and load the font
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;main.c:36: set_bkg_data(0, 3, landscape);
	ld	de, #_landscape
	push	de
	ld	hl, #0x300
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:39: set_sprite_data(0, 0, player_sprite);
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
;main.c:46: move_sprite(0, (screen_x + sprite_size) / 2, (screen_y + sprite_size) / 2);
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
;main.c:49: start_time = time(NULL);
	ld	de, #0x0000
	push	de
	call	_time
	pop	hl
	ld	hl, #_start_time
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:51: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	de, #(_p + 3)
	ld	hl, #_start_position
	ld	a, (hl)
	ld	(de), a
	ld	de, #(_p + 2)
	ld	a, (hl)
	ld	(de), a
	ld	de, #(_p + 1)
	ld	a, (hl)
	ld	(de), a
	ld	de, #_p
	ld	a, (hl)
	ld	(de), a
;main.c:53: p.steps = p.gold = p.maps = 0;
	ld	hl, #(_p + 8)
	ld	(hl), #0x00
	ld	hl, #(_p + 7)
	ld	(hl), #0x00
	ld	hl, #(_p + 4)
	ld	(hl), #0x00
;main.c:54: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 6)
	ld	(hl), #0xff
	ld	hl, #(_p + 5)
	ld	(hl), #0xff
;main.c:56: generate_map();
	call	_generate_map
;main.c:57: load_map();
	call	_load_map
;main.c:58: }
	add	sp, #3
	ret
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
;main.c:67: if (joypad()) {
	call	_joypad
	ld	a, e
	or	a, a
	ret	Z
;main.c:68: update_position();
	call	_update_position
;main.c:69: generate_map();
	call	_generate_map
;main.c:70: load_map();
;main.c:72: }
	jp	_load_map
	.area _CODE
	.area _INITIALIZER
__xinit__SEED:
	.db #0x39	; 57	'9'
__xinit__start_position:
	.db #0x7f	; 127
	.area _CABS (ABS)
