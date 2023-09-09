.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_lsl
test_arm_dataproc_lsl:
    push {lr}

    bl test_arm_dataproc_lsl_0
    bl test_arm_dataproc_lsl_1
    bl test_arm_dataproc_lsl_2
    bl test_arm_dataproc_lsl_3
    bl test_arm_dataproc_lsl_4
    bl test_arm_dataproc_lsl_5
    bl test_arm_dataproc_lsl_6
    bl test_arm_dataproc_lsl_7
    bl test_arm_dataproc_lsl_8

    pop {pc}

@ LSLS 0x01234567, 0 => 0x01234567 (Flags: none) (C flag unchanged)
test_arm_dataproc_lsl_0:
    ldr r0, =#0x00100000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =0x01234567
    movs r1, r0, lsl #0
    mrs r2, cpsr

    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ LSLS (C) 0x01234567, 0 => 0x01234567 (Flags: C) (C flag unchanged)
test_arm_dataproc_lsl_1:
    ldr r0, =#0x00100001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    ldr r0, =0x01234567
    movs r1, r0, lsl #0
    mrs r2, cpsr

    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ LSLS 1, 1 => 2 (Flags: none)
test_arm_dataproc_lsl_2:
    ldr r0, =#0x00100002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    movs r1, r0, lsl #1
    mrs r2, cpsr

    teq r1, #2
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ LSLS (C) 1, 1 => 2 (Flags: none)
test_arm_dataproc_lsl_3:
    ldr r0, =#0x00100003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    mov r0, #1
    movs r1, r0, lsl #1
    mrs r2, cpsr

    teq r1, #2
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ LSLS 0x80000000, 1 => 0 (Flags: C)
test_arm_dataproc_lsl_4:
    ldr r0, =#0x00100004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    movs r1, r0, lsl #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ LSLS 1, 32 => 0 (Flags: C)
test_arm_dataproc_lsl_5:
    ldr r0, =#0x00100005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    mov r2, #32
    movs r1, r0, lsl r2
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ LSLS 2, 32 => 0 (Flags: none)
test_arm_dataproc_lsl_6:
    ldr r0, =#0x00100006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #2
    mov r2, #32
    movs r1, r0, lsl r2
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ LSLS 1, 33 => 0 (Flags: none)
test_arm_dataproc_lsl_7:
    ldr r0, =#0x00100007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    mov r2, #33
    movs r1, r0, lsl r2
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ LSLS 1, 257 => 2 (Flags: none)
test_arm_dataproc_lsl_8:
    ldr r0, =#0x00100008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    ldr r2, =#257
    movs r1, r0, lsl r2
    mrs r2, cpsr

    teq r1, #2
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14
