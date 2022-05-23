; PRNG comes from a combination of Perlin noise
; and 8-bit xorshift.
; inspired by Hugo Elias and George Marsaglia.

_prng::
; x ^= (y << 7);
    ldhl	sp,	#3
    ld	a, (hl-)
    rrca
    and	a, #0x80
    xor	a, (hl)
; x ^= (x >> 5);
    ld	(hl), a
    swap	a
    rrca
    and	a, #0x07
    xor	a, (hl)
; y ^= (x << 3);
    ld	(hl+), a
    add	a, a
    add	a, a
    add	a, a
    xor	a, (hl)
; y ^= (y >> 1);
    ld	(hl), a
    srl	a
    xor	a, (hl)
; return x ^ y * SEED; // SEED = 57
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
; return
    ret