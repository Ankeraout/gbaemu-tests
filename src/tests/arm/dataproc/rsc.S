.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_rsc
test_arm_dataproc_rsc:
    push {lr}

    bl test_arm_dataproc_rsc_0
    bl test_arm_dataproc_rsc_1
    bl test_arm_dataproc_rsc_2
    bl test_arm_dataproc_rsc_3
    bl test_arm_dataproc_rsc_4
    bl test_arm_dataproc_rsc_5
    bl test_arm_dataproc_rsc_6
    bl test_arm_dataproc_rsc_7
    bl test_arm_dataproc_rsc_8
    bl test_arm_dataproc_rsc_9
    bl test_arm_dataproc_rsc_10
    bl test_arm_dataproc_rsc_11
    bl test_arm_dataproc_rsc_12
    bl test_arm_dataproc_rsc_13

    pop {pc}

@ RSCS 0, 0 => 0xffffffff (Flags: N)
test_arm_dataproc_rsc_0:
    ldr r0, =#0x00070000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSCS 0, 1 => 0 (Flags: ZC)
test_arm_dataproc_rsc_1:
    ldr r0, =#0x00070001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSCS 1, 0 => 0xfffffffe (Flags: N)
test_arm_dataproc_rsc_2:
    ldr r0, =#0x00070002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    rscs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #1
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSCS 1, 1 => 0xffffffff (Flags: N)
test_arm_dataproc_rsc_3:
    ldr r0, =#0x00070003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    rscs r1, r0, #1
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSCS (C) 0, 0 => 0 (Flags: ZC)
test_arm_dataproc_rsc_4:
    ldr r0, =#0x00070004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSCS (C) 0, 1 => 1 (Flags: C)
test_arm_dataproc_rsc_5:
    ldr r0, =#0x00070005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSCS (C) 1, 0 => 0xffffffff (Flags: N)
test_arm_dataproc_rsc_6:
    ldr r0, =#0x00070006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    mov r0, #1
    rscs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSCS (C) 1, 1 => 0 (Flags: ZC)
test_arm_dataproc_rsc_7:
    ldr r0, =#0x00070007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #C_CPUFLAG_C
    msr cpsr, r2

    mov r0, #1
    rscs r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSCS 0, 0x80000000 => 0x7fffffff (Flags: CV)
test_arm_dataproc_rsc_8:
    ldr r0, =#0x00070008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #0x80000000
    mrs r2, cpsr

    mvn r0, #0x80000000
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ RSCS 0x80000000, 0 => 0x7fffffff (Flags: none)
test_arm_dataproc_rsc_9:
    ldr r0, =#0x00070009
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    rscs r1, r0, #0
    mrs r2, cpsr

    mvn r0, #0x80000000
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ RSCS 0x80000000, 0x80000000 => 0xffffffff (Flags: N)
test_arm_dataproc_rsc_10:
    ldr r0, =#0x0007000a
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    rscs r1, r0, #0x80000000
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSCS (C) 0, 0x80000000 => 0x80000000 (Flags: NC)
test_arm_dataproc_rsc_11:
    ldr r0, =#0x0007000b
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    rscs r1, r0, #0x80000000
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSCS (C) 0x80000000, 0 => 0x80000000 (Flags: NV)
test_arm_dataproc_rsc_12:
    ldr r0, =#0x0007000c
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    rscs r1, r0, #0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ RSCS (C) 0x80000000, 0x80000000 => 0 (Flags: ZC)
test_arm_dataproc_rsc_13:
    ldr r0, =#0x0007000d
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    rscs r1, r0, #0x80000000
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14
