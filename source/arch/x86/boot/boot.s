[BITS 16]; boot mode of bios
[ORG 0X7c00]; bios load addr

jmp start

%include "../../../../include/arch/x86/boot/print_utils/print_string.s"
%include "../../../../include/arch/x86/boot/print_utils/print_hex.s"

start:
    cli; clear interupts
    mov ax, 0x00 ;
    mov bx, 0x00
    mov cx, 0x00
    mov dx, 0x00
    mov ds, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov es, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov ss, ax ;set start segment as 0x00 in offset to ORG of 0x7c00
    mov bp, 0x8000 ;set the stack to 0x8000 (far from load 0x7c00)
    mov sp, bp
    sti; enable interupts

    mov si, MSG_REAL_MODE
    call print_str_16_bit
    mov ax, 0x5757
    call print_hex_16_bit
    hlt



MSG_REAL_MODE db 'Started in 16 bit real mode', 0



times 510 - ($ - $$) db 0

dw 0xAA55