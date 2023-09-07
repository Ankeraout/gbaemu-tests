.section .iwramBss
.balign 4
.code 32

.global g_currentTest
g_currentTest:
    .skip 4

.text
.balign 4
.code 32
.global testFailed
testFailed:
    ldr r0, =#0x7E57FA12
    ldr r1, =g_currentTest
    ldr r1, [r1]
    b .
