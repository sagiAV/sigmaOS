[BITS 16]; boot mode of bios
[ORG 0X7c00]; bios load addr

jmp start

%include "../../../../include/arch/x86/boot/print_utils/print_string.s"
%include "../../../../include/arch/x86/boot/print_utils/print_hex.s"
%include "../../../../include/arch/x86/boot/gdt.s"
%include "../../../../include/arch/x86/boot/pm_switch.s"

[BITS 16]

start:
    cli; clear interupts
    xor ax, ax; set default ax value
    mov ds, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov es, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov ss, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov bp, 0x8000 ;set the stack to 0x8000 (far from load 0x7c00)
    mov sp, bp
    sti; enable interupts

    mov si, MSG_REAL_MODE;print debug location message
    call print_str_16_bit

    call switch_to_pm
    jmp $

[BITS 32]
start_pm:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    jmp $


MSG_REAL_MODE db 'Started in 16 bit real mode', 0
MSG_PROT_MODE db 'Loaded 32-bit protected mode', 0


times 510 - ($ - $$) db 0

dw 0xAA55