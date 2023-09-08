.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_tst
test_arm_dataproc_tst:
    push {lr}

    bl test_arm_dataproc_tst_0
    bl test_arm_dataproc_tst_1
    bl test_arm_dataproc_tst_2
    bl test_arm_dataproc_tst_3
    bl test_arm_dataproc_tst_4
    bl test_arm_dataproc_tst_5

    pop {pc}

@ TST 0, 0 => (flags = Z)
test_arm_dataproc_tst_0:
    ldr r0, =#0x00080000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    tst r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ TST 1, 0 => (flags = Z)
test_arm_dataproc_tst_1:
    ldr r0, =#0x00080001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    tst r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ TST 1, 1 => (flags = none)
test_arm_dataproc_tst_2:
    ldr r0, =#0x00080002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    tst r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ TST 0x80000000, 0x80000000 => (flags = N)
test_arm_dataproc_tst_3:
    ldr r0, =#0x00080003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    tst r0, r0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ TST 0xaaaaaaaa, 0x55555555 => (flags = Z) (TST does not write to registers)
test_arm_dataproc_tst_4:
    ldr r0, =#0x00080004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =0xaaaaaaaa
    ldr r1, =0x55555555
    tst r0, r1 @ Rd = 0 in the instruction encoding
    mrs r2, cpsr

    teq r1, r0, lsr #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ TST 0, 1 => (flags = Z)
test_arm_dataproc_tst_5:
    ldr r0, =#0x00080005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    tst r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14
