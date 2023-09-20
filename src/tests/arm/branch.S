.include "test.inc"

.text
.balign 4

.global test_arm_branch

test_arm_branch:
    push {lr}

    bl test_arm_branch_0
    bl test_arm_branch_1

    pop {pc}

@ B
test_arm_branch_0:
    ldr r0, =#0x00160000
    ldr r1, =g_currentTest
    str r0, [r1]

    b test_arm_branch_0.success

    @ No jump: test failed (so why would BL work anyway?)
    bl testFailed

test_arm_branch_0.success:
    bx r14

@ BL
test_arm_branch_1:
    ldr r0, =#0x00160001
    ldr r1, =g_currentTest
    str r0, [r1]

    mov r0, r14
    ldr r1, =test_arm_branch_1.failed
    bl test_arm_branch_1.success

    @ No jump: test failed (this will probably also not jump)

test_arm_branch_1.failed:
    bl testFailed

test_arm_branch_1.success:
    @ Make sure that the return address was stored in R14
    teq r1, r14
    blne testFailed

    bx r0
