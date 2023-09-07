.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_sub
test_arm_dataproc_sub:
    push {lr}

    bl test_arm_dataproc_sub_0
    bl test_arm_dataproc_sub_1
    bl test_arm_dataproc_sub_2
    bl test_arm_dataproc_sub_3
    bl test_arm_dataproc_sub_4
    bl test_arm_dataproc_sub_5
    bl test_arm_dataproc_sub_6
    bl test_arm_dataproc_sub_7
    
    pop {pc}

@ SUBS 0, 0 => 0 (flags = ZC)
test_arm_dataproc_sub_0:
    ldr r0, =#0x00020000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    subs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 0, 1 => 0xffffffff (flags = N)
test_arm_dataproc_sub_1:
    ldr r0, =#0x00020001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    subs r1, r0, #1
    mrs r2, cpsr
    
    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SUBS 1, 0 => 1 (flags = C)
test_arm_dataproc_sub_2:
    ldr r0, =#0x00020002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    subs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 1, 1 => 0 (flags = ZC)
test_arm_dataproc_sub_3:
    ldr r0, =#0x00020003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    subs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUB 0, 0 => 0 (flags = unchanged)
test_arm_dataproc_sub_4:
    ldr r0, =#0x00020004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    sub r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ SUBS 0x80000000, 0 => 0x80000000 (Flags: NC)
test_arm_dataproc_sub_5:
    ldr r0, =#0x00020005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    subs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 0x80000000, 0x10000000 => 0x70000000 (Flags: CV)
test_arm_dataproc_sub_6:
    ldr r0, =#0x00020006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    subs r1, r0, #0x10000000
    mrs r2, cpsr
    
    teq r1, #0x70000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SUBS 0, 0x80000000 => 0x80000000 (Flags: NV)
test_arm_dataproc_sub_7:
    ldr r0, =#0x00020007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    subs r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14
