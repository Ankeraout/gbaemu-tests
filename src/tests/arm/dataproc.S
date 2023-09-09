.include "tests/arm/dataproc/and.inc"
.include "tests/arm/dataproc/eor.inc"
.include "tests/arm/dataproc/sub.inc"
.include "tests/arm/dataproc/rsb.inc"
.include "tests/arm/dataproc/add.inc"
.include "tests/arm/dataproc/adc.inc"
.include "tests/arm/dataproc/sbc.inc"
.include "tests/arm/dataproc/rsc.inc"
.include "tests/arm/dataproc/tst.inc"
.include "tests/arm/dataproc/teq.inc"
.include "tests/arm/dataproc/cmp.inc"
.include "tests/arm/dataproc/cmn.inc"
.include "tests/arm/dataproc/orr.inc"
.include "tests/arm/dataproc/mov.inc"
.include "tests/arm/dataproc/bic.inc"
.include "tests/arm/dataproc/mvn.inc"

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
    bl test_arm_dataproc_sbc
    bl test_arm_dataproc_rsc
    bl test_arm_dataproc_tst
    bl test_arm_dataproc_teq
    bl test_arm_dataproc_cmp
    bl test_arm_dataproc_cmn
    bl test_arm_dataproc_orr
    bl test_arm_dataproc_mov
    bl test_arm_dataproc_bic
    bl test_arm_dataproc_mvn

    pop {pc}
