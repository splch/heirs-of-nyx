; PRNG comes from a combination of Perlin noise
; and 8-bit xorshift.
; inspired by Hugo Elias and Michael Martin.

    .area _CODE ; not necessary but safer

    ; operation operand ; cycle count

_prng::

; x ^= (y << 7);

    ldhl sp, #3        ; 3 cycles: sp = sp + 3; hl = sp
    ld a, (hl-)        ; 2 cycles: a = hl; hl = hl - 1
    rrca               ; 1 cycle: a = a >> 1
    xor a, #0b10101010 ; 2 cycles: a = a & 113
    xor a, (hl)        ; 2 cycles: a = a ^ hl

; x ^= (x >> 5);

    ld (hl), a         ; 2 cycles: hl = a
    swap a             ; 2 cycles: 
    rrca               ; 1 cycle: a = a >> 1
    and a, #0x07       ; 2 cycles: a = a & 7
    xor a, (hl)        ; 2 cycles: a = a ^ hl

; y ^= (x << 3);

    ld (hl+), a        ; 2 cycles: hl = a; hl = hl + 1
    add a, a           ; 1 cycle: a = a + a
    add a, a           ; 1 cycle: a = a + a
    add a, a           ; 1 cycle: a = a + a
    xor a, (hl)        ; 2 cycles: a = a ^ hl

; y ^= (y >> 1);

    ld (hl), a         ; 2 cycles: hl = a
    srl a              ; 2 cycles: a = a >> 1
    xor a, (hl)        ; 2 cycles: a = a ^ hl

; return x ^ y * SEED;

    ld (hl), a         ; 2 cycles: hl = a
    ld c, a            ; 1 cycle: c = a
    add a, a           ; 1 cycle: a = a + a
    add a, c           ; 1 cycle: a = a + c
    add a, a           ; 1 cycle: a = a + a
    add a, c           ; 1 cycle: a = a + c
    add a, a           ; 1 cycle: a = a + a
    add a, c           ; 1 cycle: a = a + c
    ldhl sp, #2        ; 3 cycles: sp = sp + 2; hl = sp
    ld c, (hl)         ; 2 cycles: c = hl
    xor a, c           ; 1 cycle: a = a ^ c
    ld e, a            ; 1 cycle: e = a

; return

    ret                ; 4 cycles: return e
