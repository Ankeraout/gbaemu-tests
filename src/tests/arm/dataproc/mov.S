.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_mov
test_arm_dataproc_mov:
    push {lr}

    bl test_arm_dataproc_mov_0
    bl test_arm_dataproc_mov_1
    bl test_arm_dataproc_mov_2
    
    pop {pc}

@ MOVS 0 (flags = Z)
test_arm_dataproc_mov_0:
    ldr r0, =#0x000d0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    movs r1, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ MOVS 1 (flags = none)
test_arm_dataproc_mov_1:
    ldr r0, =#0x000d0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    movs r1, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ MOVS 0x80000000 (flags = N)
test_arm_dataproc_mov_2:
    ldr r0, =#0x000d0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    movs r1, r0
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14
