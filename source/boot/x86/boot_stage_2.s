[BITS 32]
[ORG 0X8000]

jmp loader_main

%include "boot/x86/print_utils/print_string.s"

loader_main:
    cli
    xor ax, ax
    mov ebp, 0x90000
    mov esp, 0x90000
    sti
    mov ebx, MSG_STAGE_2
    call print_string_pm
    cli
    jmp .hlt_label

.hlt_label:
    hlt
    jmp .hlt_label

MSG_STAGE_2 db 'Entered Stage 2 bootloader', 0