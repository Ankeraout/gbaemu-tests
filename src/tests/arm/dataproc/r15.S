.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_r15
test_arm_dataproc_r15:
    push {lr}

    bl test_arm_dataproc_r15_0
    bl test_arm_dataproc_r15_1
    bl test_arm_dataproc_r15_2
    bl test_arm_dataproc_r15_3

    pop {pc}

@ MOV to R15 jumps, CPSR unaffected
test_arm_dataproc_r15_0:
    ldr r0, =#0x00140000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =test_arm_dataproc_r15_0.success
    mov r15, r0

    b testFailed

test_arm_dataproc_r15_0.success:
    mrs r2, cpsr
    tst r2, #0xf0000000
    bne testFailed

    bx r14

@ MOVS to R15 jumps, CPSR = SPSR
test_arm_dataproc_r15_1:
    ldr r0, =#0x00140001
    ldr r1, =g_currentTest
    str r0, [r1]

    @ Set current mode to FIQ
    mov r0, #0x00000011
    msr cpsr, r0

    @ Set SPSR to a CPSR with system mode
    mov r0, #0x0000001f
    msr spsr, r0

    @ Jump
    adr r0, test_arm_dataproc_r15_1.success
    movs r15, r0

    @ If no jump, test failed.
    b testFailed

test_arm_dataproc_r15_1.success:
    @ Make sure that the current mode is System mode
    mrs r0, cpsr
    teq r0, #0x0000001f
    bne testFailed

    bx r14

@ R15 as operand, shift amount immediate => R15 is 8 bytes ahead
test_arm_dataproc_r15_2:
    ldr r0, =#0x00140002
    ldr r1, =g_currentTest
    str r0, [r1]

    mov r0, r15
    ldr r1, =test_arm_dataproc_r15_2.target

test_arm_dataproc_r15_2.target:
    teq r0, r1
    bne testFailed

    bx r14

@ R15 as operand, shift amount in register => R15 is 12 bytes ahead
test_arm_dataproc_r15_3:
    ldr r0, =#0x00140003
    ldr r1, =g_currentTest
    str r0, [r1]

    mov r0, #0
    mov r0, r15, lsl r0
    ldr r1, =test_arm_dataproc_r15_3.target
    nop

test_arm_dataproc_r15_3.target:
    teq r0, r1
    bne testFailed

    bx r14
