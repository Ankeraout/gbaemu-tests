.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_orr
test_arm_dataproc_orr:
    push {lr}

    bl test_arm_dataproc_orr_0
    bl test_arm_dataproc_orr_1
    bl test_arm_dataproc_orr_2
    bl test_arm_dataproc_orr_3
    bl test_arm_dataproc_orr_4
    
    pop {pc}

@ ORRS 0, 0 => 0 (flags = Z)
test_arm_dataproc_orr_0:
    ldr r0, =#0x000c0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    orrs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ ORRS 0, 1 => 1 (flags = none)
test_arm_dataproc_orr_1:
    ldr r0, =#0x000c0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    orrs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ORRS 1, 0 => 1 (flags = none)
test_arm_dataproc_orr_2:
    ldr r0, =#0x000c0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    orrs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ORRS 1, 1 => 1 (flags = none)
test_arm_dataproc_orr_3:
    ldr r0, =#0x000c0003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    orrs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ORRS 0, 0x80000000 => 0x80000000 (flags = N)
test_arm_dataproc_orr_4:
    ldr r0, =#0x000c0004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    mov r1, #0x80000000
    orrs r1, r0, r1
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14
