[BITS 16]; boot mode of bios
print_str_16_bit:
    push ax
    push si

.print_loop:
    lodsb ;load byte from ds:si to al and adds 1 to si
    cmp al, 0
    je .done
    mov ah, 0x0e
    int 0x10
    jmp .print_loop

.done:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10
    mov al, 0x0d
    int 0x10
    pop si
    pop ax
    ret