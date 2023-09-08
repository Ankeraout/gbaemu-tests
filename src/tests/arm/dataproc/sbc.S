.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_sbc
test_arm_dataproc_sbc:
    push {lr}

    bl test_arm_dataproc_sbc_0
    bl test_arm_dataproc_sbc_1
    bl test_arm_dataproc_sbc_2
    bl test_arm_dataproc_sbc_3
    bl test_arm_dataproc_sbc_4
    bl test_arm_dataproc_sbc_5
    bl test_arm_dataproc_sbc_6
    bl test_arm_dataproc_sbc_7
    bl test_arm_dataproc_sbc_8
    bl test_arm_dataproc_sbc_9
    bl test_arm_dataproc_sbc_10
    bl test_arm_dataproc_sbc_11
    bl test_arm_dataproc_sbc_12
    bl test_arm_dataproc_sbc_13

    pop {pc}

@ SBCS 0, 0 => 0xffffffff (Flags: N)
test_arm_dataproc_sbc_0:
    ldr r0, =#0x00060000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SBCS 0, 1 => 0xfffffffe (Flags: N)
test_arm_dataproc_sbc_1:
    ldr r0, =#0x00060001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #1
    mrs r2, cpsr

    mvn r0, #1
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SBCS 1, 0 => 0 (Flags: ZC)
test_arm_dataproc_sbc_2:
    ldr r0, =#0x00060002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    sbcs r1, r0, #0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SBCS 1, 1 => 0xffffffff (Flags: N)
test_arm_dataproc_sbc_3:
    ldr r0, =#0x00060003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    sbcs r1, r0, #1
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SBCS (C) 0, 0 => 0 (Flags: ZC)
test_arm_dataproc_sbc_4:
    ldr r0, =#0x00060004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SBCS (C) 0, 1 => 0xffffffff (Flags: N)
test_arm_dataproc_sbc_5:
    ldr r0, =#0x00060005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #1
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SBCS (C) 1, 0 => 1 (Flags: C)
test_arm_dataproc_sbc_6:
    ldr r0, =#0x00060006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #1
    sbcs r1, r0, #0
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SBCS (C) 1, 1 => 0 (Flags: ZC)
test_arm_dataproc_sbc_7:
    ldr r0, =#0x00060007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #1
    sbcs r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SBCS 0, 0x80000000 => 0x7fffffff (Flags: none)
test_arm_dataproc_sbc_8:
    ldr r0, =#0x00060008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #0x80000000
    mrs r2, cpsr

    mvn r0, #0x80000000
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ SBCS 0x80000000, 0 => 0x7fffffff (Flags: CV)
test_arm_dataproc_sbc_9:
    ldr r0, =#0x00060009
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    sbcs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #0x80000000
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SBCS 0x80000000, 0x80000000 => 0xffffffff (Flags: N)
test_arm_dataproc_sbc_10:
    ldr r0, =#0x0006000a
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    sbcs r1, r0, #0x80000000
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SBCS (C) 0, 0x80000000 => 0x80000000 (Flags: NV)
test_arm_dataproc_sbc_11:
    ldr r0, =#0x0006000b
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    sbcs r1, r0, #0x80000000
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SBCS (C) 0x80000000, 0 => 0x80000000 (Flags: NC)
test_arm_dataproc_sbc_12:
    ldr r0, =#0x0006000c
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    sbcs r1, r0, #0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SBCS (C) 0x80000000, 0x80000000 => 0 (Flags: ZC)
test_arm_dataproc_sbc_13:
    ldr r0, =#0x0006000d
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    sbcs r1, r0, #0x80000000
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14
