.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_teq
test_arm_dataproc_teq:
    push {lr}

    bl test_arm_dataproc_teq_0
    bl test_arm_dataproc_teq_1
    bl test_arm_dataproc_teq_2
    bl test_arm_dataproc_teq_3
    bl test_arm_dataproc_teq_4
    bl test_arm_dataproc_teq_5

    pop {pc}

@ TEQ 0, 0 => (flags = Z)
test_arm_dataproc_teq_0:
    ldr r0, =#0x00090000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    teq r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    cmp r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ TEQ 0, 1 => (flags = none)
test_arm_dataproc_teq_1:
    ldr r0, =#0x00090001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    teq r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    cmp r2, #0
    bne testFailed

    bx r14

@ TEQ 1, 0 => (flags = none)
test_arm_dataproc_teq_2:
    ldr r0, =#0x00090002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    teq r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    cmp r2, #0
    bne testFailed

    bx r14

@ TEQ 1, 1 => (flags = Z)
test_arm_dataproc_teq_3:
    ldr r0, =#0x00090003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    teq r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    cmp r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ TEQ 0, 0x80000000 => (flags = N)
test_arm_dataproc_teq_4:
    ldr r0, =#0x00090004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    mov r1, #0x80000000
    teq r0, r1
    mrs r2, cpsr

    and r2, #0xf0000000
    cmp r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ TEQ 0xaaaaaaaa, 0x55555555 => (flags = N) (Rd not written)
test_arm_dataproc_teq_5:
    ldr r0, =#0x00090005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =0xaaaaaaaa
    ldr r1, =0x55555555
    teq r0, r1 @ Rd = 0 in the instruction encoding
    mrs r2, cpsr

    cmp r0, r1, lsl #1
    bne testFailed

    and r2, #0xf0000000
    cmp r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14
