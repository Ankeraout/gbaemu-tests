.text
.balign 4
.code 32

.extern main

.global _start
_start:
    bl main
    b .
