.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_add
test_arm_dataproc_add:
    push {lr}

    bl test_arm_dataproc_add_0
    bl test_arm_dataproc_add_1
    bl test_arm_dataproc_add_2
    bl test_arm_dataproc_add_3
    bl test_arm_dataproc_add_4
    bl test_arm_dataproc_add_5
    bl test_arm_dataproc_add_6
    bl test_arm_dataproc_add_7
    bl test_arm_dataproc_add_8
    bl test_arm_dataproc_add_9
    
    pop {pc}

@ ADDS 0, 0 => 0 (Flags: Z)
test_arm_dataproc_add_0:
    ldr r0, =#0x00040000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    adds r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ ADDS 0, 1 => 1 (Flags: none)
test_arm_dataproc_add_1:
    ldr r0, =#0x00040001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    adds r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADDS 1, 0 => 1 (Flags: none)
test_arm_dataproc_add_2:
    ldr r0, =#0x00040002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    adds r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADDS 1, 1 => 2 (Flags: none)
test_arm_dataproc_add_3:
    ldr r0, =#0x00040003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    adds r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #2
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADDS 0x80000000, 1 => 0x80000001 (Flags: N)
test_arm_dataproc_add_4:
    ldr r0, =#0x00040004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    adds r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #0x80000001
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ ADDS 0x80000000, 0x80000000 => 0 (Flags: ZCV)
test_arm_dataproc_add_5:
    ldr r0, =#0x00040005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    adds r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADDS 0x80000000, 0x80000001 => 1 (Flags: CV)
test_arm_dataproc_add_6:
    ldr r0, =#0x00040006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    adds r1, r0, #0x80000001
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADDS 0x70000000, 0x10000000 => 0x80000000 (Flags: NV)
test_arm_dataproc_add_7:
    ldr r0, =#0x00040007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x70000000
    adds r1, r0, #0x10000000
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADDS 0xF0000000, 0x10000000 => 0 (Flags: ZC)
test_arm_dataproc_add_8:
    ldr r0, =#0x00040008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0xF0000000
    adds r1, r0, #0x10000000
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ ADD 0, 0 => 0 (Flags: unchanged)
test_arm_dataproc_add_9:
    ldr r0, =#0x00040009
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    add r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14
