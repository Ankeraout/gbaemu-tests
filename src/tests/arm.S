.include "tests/arm/dataproc.inc"

.text
.balign 4

.global test_arm

test_arm:
    push {lr}
    
    bl test_arm_dataproc

    pop {pc}
