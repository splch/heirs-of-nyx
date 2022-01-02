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
	.globl _generate_item
	.globl _terrain
	.globl _puts
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
;src/utils.c:56: unsigned char terrain(unsigned char x, unsigned char y) {
;	---------------------------------
; Function terrain
; ---------------------------------
_terrain::
	add	sp, #-14
;src/utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
	jr	Z, 00157$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00157$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#0
	ld	(hl), c
	ldhl	sp,	#16
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00158$
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
00158$:
	ld	c, l
	ld	b, h
	sra	b
	rr	c
	ldhl	sp,	#1
;src/utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	dec	a
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#3
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
	ldhl	sp,	#12
	ld	a, (hl)
	inc	a
	ldhl	sp,	#4
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
	ld	e, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#13
	ld	b, (hl)
	inc	b
	ld	e, b
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#3
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
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#4
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
	sra	d
	rr	e
	ldhl	sp,	#9
	ld	(hl), e
;src/utils.c:21: const unsigned char sides =
	ldhl	sp,	#13
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#5
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
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
	ld	(hl), #0x00
	ldhl	sp,	#4
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
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
	ldhl	sp,	#2
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
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#1
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
	ld	c, e
;src/utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
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
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
	rrca
	rrca
	and	a, #0x3f
	ld	e, a
;src/utils.c:35: unsigned char v1 = smooth_noise(x, y);
	ld	a, c
	ldhl	sp,	#9
	add	a, (hl)
	dec	hl
	dec	hl
	add	a, e
	ld	(hl), a
;src/utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	ldhl	sp,	#4
	ld	c, (hl)
;src/utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ld	a, c
	dec	a
	ldhl	sp,	#8
	ld	(hl), a
	ld	e, (hl)
	ldhl	sp,	#2
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
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, c
	inc	a
	ldhl	sp,	#9
	ld	(hl), a
	ld	c, (hl)
	ldhl	sp,	#2
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
	ld	(hl), a
	ld	a, b
	rrca
	and	a, #0x80
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
	ldhl	sp,	#13
	ld	(hl), e
;src/utils.c:21: const unsigned char sides =
	ldhl	sp,	#8
	ld	a, (hl)
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
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#9
	ld	a, (hl)
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
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#2
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
	ldhl	sp,	#9
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
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#4
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
	ld	c, e
;src/utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ldhl	sp,	#6
	ld	a, (hl)
	swap	a
	rrca
	and	a, #0x07
	xor	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	add	a, a
	add	a, a
	add	a, a
	ldhl	sp,	#0
	xor	a, (hl)
	ld	e, a
	srl	a
	xor	a, e
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
;src/utils.c:36: unsigned char v2 = smooth_noise(x + 1, y);
	inc	hl
	ld	e, a
	srl	e
	srl	e
	ld	a, c
	add	a, (hl)
	add	a, e
;src/utils.c:37: const unsigned char i1 = interpolate(v1, v2);
	ldhl	sp,	#7
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
	ldhl	sp,	#13
;src/utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
;src/utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
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
	ldhl	sp,	#3
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
	ldhl	sp,	#8
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#4
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
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
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
	ldhl	sp,	#12
	ld	a, (hl-)
	inc	a
	ld	(hl), a
	ld	e, (hl)
	ld	a, e
	rrca
	and	a, #0x80
	ldhl	sp,	#3
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
	ldhl	sp,	#6
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
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#4
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
	xor	a, c
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
	sra	d
	rr	e
	ldhl	sp,	#12
	ld	(hl), e
;src/utils.c:21: const unsigned char sides =
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#3
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
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#4
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
	ldhl	sp,	#6
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
	ld	(hl+), a
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#1
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
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#8
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
	ldhl	sp,	#11
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#1
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
	xor	a, c
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#6
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
;src/utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#1
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#11
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
	ldhl	sp,	#11
	xor	a, (hl)
;src/utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
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
	ldhl	sp,	#4
	ld	e, (hl)
;src/utils.c:18: const unsigned char corners = (noise(x - 1, y - 1) + noise(x + 1, y - 1) +
	ldhl	sp,	#12
	ld	(hl), a
	dec	a
	ldhl	sp,	#6
	ld	(hl), a
	ld	d, (hl)
	ldhl	sp,	#9
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
	ldhl	sp,	#11
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
	ldhl	sp,	#11
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
	ldhl	sp,	#9
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
	ldhl	sp,	#9
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
	ldhl	sp,	#12
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
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#2
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
	ldhl	sp,	#12
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
	ldhl	sp,	#12
	ld	(hl), e
;src/utils.c:21: const unsigned char sides =
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#7
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#11
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
	ldhl	sp,	#11
	xor	a, (hl)
	dec	hl
	ld	(hl+), a
	ld	(hl), #0x00
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
	ldhl	sp,	#8
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
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
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
	ldhl	sp,	#11
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
	ldhl	sp,	#11
	xor	a, (hl)
	ld	d, #0x00
	ld	e, a
	ldhl	sp,	#7
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
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	rrca
	and	a, #0x80
	ldhl	sp,	#4
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#8
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
	ldhl	sp,	#8
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
	ldhl	sp,	#11
	ld	(hl), e
;src/utils.c:24: const unsigned char center = noise(x, y) >> 2; // divide by 4
	ld	a, b
	rrca
	and	a, #0x80
	ldhl	sp,	#4
	xor	a, (hl)
	ld	e, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, e
	ldhl	sp,	#10
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
	ldhl	sp,	#10
	xor	a, (hl)
;src/utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	inc	hl
	ld	e, a
	srl	e
	srl	e
	ld	a, (hl+)
	add	a, (hl)
	add	a, e
;src/utils.c:40: const unsigned char i2 = interpolate(v1, v2);
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
;src/utils.c:59: const unsigned char value = interpolate_noise(x / scale, y / scale);
	ldhl	sp,	#13
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
;src/utils.c:46: if (value < 100)
	cp	a, #0x64
	jr	NC, 00152$
;src/utils.c:47: return 1; // water
	ld	e, #0x01
	jr	00154$
00152$:
;src/utils.c:48: else if (value < 135)
	cp	a, #0x87
	jr	NC, 00150$
;src/utils.c:49: return 0; // grass
	ld	e, #0x00
	jr	00154$
00150$:
;src/utils.c:50: else if (value < 160)
	sub	a, #0xa0
	jr	NC, 00148$
;src/utils.c:51: return 2; // trees
	ld	e, #0x02
	jr	00154$
00148$:
;src/utils.c:53: return 3; // mountains
	ld	e, #0x03
;src/utils.c:60: return closest(value);
00154$:
;src/utils.c:61: }
	add	sp, #14
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
	.db #0x05	; 5
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x7f	; 127
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x40	; 64
	.db #0xc0	; 192
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0xce	; 206
	.db #0x31	; 49	'1'
	.db #0xb1	; 177
	.db #0x4e	; 78	'N'
	.db #0xbf	; 191
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x85	; 133
	.db #0x67	; 103	'g'
	.db #0x9a	; 154
	.db #0x9f	; 159
	.db #0x65	; 101	'e'
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0xdc	; 220
	.db #0xc0	; 192
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x5e	; 94
	.db #0x81	; 129
	.db #0x5e	; 94
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0xc3	; 195
	.db #0x18	; 24
	.db #0x66	; 102	'f'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
;src/utils.c:63: unsigned char generate_item(unsigned char x, unsigned char y) {
;	---------------------------------
; Function generate_item
; ---------------------------------
_generate_item::
;src/utils.c:66: const unsigned char _n = noise(x, y);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	e, a
	ld	c, (hl)
	ld	a, e
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
	xor	a, e
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
	ld	b, c
;src/utils.c:67: if (_n > 49 && _n < 51)
	ld	a, #0x31
	sub	a, c
	jr	NC, 00114$
	ld	a, c
	sub	a, #0x33
	jr	NC, 00114$
;src/utils.c:68: return 1; // map on water
	ld	e, #0x01
	ret
00114$:
;src/utils.c:69: else if (_n > 133 && _n < 135)
	ld	a, #0x85
	sub	a, b
	jr	NC, 00110$
	ld	a, b
	sub	a, #0x87
	jr	NC, 00110$
;src/utils.c:70: return 0; // gun on grass
	ld	e, #0x00
	ret
00110$:
;src/utils.c:71: else if (_n > 158 && _n < 160)
	ld	a, #0x9e
	sub	a, b
	jr	NC, 00106$
	ld	a, b
	sub	a, #0xa0
	jr	NC, 00106$
;src/utils.c:72: return 2; // sword in trees
	ld	e, #0x02
	ret
00106$:
;src/utils.c:73: else if (_n > 190 && _n < 201)
	ld	a, #0xbe
	sub	a, b
	jr	NC, 00102$
	ld	a, b
	sub	a, #0xc9
	jr	NC, 00102$
;src/utils.c:74: return 3; // gold on mountains
	ld	e, #0x03
	ret
00102$:
;src/utils.c:76: return 255; // no item
	ld	e, #0xff
;src/utils.c:77: }
	ret
;src/utils.c:79: bool is_removed(const unsigned char x, const unsigned char y) {
;	---------------------------------
; Function is_removed
; ---------------------------------
_is_removed::
;src/utils.c:81: for (unsigned char i = 0; i < 255; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0xff
	jr	NC, 00104$
;src/utils.c:82: if (used[i][0] == x && used[i][1] == y)
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
;src/utils.c:83: return true;
	ld	e, #0x01
	ret
00107$:
;src/utils.c:81: for (unsigned char i = 0; i < 255; i++)
	inc	c
	jr	00106$
00104$:
;src/utils.c:84: return false;
	ld	e, #0x00
;src/utils.c:85: }
	ret
;src/utils.c:87: void shift_array_right() {
;	---------------------------------
; Function shift_array_right
; ---------------------------------
_shift_array_right::
	add	sp, #-4
;src/utils.c:88: for (unsigned char x = pixel_x - 1; x > 0; x--)
	ld	c, #0x13
00107$:
	ld	a, c
	or	a, a
	jr	Z, 00109$
;src/utils.c:89: for (unsigned char y = 0; y < pixel_y; y++)
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
;src/utils.c:90: map[x][y] = map[x - 1][y];
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
;src/utils.c:89: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;src/utils.c:88: for (unsigned char x = pixel_x - 1; x > 0; x--)
	dec	c
	jr	00107$
00109$:
;src/utils.c:91: }
	add	sp, #4
	ret
;src/utils.c:93: void shift_array_left() {
;	---------------------------------
; Function shift_array_left
; ---------------------------------
_shift_array_left::
	add	sp, #-4
;src/utils.c:94: for (unsigned char x = 0; x < pixel_x - 1; x++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00109$
;src/utils.c:95: for (unsigned char y = 0; y < pixel_y; y++)
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
;src/utils.c:96: map[x][y] = map[x + 1][y];
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
;src/utils.c:95: for (unsigned char y = 0; y < pixel_y; y++)
	inc	b
	jr	00104$
00108$:
;src/utils.c:94: for (unsigned char x = 0; x < pixel_x - 1; x++)
	inc	c
	jr	00107$
00109$:
;src/utils.c:97: }
	add	sp, #4
	ret
;src/utils.c:99: void shift_array_up() {
;	---------------------------------
; Function shift_array_up
; ---------------------------------
_shift_array_up::
;src/utils.c:100: for (unsigned char y = 0; y < pixel_y - 1; y++)
	ld	c, #0x00
00107$:
	ld	a, c
	sub	a, #0x11
	ret	NC
;src/utils.c:101: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;src/utils.c:102: map[x][y] = map[x][y + 1];
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
;src/utils.c:101: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;src/utils.c:100: for (unsigned char y = 0; y < pixel_y - 1; y++)
	inc	c
;src/utils.c:103: }
	jr	00107$
;src/utils.c:105: void shift_array_down() {
;	---------------------------------
; Function shift_array_down
; ---------------------------------
_shift_array_down::
;src/utils.c:106: for (unsigned char y = pixel_y - 1; y > 0; y--)
	ld	c, #0x11
00107$:
	ld	a, c
	or	a, a
	ret	Z
;src/utils.c:107: for (unsigned char x = 0; x < pixel_x; x++)
	ld	b, #0x00
00104$:
	ld	a, b
	sub	a, #0x14
	jr	NC, 00108$
;src/utils.c:108: map[x][y] = map[x][y - 1];
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
;src/utils.c:107: for (unsigned char x = 0; x < pixel_x; x++)
	inc	b
	jr	00104$
00108$:
;src/utils.c:106: for (unsigned char y = pixel_y - 1; y > 0; y--)
	dec	c
;src/utils.c:109: }
	jr	00107$
;src/utils.c:111: void generate_side(const char side) {
;	---------------------------------
; Function generate_side
; ---------------------------------
_generate_side::
	add	sp, #-6
;src/utils.c:115: switch (side) {
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x62
	jp	Z,00159$
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x6c
	jp	Z,00153$
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x72
	jr	Z, 00150$
	ldhl	sp,	#8
	ld	a, (hl)
	sub	a, #0x74
	jp	Z,00156$
	jp	00122$
;src/utils.c:117: for (unsigned char y = 0; y < pixel_y; y++) {
00150$:
	ldhl	sp,	#5
	ld	(hl), #0x00
00111$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00122$
;src/utils.c:118: _x = pixel_x - 1 + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0x09
	ldhl	sp,	#0
	ld	(hl), a
;src/utils.c:119: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,	#5
	add	a, (hl)
	add	a, #0xf7
	ld	c, a
;src/utils.c:120: const unsigned char _t = terrain(_x, _y);
	push	bc
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	call	_terrain
	pop	hl
	pop	bc
	ldhl	sp,	#1
;src/utils.c:121: const unsigned char _i = generate_item(_x, _y);
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, c
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_generate_item
	pop	hl
	pop	bc
	ldhl	sp,	#2
	ld	(hl), e
;src/utils.c:122: map[pixel_x - 1][y] =
	ld	de, #(_map + 342)
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
;src/utils.c:123: (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
	ldhl	sp,	#1
	ld	a, (hl+)
	sub	a, (hl)
	jr	NZ, 00124$
	ld	a, c
	push	af
	inc	sp
	ldhl	sp,	#1
	ld	a, (hl)
	push	af
	inc	sp
	call	_is_removed
	pop	hl
	ld	a, e
	or	a, a
	jr	NZ, 00124$
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x04
	ld	c, a
	jr	00125$
00124$:
	ldhl	sp,	#1
	ld	c, (hl)
00125$:
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/utils.c:117: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#5
	inc	(hl)
	jr	00111$
;src/utils.c:127: for (unsigned char y = 0; y < pixel_y; y++) {
00153$:
	ldhl	sp,	#5
	ld	(hl), #0x00
00114$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x12
	jp	NC, 00122$
;src/utils.c:128: _x = p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, #0xf6
	ld	b, a
;src/utils.c:129: _y = y + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	add	a, (hl)
	add	a, #0xf7
	ld	c, a
;src/utils.c:130: const unsigned char _t = terrain(_x, _y);
	push	bc
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_terrain
	pop	hl
	pop	bc
	ldhl	sp,	#2
	ld	(hl), e
;src/utils.c:131: const unsigned char _i = generate_item(_x, _y);
	push	bc
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_generate_item
	pop	hl
	pop	bc
;src/utils.c:132: map[0][y] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
	push	de
	ld	de, #_map
	ldhl	sp,	#7
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00129$
	push	de
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	or	a, a
	jr	NZ, 00129$
	ld	a, e
	add	a, #0x04
	ld	c, a
	jr	00130$
00129$:
	ldhl	sp,	#2
	ld	c, (hl)
00130$:
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/utils.c:127: for (unsigned char y = 0; y < pixel_y; y++) {
	ldhl	sp,	#5
	inc	(hl)
	jr	00114$
;src/utils.c:136: for (unsigned char x = 0; x < pixel_x; x++) {
00156$:
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x14
	jp	NC, 00122$
;src/utils.c:137: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, c
	add	a, #0xf6
	ld	b, a
;src/utils.c:138: _y = p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	add	a, #0xf7
	ldhl	sp,	#1
	ld	(hl), a
;src/utils.c:139: const unsigned char _t = terrain(_x, _y);
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_terrain
	pop	hl
	pop	bc
	ldhl	sp,	#2
;src/utils.c:140: const unsigned char _i = generate_item(_x, _y);
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_generate_item
	pop	hl
	pop	bc
	ldhl	sp,	#3
	ld	(hl), e
;src/utils.c:141: map[x][0] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	de, #_map
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#3
	ld	a, (hl-)
	sub	a, (hl)
	jr	NZ, 00134$
	push	bc
	push	de
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00134$
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x04
	jr	00135$
00134$:
	ldhl	sp,	#2
	ld	a, (hl)
00135$:
	ld	(de), a
;src/utils.c:136: for (unsigned char x = 0; x < pixel_x; x++) {
	inc	c
	jr	00117$
;src/utils.c:145: for (unsigned char x = 0; x < pixel_x; x++) {
00159$:
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00122$
;src/utils.c:146: _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	add	a, c
	add	a, #0xf6
	ld	b, a
;src/utils.c:147: _y = pixel_y - 1 + p.y[0] - gen_y;
	ld	a, (#(_p + 2) + 0)
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
;src/utils.c:148: const unsigned char _t = terrain(_x, _y);
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_terrain
	pop	hl
	pop	bc
	ldhl	sp,	#2
;src/utils.c:149: const unsigned char _i = generate_item(_x, _y);
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_generate_item
	pop	hl
	pop	bc
	ldhl	sp,	#3
	ld	(hl), e
;src/utils.c:150: map[x][pixel_y - 1] =
	ld	e, c
	ld	d, #0x00
	ld	l, e
	ld	h, d
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	de, #_map
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
;src/utils.c:151: (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, (hl)
	jr	NZ, 00139$
	push	bc
	push	de
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_is_removed
	pop	hl
	ld	a, e
	pop	de
	pop	bc
	or	a, a
	jr	NZ, 00139$
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x04
	jr	00140$
00139$:
	ldhl	sp,	#2
	ld	a, (hl)
00140$:
	ld	(de), a
;src/utils.c:145: for (unsigned char x = 0; x < pixel_x; x++) {
	inc	c
	jr	00120$
;src/utils.c:154: }
00122$:
;src/utils.c:155: }
	add	sp, #6
	ret
;src/utils.c:157: void generate_map() {
;	---------------------------------
; Function generate_map
; ---------------------------------
_generate_map::
	add	sp, #-6
;src/utils.c:159: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#5
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x14
	jr	NC, 00109$
;src/utils.c:160: for (unsigned char y = 0; y < pixel_y; y++) {
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #_map
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x12
	jr	NC, 00108$
;src/utils.c:161: const unsigned char _x = x + p.x[0] - gen_x;
	ld	a, (#_p + 0)
	ldhl	sp,	#5
	add	a, (hl)
	add	a, #0xf6
	ldhl	sp,	#2
;src/utils.c:162: const unsigned char _y = y + p.y[0] - gen_y;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, c
	add	a, #0xf7
	ld	(hl), a
;src/utils.c:163: const unsigned char _t = terrain(_x, _y);
	push	bc
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_terrain
	pop	hl
	pop	bc
	ldhl	sp,	#4
;src/utils.c:164: const unsigned char _i = generate_item(_x, _y);
	ld	a, e
	ld	(hl-), a
	push	bc
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_generate_item
	pop	hl
	pop	bc
	ld	b, e
;src/utils.c:165: map[x][y] = (_i == _t && !is_removed(_x, _y)) ? _i + backgrounds : _t;
	pop	de
	push	de
	ld	l, c
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, b
	jr	NZ, 00111$
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
	jr	NZ, 00111$
	ld	a, b
	add	a, #0x04
	jr	00112$
00111$:
	ldhl	sp,	#4
	ld	a, (hl)
00112$:
	ld	(de), a
;src/utils.c:160: for (unsigned char y = 0; y < pixel_y; y++) {
	inc	c
	jr	00104$
00108$:
;src/utils.c:159: for (unsigned char x = 0; x < pixel_x; x++)
	ldhl	sp,	#5
	inc	(hl)
	jr	00107$
00109$:
;src/utils.c:167: }
	add	sp, #6
	ret
;src/utils.c:169: void generate_map_side() {
;	---------------------------------
; Function generate_map_side
; ---------------------------------
_generate_map_side::
;src/utils.c:170: const char diff_x = p.x[1] - p.x[0];
	ld	hl, #_p
	ld	c, (hl)
	ld	a, (#(_p + 1) + 0)
	sub	a, c
	ld	c, a
;src/utils.c:171: const char diff_y = p.y[1] - p.y[0];
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	a, (#(_p + 3) + 0)
	sub	a, b
	ld	b, a
;src/utils.c:172: if (diff_x < 0) {
	bit	7, c
	jr	Z, 00104$
;src/utils.c:174: shift_array_left();
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
;src/utils.c:176: } else if (diff_x > 0) {
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
;src/utils.c:178: shift_array_right();
	push	bc
	call	_shift_array_right
	ld	a, #0x6c
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	pop	bc
00105$:
;src/utils.c:181: if (diff_y > 0) {
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
;src/utils.c:183: shift_array_down();
	call	_shift_array_down
;src/utils.c:184: generate_side('t');
	ld	a, #0x74
	push	af
	inc	sp
	call	_generate_side
	inc	sp
	jr	00110$
00109$:
;src/utils.c:185: } else if (diff_y < 0) {
	bit	7, b
	jr	Z, 00110$
;src/utils.c:187: shift_array_up();
	call	_shift_array_up
;src/utils.c:188: generate_side('b');
	ld	a, #0x62
	push	af
	inc	sp
	call	_generate_side
	inc	sp
00110$:
;src/utils.c:191: p.x[1] = p.x[0];
	ld	a, (#_p + 0)
	ld	(#(_p + 1)),a
;src/utils.c:192: p.y[1] = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ld	(#(_p + 3)),a
;src/utils.c:193: }
	ret
;src/utils.c:195: void display_map() {
;	---------------------------------
; Function display_map
; ---------------------------------
_display_map::
;src/utils.c:196: for (unsigned char i = 0; i < pixel_x; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;src/utils.c:197: set_bkg_tiles(i, 0, 1, pixel_y, map[i]);
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
;src/utils.c:196: for (unsigned char i = 0; i < pixel_x; i++)
	inc	c
	jr	00103$
00101$:
;src/utils.c:198: SHOW_SPRITES; // menu is closed
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/utils.c:199: }
	ret
;src/utils.c:201: void show_menu() {
;	---------------------------------
; Function show_menu
; ---------------------------------
_show_menu::
	add	sp, #-4
;src/utils.c:203: display_map();
	call	_display_map
;src/utils.c:204: HIDE_SPRITES; // menu is open
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/utils.c:205: const unsigned char x = p.x[0] - start_position;
	ld	a, (#_p + 0)
	add	a, #0x81
	ldhl	sp,	#2
;src/utils.c:206: const unsigned char y = p.y[0] - start_position;
	ld	(hl+), a
	ld	a, (#(_p + 2) + 0)
	add	a, #0x81
	ld	(hl), a
;src/utils.c:207: printf("\n\tgold:\t%u", p.gold);
	ld	a, (#(_p + 10) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;src/utils.c:208: printf("\n\tmaps:\t%u", p.maps);
	ld	a, (#(_p + 11) + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;src/utils.c:209: printf("\n\tweapons:\t%d\t%d", p.weapons[0], p.weapons[1]);
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
;src/utils.c:211: printf("\n\n\tposition:\t(%u, %u)", x, y);
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
;src/utils.c:212: printf("\n\tsteps:\t%u", p.steps);
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
;src/utils.c:213: printf("\n\tseed:\t%u", SEED);
	ld	de, #0x0039
	push	de
	ld	de, #___str_5
	push	de
	call	_printf
	add	sp, #4
;src/utils.c:215: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	hl, #(_p + 2)
	ld	b, (hl)
	ld	hl, #_p
	ld	c, (hl)
;src/utils.c:9: x ^= (y << 7);
	ld	a, b
	rrca
	and	a, #0x80
	xor	a, c
;src/utils.c:10: x ^= (x >> 5);
	ld	c, a
	swap	a
	rrca
	and	a, #0x07
	xor	a, c
;src/utils.c:11: y ^= (x << 3);
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	xor	a, b
;src/utils.c:12: y ^= (y >> 1);
	ld	b, a
	srl	a
	xor	a, b
;src/utils.c:13: return x ^ y * SEED;
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
;src/utils.c:215: printf("\n\n\trandom:\t%u", noise(p.x[0], p.y[0]));
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_6
	push	de
	call	_printf
;src/utils.c:216: }
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
;src/utils.c:218: void remove_item(const unsigned char x, unsigned char y) {
;	---------------------------------
; Function remove_item
; ---------------------------------
_remove_item::
;src/utils.c:220: used[used_index][0] = x;
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
;src/utils.c:221: used[used_index][1] = y;
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
;src/utils.c:222: used_index++;
	ld	hl, #_used_index
	inc	(hl)
;src/utils.c:223: }
	ret
;src/utils.c:225: void add_inventory(unsigned char item) {
;	---------------------------------
; Function add_inventory
; ---------------------------------
_add_inventory::
;src/utils.c:227: item -= backgrounds;
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0xfc
;src/utils.c:228: switch (item) {
	ld	(hl), a
	or	a, a
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	Z, 00106$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00102$
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	Z, 00107$
	ret
;src/utils.c:230: case 2:
00102$:
;src/utils.c:231: if (p.weapons[0] == -1) {
	ld	bc, #_p + 8
	ld	a, (bc)
	inc	a
	jr	NZ, 00104$
;src/utils.c:232: p.weapons[0] = item;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(bc), a
	ret
00104$:
;src/utils.c:234: p.weapons[1] = item;
	ld	de, #(_p + 9)
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(de), a
;src/utils.c:236: break;
	ret
;src/utils.c:237: case 1:
00106$:
;src/utils.c:238: p.maps++;
	ld	bc, #_p+11
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/utils.c:239: break;
	ret
;src/utils.c:240: case 3:
00107$:
;src/utils.c:241: p.gold++;
	ld	bc, #_p+10
	ld	a, (bc)
	inc	a
	ld	(bc), a
;src/utils.c:242: }
;src/utils.c:243: }
	ret
;src/utils.c:245: void change_item() {
;	---------------------------------
; Function change_item
; ---------------------------------
_change_item::
;src/utils.c:246: const char _w = p.weapons[0];
	ld	hl, #_p + 8
	ld	c, (hl)
;src/utils.c:247: p.weapons[0] = p.weapons[1];
	ld	de, #_p + 9
	ld	a, (de)
	ld	(hl), a
;src/utils.c:248: p.weapons[1] = _w;
	ld	a, c
	ld	(de), a
;src/utils.c:249: }
	ret
;src/utils.c:251: void interact() {
;	---------------------------------
; Function interact
; ---------------------------------
_interact::
	add	sp, #-6
;src/utils.c:256: for (char x = -2; x <= 0; x++)
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
;src/utils.c:257: for (char y = -3; y <= -1; y++) {
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
;src/utils.c:259: const unsigned char pos_y = y + center_y / sprite_size;
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, #0x09
;src/utils.c:260: const unsigned char item = map[pos_x][pos_y];
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
;src/utils.c:261: if (item >= backgrounds) {
	ld	(hl), a
	sub	a, #0x04
	jr	C, 00107$
;src/utils.c:262: add_inventory(item);
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	call	_add_inventory
	inc	sp
	pop	bc
;src/utils.c:263: remove_item(x + p.x[0], y + p.y[0]);
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
;src/utils.c:265: map[pos_x][pos_y] = item - backgrounds;
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0xfc
	pop	hl
	push	hl
	ld	(hl), a
;src/utils.c:266: display_map();
	push	bc
	call	_display_map
	pop	bc
00107$:
;src/utils.c:257: for (char y = -3; y <= -1; y++) {
	ldhl	sp,	#5
	inc	(hl)
	jr	00106$
00110$:
;src/utils.c:256: for (char x = -2; x <= 0; x++)
	ldhl	sp,	#4
	inc	(hl)
	jp	00109$
00111$:
;src/utils.c:269: }
	add	sp, #6
	ret
;src/utils.c:271: void attack() {
;	---------------------------------
; Function attack
; ---------------------------------
_attack::
;src/utils.c:272: switch (p.weapons[0]) {
	ld	a, (#(_p + 8) + 0)
	or	a, a
	jr	Z, 00101$
	sub	a, #0x02
	jr	Z, 00102$
	ret
;src/utils.c:273: case 0:
00101$:
;src/utils.c:274: printf("\nbang!\n");
	ld	de, #___str_8
	push	de
	call	_puts
	pop	hl
;src/utils.c:275: break;
	ret
;src/utils.c:276: case 2:
00102$:
;src/utils.c:277: printf("\nclink!\n");
	ld	de, #___str_10
	push	de
	call	_puts
	pop	hl
;src/utils.c:279: }
;src/utils.c:280: }
	ret
___str_8:
	.db 0x0a
	.ascii "bang!"
	.db 0x00
___str_10:
	.db 0x0a
	.ascii "clink!"
	.db 0x00
;src/utils.c:282: void update_position(unsigned char j) {
;	---------------------------------
; Function update_position
; ---------------------------------
_update_position::
	add	sp, #-8
;src/utils.c:283: bool update = false;
	ldhl	sp,	#4
	ld	(hl), #0x00
;src/utils.c:284: unsigned char _x = p.x[0];
	ld	a, (#_p + 0)
	ldhl	sp,	#6
	ld	(hl), a
;src/utils.c:285: unsigned char _y = p.y[0];
	ld	a, (#(_p + 2) + 0)
	ldhl	sp,#5
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/utils.c:286: if (j & J_RIGHT)
	ldhl	sp,	#10
	ld	c, (hl)
	bit	0, c
	jr	Z, 00104$
;src/utils.c:287: _x++;
	ldhl	sp,	#6
	inc	(hl)
	jr	00105$
00104$:
;src/utils.c:288: else if (j & J_LEFT)
	bit	1, c
	jr	Z, 00105$
;src/utils.c:289: _x--;
	ldhl	sp,	#6
	dec	(hl)
00105$:
;src/utils.c:290: if (j & J_UP)
	bit	2, c
	jr	Z, 00109$
;src/utils.c:291: _y--;
	ldhl	sp,	#7
	dec	(hl)
	jr	00110$
00109$:
;src/utils.c:292: else if (j & J_DOWN)
	bit	3, c
	jr	Z, 00110$
;src/utils.c:293: _y++;
	ldhl	sp,	#7
	inc	(hl)
00110$:
;src/utils.c:294: if (_x != p.x[0]) {
	ld	hl, #_p
	ld	c, (hl)
;src/utils.c:297: p.steps++;
;src/utils.c:294: if (_x != p.x[0]) {
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, c
	jr	Z, 00114$
;src/utils.c:295: p.x[1] = p.x[0];
	ld	hl, #(_p + 1)
	ld	(hl), c
;src/utils.c:296: p.x[0] = _x;
	ld	de, #_p
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(de), a
;src/utils.c:297: p.steps++;
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
;src/utils.c:298: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
	jr	00115$
00114$:
;src/utils.c:299: } else if (_y != p.y[0]) {
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	Z, 00115$
;src/utils.c:302: p.y[1] = p.y[0];
	ld	de, #(_p + 3)
	ldhl	sp,	#5
;src/utils.c:303: p.y[0] = _y;
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	de, #(_p + 2)
	ld	a, (hl)
	ld	(de), a
;src/utils.c:304: p.steps++;
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
;src/utils.c:305: update = true;
	ldhl	sp,	#4
	ld	(hl), #0x01
00115$:
;src/utils.c:307: if (update) {
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
;src/utils.c:308: generate_map_side();
	call	_generate_map_side
;src/utils.c:309: display_map();
	call	_display_map
00118$:
;src/utils.c:311: }
	add	sp, #8
	ret
;src/main.c:15: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:16: init();
	call	_init
;src/main.c:18: while (1) {
00102$:
;src/main.c:19: check_input();     // Check for user input
	call	_check_input
;src/main.c:20: update_switches(); // Make sure the SHOW_SPRITES and SHOW_BKG switches are
	call	_update_switches
;src/main.c:22: wait_vbl_done();   // Wait until VBLANK to avoid corrupting memory
	call	_wait_vbl_done
;src/main.c:24: }
	jr	00102$
;src/main.c:26: void init() {
;	---------------------------------
; Function init
; ---------------------------------
_init::
;src/main.c:27: DISPLAY_ON; // Turn on the display
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/main.c:29: font_init();                   // Initialize font
	call	_font_init
;src/main.c:30: font_set(font_load(font_ibm)); // Set and load the font
	ld	de, #_font_ibm
	push	de
	call	_font_load
	pop	hl
	push	de
	call	_font_set
	pop	hl
;src/main.c:34: gb_decompress_bkg_data(0, landscape);
	ld	de, #_landscape
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_gb_decompress_bkg_data
	add	sp, #3
;src/main.c:35: gb_decompress_sprite_data(0, player_sprite);
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
;src/main.c:45: p.x[0] = p.x[1] = p.y[0] = p.y[1] = start_position;
	ld	hl, #(_p + 3)
	ld	(hl), #0x7f
	ld	hl, #(_p + 2)
	ld	(hl), #0x7f
	ld	hl, #(_p + 1)
	ld	(hl), #0x7f
	ld	hl, #_p
	ld	(hl), #0x7f
;src/main.c:48: p.steps = p.gold = p.maps = 0;
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
;src/main.c:49: p.weapons[0] = p.weapons[1] = -1;
	ld	hl, #(_p + 9)
	ld	(hl), #0xff
	ld	hl, #(_p + 8)
	ld	(hl), #0xff
;src/main.c:52: printf("\n\tWelcome to\n\tPirate`s Folly"); // Use ` since ' is replaced
	ld	de, #___str_11
	push	de
	call	_printf
	pop	hl
;src/main.c:56: generate_map();
	call	_generate_map
;src/main.c:59: display_map();
;src/main.c:60: }
	jp	_display_map
___str_11:
	.db 0x0a
	.db 0x09
	.ascii "Welcome to"
	.db 0x0a
	.db 0x09
	.ascii "Pirate`s Folly"
	.db 0x00
;src/main.c:62: inline void update_switches() {
;	---------------------------------
; Function update_switches
; ---------------------------------
_update_switches::
;src/main.c:63: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/main.c:64: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:65: }
	ret
;src/main.c:67: inline void check_input() {
;	---------------------------------
; Function check_input
; ---------------------------------
_check_input::
;src/main.c:68: const unsigned char j = joypad();
	call	_joypad
	ld	b, e
;src/main.c:69: if (j & J_START)
	bit	7, b
	jr	Z, 00102$
;src/main.c:70: show_menu();
	push	bc
	call	_show_menu
	pop	bc
00102$:
;src/main.c:71: if (j & J_SELECT)
	bit	6, b
	jr	Z, 00104$
;src/main.c:72: change_item();
	push	bc
	call	_change_item
	pop	bc
00104$:
;src/main.c:73: if (j & J_A)
	bit	4, b
	jr	Z, 00106$
;src/main.c:74: interact();
	push	bc
	call	_interact
	pop	bc
00106$:
;src/main.c:75: if (j & J_B)
	bit	5, b
	jr	Z, 00108$
;src/main.c:76: attack();
	push	bc
	call	_attack
	pop	bc
00108$:
;src/main.c:77: if (j)
	ld	a, b
	or	a, a
	ret	Z
;src/main.c:78: update_position(j);
	push	bc
	inc	sp
	call	_update_position
	inc	sp
;src/main.c:79: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__used_index:
	.db #0x00	; 0
	.area _CABS (ABS)
