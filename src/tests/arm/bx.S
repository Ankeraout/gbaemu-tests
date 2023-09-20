.include "test.inc"

.text
.balign 4

.global test_arm_bx

test_arm_bx:
    push {lr}

    bl test_arm_bx_0
    bl test_arm_bx_1

    pop {pc}

@ BX to ARM code location
test_arm_bx_0:
    ldr r0, =#0x00150000
    ldr r1, =g_currentTest
    str r0, [r1]

    bx r14

    @ No jump: test failed
    bl testFailed

@ BX to Thumb code location
test_arm_bx_1:
    ldr r0, =#0x00150001
    ldr r1, =g_currentTest
    str r0, [r1]

    adr r0, test_arm_bx_1.target + 1
    bx r0

    @ No jump: test failed
    bl testFailed

test_arm_bx_1.target:
    .code 16
    bx r14
