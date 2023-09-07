.include "tests/arm/dataproc/and.inc"
.include "tests/arm/dataproc/eor.inc"
.include "tests/arm/dataproc/sub.inc"
.include "tests/arm/dataproc/rsb.inc"
.include "tests/arm/dataproc/add.inc"
.include "tests/arm/dataproc/adc.inc"

.text
.balign 4

.global test_arm_dataproc

test_arm_dataproc:
    push {lr}

    bl test_arm_dataproc_and
    bl test_arm_dataproc_eor
    bl test_arm_dataproc_sub
    bl test_arm_dataproc_rsb
    bl test_arm_dataproc_add
    bl test_arm_dataproc_adc

    pop {pc}