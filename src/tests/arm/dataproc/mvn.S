.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_mvn
test_arm_dataproc_mvn:
    push {lr}

    bl test_arm_dataproc_mvn_0
    bl test_arm_dataproc_mvn_1
    bl test_arm_dataproc_mvn_2
    bl test_arm_dataproc_mvn_3

    pop {pc}

@ MVNS 0xffffffff => 0 (flags = Z)
test_arm_dataproc_mvn_0:
    ldr r0, =#0x000f0000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =#0xffffffff
    mvns r1, r0
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ MVNS 0xfffffffe => 1 (flags = none)
test_arm_dataproc_mvn_1:
    ldr r0, =#0x000f0001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =#0xfffffffe
    mvns r1, r0
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ MVNS 0x7fffffff => 0x80000000 (flags = N)
test_arm_dataproc_mvn_2:
    ldr r0, =#0x000f0002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =#0x7fffffff
    mvns r1, r0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ MVNS 0x7fffffff => 0x80000000 (flags unchanged)
test_arm_dataproc_mvn_3:
    ldr r0, =#0x000f0003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =#0x7fffffff
    mvn r1, r0
    mrs r2, cpsr

    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14
