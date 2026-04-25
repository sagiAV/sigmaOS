[BITS 16]; boot mode of bios
print_hex_16_bit:
    push ax
    push cx
    push dx

    mov dx, ax
    ror dx, 12

    mov al, 0x30
    mov ah, 0x0e
    int 0x10
    mov al, 0x58
    mov ah, 0x0e
    int 0x10

    mov cx, 0x00

.print_hex_loop:
    cmp cx, 0x04
    je .done_hex

    mov ax , dx
    and ax, 0x000f
    add al, 0x30
    cmp al, 0x39
    jle .print_hex_char

    add al, 0x07

.print_hex_char:

    mov ah, 0x0e
    int 0x10
    ror dx, 12
    inc cx
    jmp .print_hex_loop

.done_hex:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    pop dx
    pop cx
    pop ax
    ret