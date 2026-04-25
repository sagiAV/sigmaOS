[BITS 16]

print_hex_16_bit:
    push ax
    push cx
    push dx

    mov dx, ax; moving ax input to the dx register
    ror dx, 12; adjusting bit print order

    mov al, 0x30;0 ascii value
    mov ah, 0x0e
    int 0x10; printing 0 for the 0x prefix
    mov al, 0x58 ;x ascii value
    mov ah, 0x0e
    int 0x10; printing x for the 0x prefix

    xor cx, cx

.print_hex_loop:
    cmp cx, 0x04;looping for times for max hex 16 bit 0x0000
    je .done_hex

    mov ax , dx
    and ax, 0x000f;masking lower 4 bits
    add al, 0x30;add for decimal 0-9
    cmp al, 0x39; check bigger than 9
    jle .print_hex_char

    add al, 0x07; add for hex digit A-F

.print_hex_char:

    mov ah, 0x0e
    int 0x10; print hex char
    ror dx, 12; adjust rotation for print
    inc cx; increase cx by 1 for loop
    jmp .print_hex_loop

.done_hex:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10; print \n char for new line
    mov al, 0x0d
    int 0x10; return to start of line
    pop dx
    pop cx
    pop ax
    ret