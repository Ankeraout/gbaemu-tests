.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_cmn
test_arm_dataproc_cmn:
    push {lr}

    bl test_arm_dataproc_cmn_0
    bl test_arm_dataproc_cmn_1
    bl test_arm_dataproc_cmn_2
    bl test_arm_dataproc_cmn_3
    bl test_arm_dataproc_cmn_4
    bl test_arm_dataproc_cmn_5
    bl test_arm_dataproc_cmn_6
    bl test_arm_dataproc_cmn_7
    bl test_arm_dataproc_cmn_8
    bl test_arm_dataproc_cmn_9
    
    pop {pc}

@ CMN 0, 0 => 0 (Flags: Z)
test_arm_dataproc_cmn_0:
    ldr r0, =#0x000b0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmn r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ CMN 0, 1 => 1 (Flags: none)
test_arm_dataproc_cmn_1:
    ldr r0, =#0x000b0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmn r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ CMN 1, 0 => 1 (Flags: none)
test_arm_dataproc_cmn_2:
    ldr r0, =#0x000b0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    cmn r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ CMN 1, 1 => 2 (Flags: none)
test_arm_dataproc_cmn_3:
    ldr r0, =#0x000b0003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    cmn r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ CMN 0x80000000, 1 => 0x80000001 (Flags: N)
test_arm_dataproc_cmn_4:
    ldr r0, =#0x000b0004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    cmn r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ CMN 0x80000000, 0x80000000 => 0 (Flags: ZCV)
test_arm_dataproc_cmn_5:
    ldr r0, =#0x000b0005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    cmn r0, #0x80000000
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ CMN 0x80000000, 0x80000001 => 1 (Flags: CV)
test_arm_dataproc_cmn_6:
    ldr r0, =#0x000b0006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    cmn r0, #0x80000001
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ CMN 0x70000000, 0x10000000 => 0x80000000 (Flags: NV)
test_arm_dataproc_cmn_7:
    ldr r0, =#0x000b0007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x70000000
    cmn r0, #0x10000000
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ CMN 0xF0000000, 0x10000000 => 0 (Flags: ZC)
test_arm_dataproc_cmn_8:
    ldr r0, =#0x000b0008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0xF0000000
    cmn r0, #0x10000000
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ CMN 0xaaaaaaaa, 0x55555555 => 0xffffffff (Flags: N) (Rd not written)
test_arm_dataproc_cmn_9:
    ldr r0, =#0x000b0009
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =0xaaaaaaaa
    ldr r1, =0x55555555
    cmn r0, r1
    mrs r2, cpsr

    teq r1, r0, lsr #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14
