.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_eor
test_arm_dataproc_eor:
    push {lr}

    bl test_arm_dataproc_eor_0
    bl test_arm_dataproc_eor_1
    bl test_arm_dataproc_eor_2
    bl test_arm_dataproc_eor_3
    bl test_arm_dataproc_eor_4
    
    pop {pc}

@ EORS 0, 0 => 0 (flags = Z)
test_arm_dataproc_eor_0:
    ldr r0, =#0x00010000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    eors r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ EORS 1, 0 => 1 (flags = none)
test_arm_dataproc_eor_1:
    ldr r0, =#0x00010001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    eors r1, r0, #0
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ EORS 1, 1 => 0 (flags = Z)
test_arm_dataproc_eor_2:
    ldr r0, =#0x00010002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    eors r1, r0, #1
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ EORS 0x80000000, 0 => 0x80000000 (flags = N)
test_arm_dataproc_eor_3:
    ldr r0, =#0x00010003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    eors r1, r0, #0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ EOR 0x80000000, 0 => 0x80000000 (flags = unchanged)
test_arm_dataproc_eor_4:
    ldr r0, =#0x00010004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    eor r1, r0, #0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14
    