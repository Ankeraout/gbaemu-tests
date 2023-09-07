.include "tests/arm.inc"

.text
.balign 4

.code 32

.global main

main:
    push {lr}

    bl test_arm

    ldr r0, =0x7E57600D
    mov r1, #0
    
    pop {pc}
