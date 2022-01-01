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
	.globl _terrain
	.globl _noise
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
;utils.c:5: unsigned char noise(unsigned char x, unsigned char y) {
;	---------------------------------
; Function noise
; ---------------------------------
_noise::
;utils.c:7: x ^= (y << 7);
	ldhl	sp,	#3
	ld	a, (hl-)
	rrca
	and	a, #0x80
	xor	a, (hl)
;utils.c:8: x ^= (x >> 5);
	ld	(hl), a
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
;utils.c:9: y ^= (x << 3);
	ld	(hl+), a
	add	a, a
	add	a, a
	add	a, a
	xor	a, (hl)
;utils.c:10: y ^= (y >> 1);
	ld	(hl), a
	srl	a
	xor	a, (hl)
;utils.c:11: return x ^ y * SEED;
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
;utils.c:12: }
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
;utils.c:14: static inline unsigned char smooth_noise(unsigned char x, unsigned char y) {
;	---------------------------------
; Function smooth_noise
; ---------------------------------
_smooth_noise:
	add	sp, #-5
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
;utils.c:19: const unsigned char sides =
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
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
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
;utils.c:23: return corners + sides + center;               // average noise at center
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, c
	add	a, e
	ld	e, a
;utils.c:24: }
	add	sp, #5
	ret
;utils.c:26: static inline unsigned char interpolate(unsigned char v1, unsigned char v2) {
;	---------------------------------
; Function interpolate
; ---------------------------------
_interpolate:
;utils.c:28: return (v1 + v2) >> 1; // divide by 2
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
;utils.c:29: }
	ret
;utils.c:31: static inline unsigned char interpolate_noise(unsigned char x,
;	---------------------------------
; Function interpolate_noise
; ---------------------------------
_interpolate_noise:
	add	sp, #-10
;utils.c:34: unsigned char v1 = smooth_noise(x, y);
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#2
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	dec	a
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	dec	a
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	ld	d, #0x00
	ldhl	sp,	#8
	ld	a, (hl)
	inc	a
	ldhl	sp,	#5
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
	ldhl	sp,	#9
	ld	a, (hl)
	inc	a
	ldhl	sp,	#6
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
	ld	c, l
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
	sra	h
	rr	c
;utils.c:19: const unsigned char sides =
	push	bc
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
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
	push	bc
	push	de
	ldhl	sp,	#10
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
	ld	b, l
	sra	h
	rr	b
	sra	h
	rr	b
	sra	h
	rr	b
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:34: unsigned char v1 = smooth_noise(x, y);
	ld	a, c
	add	a, b
	add	a, e
	ldhl	sp,	#7
;utils.c:35: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#5
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
	ldhl	sp,	#7
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
	ldhl	sp,	#10
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
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#9
	ld	(hl), e
;utils.c:19: const unsigned char sides =
	push	bc
	ldhl	sp,	#3
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
	ldhl	sp,	#3
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
	ldhl	sp,	#5
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
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	push	hl
	ldhl	sp,	#8
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
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#3
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
;utils.c:35: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#9
;utils.c:36: const unsigned char i1 = interpolate(v1, v2);
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
	ldhl	sp,	#9
	ld	(hl), c
;utils.c:37: v1 = smooth_noise(x, y + 1);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	push	bc
	inc	sp
	ldhl	sp,	#7
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
	ldhl	sp,	#8
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
	ldhl	sp,	#9
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
	ldhl	sp,	#8
;utils.c:19: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ldhl	sp,	#3
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
	push	bc
	ldhl	sp,	#9
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
	ldhl	sp,	#3
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
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#5
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
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:23: return corners + sides + center;               // average noise at center
	ldhl	sp,	#8
	ld	a, (hl)
	add	a, c
	add	a, e
;utils.c:38: v2 = smooth_noise(x + 1, y + 1);
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#7
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
	ldhl	sp,	#5
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
	ldhl	sp,	#6
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
	ldhl	sp,	#9
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
	ldhl	sp,	#6
;utils.c:19: const unsigned char sides =
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
	ldhl	sp,	#9
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
	ldhl	sp,	#6
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
	ldhl	sp,	#7
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
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#9
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:23: return corners + sides + center;               // average noise at center
	ldhl	sp,	#6
;utils.c:39: const unsigned char i2 = interpolate(v1, v2);
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
;utils.c:28: return (v1 + v2) >> 1; // divide by 2
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
	ld	e, l
	sra	h
	rr	e
;utils.c:40: return interpolate(i1, i2); // average of smoothed sides
;utils.c:41: }
	add	sp, #10
	ret
;utils.c:43: static inline unsigned char closest(unsigned char value) {
;	---------------------------------
; Function closest
; ---------------------------------
_closest:
;utils.c:45: if (value < 100)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x64
	jr	NC, 00108$
;utils.c:46: return 0x01; // water
	ld	e, #0x01
	ret
00108$:
;utils.c:47: else if (value < 135)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x87
	jr	NC, 00105$
;utils.c:48: return 0x00; // grass
	ld	e, #0x00
	ret
00105$:
;utils.c:49: else if (value < 160)
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0xa0
	jr	NC, 00102$
;utils.c:50: return 0x02; // trees
	ld	e, #0x02
	ret
00102$:
;utils.c:52: return 0x03; // mountains
	ld	e, #0x03
;utils.c:53: }
	ret
;utils.c:55: unsigned char terrain(unsigned char x, unsigned char y) {
;	---------------------------------
; Function terrain
; ---------------------------------
_terrain::
	add	sp, #-9
;utils.c:58: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
	jr	Z, 00121$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00121$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#0
	ld	(hl), c
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00122$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00122$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#1
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	c, a
	dec	a
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	dec	a
	ld	(hl-), a
	push	bc
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	ld	a, b
	inc	a
	ldhl	sp,	#4
	ld	(hl-), a
	dec	hl
	push	bc
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
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	inc	a
	ldhl	sp,	#5
	ld	(hl), a
	push	de
	ld	a, (hl-)
	dec	hl
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
	push	hl
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, e
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
	ldhl	sp,	#8
	ld	(hl), c
;utils.c:19: const unsigned char sides =
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	ld	d, #0x00
	push	de
	ldhl	sp,	#2
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
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	push	hl
	ldhl	sp,	#4
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
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
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
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:34: unsigned char v1 = smooth_noise(x, y);
	ld	a, c
	ldhl	sp,	#8
	add	a, (hl)
	dec	hl
	dec	hl
	add	a, e
;utils.c:35: unsigned char v2 = smooth_noise(x + 1, y);
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	c, (hl)
	ld	b, c
	dec	b
	push	bc
	ldhl	sp,	#4
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
	ldhl	sp,	#6
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
	ldhl	sp,	#9
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
	ldhl	sp,	#9
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
	ldhl	sp,	#8
	ld	(hl), e
;utils.c:19: const unsigned char sides =
	push	bc
	ldhl	sp,	#2
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
	ldhl	sp,	#2
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
	ldhl	sp,	#4
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
	push	hl
	ldhl	sp,	#7
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
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	push	bc
	ldhl	sp,	#2
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
;utils.c:35: unsigned char v2 = smooth_noise(x + 1, y);
	ld	a, c
	ldhl	sp,	#8
	add	a, (hl)
;utils.c:36: const unsigned char i1 = interpolate(v1, v2);
	dec	hl
	dec	hl
	add	a, e
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
;utils.c:58: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, (hl+)
	ld	b, a
	add	a, #0xff
	ld	(hl), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#9
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
	inc	b
	push	bc
	push	de
	push	bc
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
	pop	bc
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	e, l
	ld	d, h
	push	bc
	push	de
	push	bc
	inc	sp
	ldhl	sp,	#9
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
	ldhl	sp,	#8
;utils.c:19: const unsigned char sides =
	ld	a, e
	ld	(hl-), a
	dec	hl
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
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
	ldhl	sp,	#11
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#6
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
	push	bc
	inc	sp
	ldhl	sp,	#6
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
	ldhl	sp,	#7
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:58: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#7
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;utils.c:16: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	(hl), a
	dec	a
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	b, a
	dec	a
	ld	(hl-), a
	push	bc
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	inc	b
	push	bc
	push	de
	ldhl	sp,	#7
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
	ldhl	sp,	#6
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	push	bc
	push	de
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
	ldhl	sp,	#9
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
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#6
;utils.c:19: const unsigned char sides =
	ld	a, e
	ld	(hl+), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	ld	d, #0x00
	push	bc
	push	de
	ldhl	sp,	#11
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
	push	bc
	push	de
	ldhl	sp,	#9
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
	ld	e, l
	ld	d, h
	sra	d
	rr	e
	sra	d
	rr	e
	sra	d
	rr	e
	ldhl	sp,	#5
;utils.c:22: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, e
	ld	(hl+), a
	inc	hl
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_noise
	pop	hl
	pop	bc
	srl	e
	srl	e
;utils.c:58: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#5
	ld	a, (hl+)
	add	a, (hl)
;utils.c:39: const unsigned char i2 = interpolate(v1, v2);
	inc	hl
	inc	hl
	add	a, e
	ld	e, (hl)
	ld	d, #0x00
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	ld	l, a
	add	hl, de
	sra	h
	rr	l
;utils.c:58: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ld	b, #0x00
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	add	hl, bc
	sra	h
	rr	l
	ld	a, l
;utils.c:45: if (value < 100)
	cp	a, #0x64
	jr	NC, 00116$
;utils.c:46: return 0x01; // water
	ld	e, #0x01
	jr	00118$
00116$:
;utils.c:47: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00114$
;utils.c:48: return 0x00; // grass
	ld	e, #0x00
	jr	00118$
00114$:
;utils.c:49: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00112$
;utils.c:50: return 0x02; // trees
	ld	e, #0x02
	jr	00118$
00112$:
;utils.c:52: return 0x03; // mountains
	ld	e, #0x03
;utils.c:59: return closest(value);
00118$:
;utils.c:60: }
	add	sp, #9
	ret
;utils.c:62: void shift_array_left(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-7
;utils.c:64: for (unsigned char x = 0; x < pixel_x - 1; x++)
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
;utils.c:65: for (unsigned char y = 0; y < pixel_y; y++)
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
;utils.c:66: map[x][y] = map[x + 1][y];
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
;utils.c:65: for (unsigned char y = 0; y < pixel_y; y++)
	inc	c
	jr	00104$
00108$:
;utils.c:64: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00107$
00109$:
;utils.c:67: }
	add	sp, #7
	ret
;utils.c:69: void shift_array_right(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;utils.c:71: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ldhl	sp,	#6
	ld	c, (hl)
	dec	c
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;utils.c:72: for (unsigned char y = 0; y < pixel_y; y++)
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
;utils.c:73: map[x][y] = map[x - 1][y];
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
;utils.c:72: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;utils.c:71: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;utils.c:74: }
	add	sp, #4
	ret
;utils.c:76: void shift_array_up(const unsigned char pixel_x, const unsigned char pixel_y) {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
	add	sp, #-4
;utils.c:77: for (unsigned char y = 0; y < pixel_y - 1; y++)
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
;utils.c:78: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#3
	ld	(hl), #0x00
00104$:
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:79: map[x][y] = map[x][y + 1];
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
;utils.c:78: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00104$
00108$:
;utils.c:77: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ldhl	sp,	#2
	inc	(hl)
	jr	00107$
00109$:
;utils.c:80: }
	add	sp, #4
	ret
;utils.c:82: void shift_array_down(const unsigned char pixel_x,
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;utils.c:84: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ldhl	sp,	#3
	ld	c, (hl)
	dec	c
00107$:
	ld	a, c
	or	a, a
	ret	Z
;utils.c:85: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	ldhl	sp,	#2
	sub	a, (hl)
	jr	NC, 00108$
;utils.c:86: map[x][y] = map[x][y - 1];
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
;utils.c:85: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;utils.c:84: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;utils.c:87: }
	jr	00107$
;utils.c:89: void generate_side(const char side, const unsigned char pixel_x,
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	dec	sp
	dec	sp
;utils.c:92: switch (side) {
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00133$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00135$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00131$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x74
	jp	NZ,00122$
;utils.c:94: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#1
	ld	(hl), #0x00
00111$:
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	sub	a, (hl)
	jp	NC, 00122$
;utils.c:95: map[x][0] = terrain(x + p.x[0], p.y[0]);
	ldhl	sp,	#1
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
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_p + 0)
	ldhl	sp,	#1
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
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	ld	(bc), a
;utils.c:94: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#1
	inc	(hl)
	jr	00111$
;utils.c:98: for (unsigned char y = 0; y < pixel_y; y++)
00131$:
	ldhl	sp,	#1
	ld	(hl), #0x00
00114$:
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jp	NC, 00122$
;utils.c:99: map[pixel_x - 1][y] = terrain(pixel_x - 1 + p.x[0], y + p.y[0]);
	dec	hl
	ld	c, (hl)
	ld	b, #0x00
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
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#1
	add	a, (hl)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	ld	hl, #_p
	ld	l, (hl)
;	spillPairReg hl
	add	a, l
	push	bc
	ldhl	sp,	#2
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
;utils.c:98: for (unsigned char y = 0; y < pixel_y; y++)
	ldhl	sp,	#1
	inc	(hl)
	jr	00114$
;utils.c:102: for (unsigned char x = 0; x < pixel_x; x++)
00133$:
	ld	c, #0x00
00117$:
	ld	a, c
	ldhl	sp,	#5
	sub	a, (hl)
	jr	NC, 00122$
;utils.c:103: map[x][pixel_y - 1] = terrain(x + p.x[0], pixel_y - 1 + p.y[0]);
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
	ldhl	sp,	#6
	ld	b, (hl)
	dec	b
	ld	l, b
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ld	a, (#(_p + 8) + 0)
	add	a, b
	ld	b, a
	ld	a, (#_p + 0)
	add	a, c
	push	bc
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_terrain
	pop	hl
	ld	a, e
	pop	bc
	pop	hl
	push	hl
	ld	(hl), a
;utils.c:102: for (unsigned char x = 0; x < pixel_x; x++)
	inc	c
	jr	00117$
;utils.c:106: for (unsigned char y = 0; y < pixel_y; y++)
00135$:
	ldhl	sp,	#1
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NC, 00122$
;utils.c:107: map[0][y] = terrain(p.x[0], y + p.y[0]);
	ld	de, #_map
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#1
	add	a, (hl)
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
	ld	(bc), a
;utils.c:106: for (unsigned char y = 0; y < pixel_y; y++)
	ldhl	sp,	#1
	inc	(hl)
	jr	00120$
;utils.c:109: }
00122$:
;utils.c:110: }
	inc	sp
	inc	sp
	ret
;utils.c:112: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-6
;utils.c:115: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #(_p + 4)
	ld	c, (hl)
	ld	hl, #_p
	ld	b, (hl)
	ld	a, c
	sub	a, b
	ldhl	sp,	#0
	ld	(hl), a
;utils.c:116: const char diff_y = p.y[1] - p.y[0];
	ld	a, (#(_p + 12) + 0)
	ld	hl, #(_p + 8)
	ld	c, (hl)
	sub	a, c
	ldhl	sp,	#1
;utils.c:117: if (p.steps > 0) {
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
	jp	Z, 00132$
;utils.c:118: if (diff_x < 0) {
	dec	hl
	dec	hl
	bit	7, (hl)
	jr	Z, 00104$
;utils.c:120: shift_array_left(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_left
	pop	hl
;utils.c:121: generate_side('r', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x72
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00105$
00104$:
;utils.c:122: } else if (diff_x > 0) {
	ldhl	sp,	#0
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
;utils.c:124: shift_array_right(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_right
	pop	hl
;utils.c:125: generate_side('l', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00105$:
;utils.c:127: if (diff_y < 0) {
	ldhl	sp,	#1
	bit	7, (hl)
	jr	Z, 00109$
;utils.c:129: shift_array_up(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_up
	pop	hl
;utils.c:130: generate_side('b', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
	jr	00110$
00109$:
;utils.c:131: } else if (diff_y > 0) {
	ldhl	sp,	#1
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
;utils.c:133: shift_array_down(pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	call	_shift_array_down
	pop	hl
;utils.c:134: generate_side('t', pixel_x, pixel_y);
	ld	hl, #0x1214
	push	hl
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	add	sp, #3
00110$:
;utils.c:137: p.x[1] = p.x[0];
	ld	de, #_p
	ld	a, (de)
	ldhl	sp,	#2
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
	ldhl	sp,	#2
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
;utils.c:138: p.y[1] = p.y[0];
	ld	de, #(_p + 8)
	ld	a, (de)
	ldhl	sp,	#2
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
	ldhl	sp,	#2
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
	jr	00122$
;utils.c:141: for (unsigned char x = 0; x < pixel_x; x++)
00132$:
	ldhl	sp,	#5
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x14
	jr	NC, 00122$
;utils.c:142: for (unsigned char y = 0; y < pixel_y; y++)
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
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), a
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x12
	jr	NC, 00121$
;utils.c:143: map[x][y] = terrain(x + p.x[0], y + p.y[0]);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, c
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, (#(_p + 8) + 0)
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
	ldhl	sp,	#3
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;utils.c:142: for (unsigned char y = 0; y < pixel_y; y++)
	inc	c
	jr	00117$
00121$:
;utils.c:141: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#5
	inc	(hl)
	jr	00120$
00122$:
;utils.c:145: }
	add	sp, #6
	ret
;utils.c:147: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;utils.c:148: for (unsigned char i = 0; i < 20; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;utils.c:149: set_bkg_tiles(i, 0, 1, 18, map[i]);
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
;utils.c:148: for (unsigned char i = 0; i < 20; i++)
	inc	c
	jr	00103$
00101$:
;utils.c:150: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;utils.c:151: }
	ret
;utils.c:153: void update_position() {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-13
;utils.c:154: bool update = false;
	ldhl	sp,	#4
	ld	(hl), #0x00
;utils.c:155: unsigned char _x = p.x[0];
	ld	hl, #_p
	ld	c, (hl)
;utils.c:156: unsigned char _y = p.y[0];
	ld	a, (#(_p + 8) + 0)
	ldhl	sp,	#12
	ld	(hl), a
;utils.c:157: if (joypad() & J_RIGHT)
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00104$
;utils.c:158: _x++;
	inc	c
	jr	00105$
00104$:
;utils.c:159: else if (joypad() & J_LEFT)
	call	_joypad
	bit	1, e
	jr	Z, 00105$
;utils.c:160: _x--;
	dec	c
00105$:
;utils.c:161: if (joypad() & J_UP)
	call	_joypad
	bit	2, e
	jr	Z, 00109$
;utils.c:162: _y--;
	ldhl	sp,	#12
	dec	(hl)
	jr	00110$
00109$:
;utils.c:163: else if (joypad() & J_DOWN)
	call	_joypad
	bit	3, e
	jr	Z, 00110$
;utils.c:164: _y++;
	ldhl	sp,	#12
	inc	(hl)
00110$:
;utils.c:165: if (_x != p.x[0]) {
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
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl+), a
	ld	(hl), a
;utils.c:168: p.steps++;
	ld	bc, #_p + 16
;utils.c:165: if (_x != p.x[0]) {
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#8
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#9
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#10
	sub	a, (hl)
	jr	NZ, 00159$
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#11
	sub	a, (hl)
	jr	Z, 00114$
00159$:
;utils.c:166: p.x[1] = p.x[0];
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
;utils.c:167: p.x[0] = _x;
	ld	de, #_p
	ldhl	sp,	#8
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
;utils.c:168: p.steps++;
	ld	e, c
	ld	d, b
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
	ldhl	sp,	#12
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
	ldhl	sp,	#12
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
;utils.c:169: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
	jp	00115$
00114$:
;utils.c:170: } else if (_y != p.y[0]) {
	ld	de, #(_p + 8)
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
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NZ, 00160$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	sub	a, (hl)
	jr	Z, 00115$
00160$:
;utils.c:171: p.y[1] = p.y[0];
	ld	de, #(_p + 12)
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
;utils.c:172: p.y[0] = _y;
	ld	a, (hl+)
	ld	(de), a
	ld	de, #(_p + 8)
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
;utils.c:173: p.steps++;
	ld	e, c
	ld	d, b
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
	ldhl	sp,	#12
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
	ldhl	sp,	#12
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
;utils.c:174: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
00115$:
;utils.c:176: if (update == true) {
	ldhl	sp,	#4
	ld	a, (hl)
	dec	a
	jr	NZ, 00118$
;utils.c:177: generate_map();
	call	_generate_map
;utils.c:178: display_map();
	call	_display_map
00118$:
;utils.c:180: }
	add	sp, #13
	ret
;utils.c:182: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
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
;main.c:47: p.steps = p.gold = p.maps = 0;
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
;main.c:48: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 21)
	ld	(hl), #0xff
	ld	hl, #(_p + 20)
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
;main.c:66: if (joypad() & J_START) {
	call	_joypad
	ld	a, e
	rlca
	jr	NC, 00104$
;main.c:67: display_map();
	call	_display_map
;main.c:68: show_menu();
	jp	_show_menu
00104$:
;main.c:69: } else if (joypad())
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
