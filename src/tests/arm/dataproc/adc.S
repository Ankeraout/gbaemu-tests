.include "test.inc"

.text
.balign 4

.global test_arm_dataproc_adc
test_arm_dataproc_adc:
    push {lr}

    bl test_arm_dataproc_adc_0
    bl test_arm_dataproc_adc_1
    bl test_arm_dataproc_adc_2
    bl test_arm_dataproc_adc_3
    bl test_arm_dataproc_adc_4
    bl test_arm_dataproc_adc_5
    bl test_arm_dataproc_adc_6
    bl test_arm_dataproc_adc_7
    bl test_arm_dataproc_adc_8
    bl test_arm_dataproc_adc_9
    bl test_arm_dataproc_adc_10
    bl test_arm_dataproc_adc_11
    bl test_arm_dataproc_adc_12
    bl test_arm_dataproc_adc_13
    bl test_arm_dataproc_adc_14
    bl test_arm_dataproc_adc_15
    bl test_arm_dataproc_adc_16
    
    pop {pc}

@ ADCS 0, 0 => 0 (Flags: Z)
test_arm_dataproc_adc_0:
    ldr r0, =#0x00050000
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z)
    bne testFailed

    bx r14

@ ADCS 0, 1 => 1 (Flags: none)
test_arm_dataproc_adc_1:
    ldr r0, =#0x00050001
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS 1, 0 => 1 (Flags: none)
test_arm_dataproc_adc_2:
    ldr r0, =#0x00050002
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS 1, 1 => 2 (Flags: none)
test_arm_dataproc_adc_3:
    ldr r0, =#0x00050003
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #1
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #2
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS (C) 0, 0 => 1 (Flags: none)
test_arm_dataproc_adc_4:
    ldr r0, =#0x00050004
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS (C) 0, 1 => 2 (Flags: none)
test_arm_dataproc_adc_5:
    ldr r0, =#0x00050005
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #2
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS (C) 1, 0 => 2 (Flags: none)
test_arm_dataproc_adc_6:
    ldr r0, =#0x00050006
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #1
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #2
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS (C) 1, 1 => 3 (Flags: none)
test_arm_dataproc_adc_7:
    ldr r0, =#0x00050007
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #1
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #3
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADC 0, 0 => 0 (Flags: unchanged)
test_arm_dataproc_adc_8:
    ldr r0, =#0x00050008
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0
    adc r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #0
    bne testFailed

    bx r14

@ ADCS 0x80000000, 1 => 0x80000001 (Flags: N)
test_arm_dataproc_adc_9:
    ldr r0, =#0x00050009
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #0x80000001
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ ADCS (C) 0x80000000, 1 => 0x80000001 (Flags: N)
test_arm_dataproc_adc_10:
    ldr r0, =#0x0005000a
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    adcs r1, r0, #1
    mrs r2, cpsr
    
    teq r1, #0x80000002
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N)
    bne testFailed

    bx r14

@ ADCS 0x80000000, 0x80000000 => 0 (Flags: ZCV)
test_arm_dataproc_adc_11:
    ldr r0, =#0x0005000b
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    msr cpsr, r2

    mov r0, #0x80000000
    adcs r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADCS (C) 0x80000000, 0x80000000 => 1 (Flags: CV)
test_arm_dataproc_adc_12:
    ldr r0, =#0x0005000c
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0x80000000
    adcs r1, r0, #0x80000000
    mrs r2, cpsr
    
    teq r1, #1
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_C | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADCS (C) 0x7fffffff, 0 => 0x80000000 (Flags: NV)
test_arm_dataproc_adc_13:
    ldr r0, =#0x0005000d
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    ldr r0, =0x7fffffff
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADCS (C) 0, 0x7fffffff => 0x80000000 (Flags: NV)
test_arm_dataproc_adc_14:
    ldr r0, =#0x0005000e
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    ldr r1, =0x7fffffff
    adcs r1, r0, r1
    mrs r2, cpsr
    
    teq r1, #0x80000000
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_N | C_CPUFLAG_V)
    bne testFailed

    bx r14

@ ADCS (C) 0, 0xffffffff => 0 (Flags: ZC)
test_arm_dataproc_adc_15:
    ldr r0, =#0x0005000f
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    mov r0, #0
    ldr r1, =0xffffffff
    adcs r1, r0, r1
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14

@ ADCS (C) 0xffffffff, 0 => 0 (Flags: ZC)
test_arm_dataproc_adc_16:
    ldr r0, =#0x00050010
    ldr r1, =g_currentTest
    str r0, [r1]

    mrs r2, cpsr
    bic r2, #0xf0000000
    orr r2, #(C_CPUFLAG_C)
    msr cpsr, r2

    ldr r0, =0xffffffff
    adcs r1, r0, #0
    mrs r2, cpsr
    
    teq r1, #0
    bne testFailed

    and r2, #0xf0000000
    teq r2, #(C_CPUFLAG_Z | C_CPUFLAG_C)
    bne testFailed

    bx r14
