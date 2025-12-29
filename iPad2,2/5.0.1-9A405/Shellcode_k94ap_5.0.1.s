.text

.pool

.set BASEADDR, 0x9FFB80C0
.set IRQ_VECTOR, 0x9FF00038

.set real_arm_irq, 0x9FF1B34C
.set printf, 0x9FF2E9A1
.set prepare_and_jump, 0x9FF1977D

.set JUMPING_INTO_IMAGE, 0x9FF2FAB9

.set JUMPADDR, 0xA0000000

.global _start

_start:
.code 16

    PUSH {R0-R7, LR}

    LDR R4, =real_arm_irq
    BLX R4

.code 32

    BLX end


end:
.code 16

    NOP

    LDR R0, =IRQ_VECTOR
    LDR R1, =real_arm_irq
    STR R1, [R0]

    LDR R0, =HELLO+BASEADDR
    LDR R4, =printf
    BLX R4

    LDR R0, =JUMPING_INTO_IMAGE
    LDR R1, =JUMPADDR
    LDR R4, =printf
    BLX R4

    MOVS R0, #0x0
    LDR R1, =JUMPADDR
    MOV R2, R0
    LDR R4, =prepare_and_jump
    BLX R4

    LDR R0, =SHOULDNT_BE_HERE+BASEADDR
    LDR R4, =printf
    BLX R4

    POP {R0-R7, PC}


HELLO:
.ascii "Hello darkness, my old friend\n\x00"

SHOULDNT_BE_HERE:
.ascii "Shouldn't be here...\n\x00"
