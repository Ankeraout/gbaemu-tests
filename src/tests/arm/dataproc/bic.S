.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_bic
test_arm_dataproc_bic:
    push {lr}

    bl test_arm_dataproc_bic_0
    bl test_arm_dataproc_bic_1
    bl test_arm_dataproc_bic_2
    bl test_arm_dataproc_bic_3
    bl test_arm_dataproc_bic_4

    pop {pc}

@ BICS 0, 0 => 0 (flags = Z)
test_arm_dataproc_bic_0:
    ldr r0, =#0x000e0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    bics r1, r0, #0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ BICS 0, 1 => 0 (flags = Z)
test_arm_dataproc_bic_1:
    ldr r0, =#0x000e0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    bics r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ BICS 1, 0 => 1 (flags = none)
test_arm_dataproc_bic_2:
    ldr r0, =#0x000e0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    bics r1, r0, #0
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ BICS 1, 1 => 0 (flags = Z)
test_arm_dataproc_bic_3:
    ldr r0, =#0x000e0003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    bics r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ BICS 0x80000000, 0 => 0x80000000 (flags = N)
test_arm_dataproc_bic_4:
    ldr r0, =#0x000e0004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    bics r1, r0, #0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14
