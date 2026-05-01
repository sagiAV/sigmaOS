[BITS 32]
[extern kmain]
section .head.text
global kernal_start

kernal_start:
    call kmain
    jmp $


