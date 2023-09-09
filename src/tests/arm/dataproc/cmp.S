.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_cmp
test_arm_dataproc_cmp:
    push {lr}

    bl test_arm_dataproc_cmp_0
    bl test_arm_dataproc_cmp_1
    bl test_arm_dataproc_cmp_2
    bl test_arm_dataproc_cmp_3
    bl test_arm_dataproc_cmp_4
    bl test_arm_dataproc_cmp_5
    bl test_arm_dataproc_cmp_6
    bl test_arm_dataproc_cmp_7
    
    pop {pc}

@ SUBS 0, 0 => 0 (flags = ZC)
test_arm_dataproc_cmp_0:
    ldr r0, =#0x000a0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmp r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 0, 1 => 0xffffffff (flags = N)
test_arm_dataproc_cmp_1:
    ldr r0, =#0x000a0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmp r0, #1
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ SUBS 1, 0 => 1 (flags = C)
test_arm_dataproc_cmp_2:
    ldr r0, =#0x000a0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    cmp r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 1, 1 => 0 (flags = ZC)
test_arm_dataproc_cmp_3:
    ldr r0, =#0x000a0003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmp r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUB 0xaaaaaaaa, 0x55555555 => (flags = CV) (Rd not written)
test_arm_dataproc_cmp_4:
    ldr r0, =#0x000a0004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =0xaaaaaaaa
    ldr r1, =0x55555555
    cmp r0, r1
    mrs r2, cpsr

    teq r1, r0, lsr #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SUBS 0x80000000, 0 => 0x80000000 (Flags: NC)
test_arm_dataproc_cmp_5:
    ldr r0, =#0x000a0005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    cmp r0, #0
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ SUBS 0x80000000, 0x10000000 => 0x70000000 (Flags: CV)
test_arm_dataproc_cmp_6:
    ldr r0, =#0x000a0006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    cmp r0, #0x10000000
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ SUBS 0, 0x80000000 => 0x80000000 (Flags: NV)
test_arm_dataproc_cmp_7:
    ldr r0, =#0x000a0007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    cmp r0, #0x80000000
    mrs r2, cpsr

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14
