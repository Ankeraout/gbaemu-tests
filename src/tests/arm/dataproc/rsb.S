.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_rsb
test_arm_dataproc_rsb:
    push {lr}

    bl test_arm_dataproc_rsb_0
    bl test_arm_dataproc_rsb_1
    bl test_arm_dataproc_rsb_2
    bl test_arm_dataproc_rsb_3
    bl test_arm_dataproc_rsb_4
    bl test_arm_dataproc_rsb_5
    bl test_arm_dataproc_rsb_6
    bl test_arm_dataproc_rsb_7
    
    pop {pc}

@ RSBS 0, 0 => 0 (flags = ZC)
test_arm_dataproc_rsb_0:
    ldr r0, =#0x00030000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rsbs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSBS 0, 1 => 1 (flags = C)
test_arm_dataproc_rsb_1:
    ldr r0, =#0x00030001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rsbs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSBS 1, 0 => 0xffffffff (flags = N)
test_arm_dataproc_rsb_2:
    ldr r0, =#0x00030002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    rsbs r1, r0, #0
    mrs r2, cpsr
    
    mvn r0, #0
    teq r1, r0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ RSBS 1, 1 => 0 (flags = ZC)
test_arm_dataproc_rsb_3:
    ldr r0, =#0x00030003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    rsbs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSB 0, 0 => 0 (flags = unchanged)
test_arm_dataproc_rsb_4:
    ldr r0, =#0x00030004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rsb r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ RSBS 0, 0x80000000 => 0x80000000 (Flags: NC)
test_arm_dataproc_rsb_5:
    ldr r0, =#0x00030005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    rsbs r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ RSBS 0x10000000, 0x80000000 => 0x70000000 (Flags: CV)
test_arm_dataproc_rsb_6:
    ldr r0, =#0x00030006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x10000000
    rsbs r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #0x70000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SUBS 0x80000000, 0 => 0x80000000 (Flags: NV)
test_arm_dataproc_rsb_7:
    ldr r0, =#0x00030007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    rsbs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14
