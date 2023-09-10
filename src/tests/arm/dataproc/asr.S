.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_asr
test_arm_dataproc_asr:
    push {lr}

    bl test_arm_dataproc_asr_0
    bl test_arm_dataproc_asr_1
    bl test_arm_dataproc_asr_2
    bl test_arm_dataproc_asr_3
    bl test_arm_dataproc_asr_4
    bl test_arm_dataproc_asr_5
    bl test_arm_dataproc_asr_6
    bl test_arm_dataproc_asr_7

    pop {pc}

@ ASRS 0x01234567, 0 => 0x01234567 (Flags: none) (C flag unaffected)
test_arm_dataproc_asr_0:
    ldr r0, =#0x00120000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    ldr r0, =#0x01234567
    mov r1, #0
    movs r1, r0, lsr r1
    mrs r2, cpsr

    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ ASRS (C) 0x01234567, 0 => 0x01234567 (Flags: C) (C flag unaffected)
test_arm_dataproc_asr_1:
    ldr r0, =#0x00120001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    ldr r0, =#0x01234567
    mov r1, #0
    movs r1, r0, asr r1
    mrs r2, cpsr

    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ ASRS 2, 1 => 1 (Flags: none)
test_arm_dataproc_asr_2:
    ldr r0, =#0x00120002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #2
    movs r1, r0, asr #1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ ASRS 3, 1 => 1 (Flags: C)
test_arm_dataproc_asr_3:
    ldr r0, =#0x00120003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #3
    movs r1, r0, asr #1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ ASRS 0, 32 => 0 (Flags: none)
test_arm_dataproc_asr_4:
    ldr r0, =#0x00120004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    movs r1, r0, asr #32
    mrs r2, cpsr

    teq r1, #0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14

@ ASRS 0x80000000, 32 => 0xffffffff (Flags: C)
test_arm_dataproc_asr_5:
    ldr r0, =#0x00120005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    movs r1, r0, asr #32
    mrs r2, cpsr

    mvn r0, #0
    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ ASRS 0xffffffff, 33 => 0xffffffff (Flags: C)
test_arm_dataproc_asr_6:
    ldr r0, =#0x00120006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mvn r0, #0
    mov r1, #33
    movs r1, r0, asr r1
    mrs r2, cpsr

    teq r1, r0
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    beq testFailed

    bx r14

@ ASRS 2, 257 => 1 (Flags: none)
test_arm_dataproc_asr_7:
    ldr r0, =#0x00120007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #2
    ldr r1, =#257
    movs r1, r0, asr r1
    mrs r2, cpsr

    teq r1, #1
    bne testFailed

    tst r2, #(C_CPUFLAG_C)
    bne testFailed

    bx r14
