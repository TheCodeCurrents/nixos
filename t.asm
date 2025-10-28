.data
        feld_a: .word 0, 1, 1, 3, 5, 6, 7, 2
        feld_b: .word 9, 4, 4, 1, 8, 7, 0, 9
.text
        la a0, feld_a         # a0 <- Basisadresse von feld_a
        la a1, feld_b         # a1 <- Basisadresse von feld_b
        li a2, 8              # a2 <- Laenge von feld_a
        li a3, 8              # a3 <- Lange von feld_b
        slli a2, a2, 2        # a2 <- a2 << 2
        slli a3, a3, 2        # a3 <- a3 << 2

        add s0, zero, zero
        add t0, zero, zero
outer:  add t4, a0, t0
        lw t4, 0(t4)
        add t1, zero, zero
inner:  add t3, a1, t1
        lw t3, 0(t3)
        bne t3, t4, skip
        addi s0, s0, 1
skip:   addi t1, t1, 4
        bne t1, a3, inner
        addi t0, t0, 4
        bne t0, a2, outer