.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_and
test_arm_dataproc_and:
    push {lr}

    bl test_arm_dataproc_and_0
    bl test_arm_dataproc_and_1
    bl test_arm_dataproc_and_2
    bl test_arm_dataproc_and_3
    bl test_arm_dataproc_and_4
    
    pop {pc}

@ ANDS 0, 0 => 0 (flags = Z)
test_arm_dataproc_and_0:
    ldr r0, =#0x00000000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    ands r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ ANDS 1, 0 => 0 (flags = Z)
test_arm_dataproc_and_1:
    ldr r0, =#0x00000001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    ands r1, r0, #0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ ANDS 1, 1 => 1 (flags = none)
test_arm_dataproc_and_2:
    ldr r0, =#0x00000002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    ands r1, r0, #1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ANDS 0x80000000, 0x80000000 => 0x80000000 (flags = N)
test_arm_dataproc_and_3:
    ldr r0, =#0x00000003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    mov r1, r0
    ands r1, r0, r1
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ AND 0x80000000, 0x80000000 => 0x80000000 (flags = unchanged)
test_arm_dataproc_and_4:
    ldr r0, =#0x00000004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    mov r1, r0
    and r1, r0, r1
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14
    