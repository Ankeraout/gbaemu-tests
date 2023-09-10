.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_ror
test_arm_dataproc_ror:
    push {lr}

    bl test_arm_dataproc_ror_0
    bl test_arm_dataproc_ror_1
    bl test_arm_dataproc_ror_2
    bl test_arm_dataproc_ror_3
    bl test_arm_dataproc_ror_4
    bl test_arm_dataproc_ror_5

    pop {pc}

@ RRXS 2 => 1 (Flags: none)
test_arm_dataproc_ror_0:
    ldr r0, =#0x00130000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #2
    movs r1, r0, rrx
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RRXS (C) 2 => 0x80000001 (Flags: none)
test_arm_dataproc_ror_1:
    ldr r0, =#0x00130001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #2
    movs r1, r0, rrx
    mrs r2, cpsr

    teq r1, #0x80000001
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RRXS 3 => 1 (Flags: C)
test_arm_dataproc_ror_2:
    ldr r0, =#0x00130002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #3
    movs r1, r0, rrx
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ RRXS (C) 3 => 0x80000001 (Flags: C)
test_arm_dataproc_ror_3:
    ldr r0, =#0x00130003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #3
    movs r1, r0, rrx
    mrs r2, cpsr

    teq r1, #0x80000001
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ RORS 2, 1 => 1 (Flags: none)
test_arm_dataproc_ror_4:
    ldr r0, =#0x00130004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #2
    movs r1, r0, ror #1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RORS 3, 1 => 0x80000001 (Flags: C)
test_arm_dataproc_ror_5:
    ldr r0, =#0x00130005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #3
    movs r1, r0, ror #1
    mrs r2, cpsr

    teq r1, #0x80000001
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14
