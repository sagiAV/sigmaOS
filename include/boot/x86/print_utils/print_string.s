[BITS 16]
print_str_16_bit:
    push ax
    push si

.print_loop:
    lodsb ;load byte from ds:si to al and adds 1 to si
    cmp al, 0x00;check if end
    je .done
    mov ah, 0x0e
    int 0x10;print current string char
    jmp .print_loop

.done:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10;print \n char for new line
    mov al, 0x0d
    int 0x10;return to start of new line adjustment
    pop si
    pop ax
    ret

[bits 32] ; using 32-bit protected mode


VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; the color byte for each character

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ; check if end of string
    je print_string_pm_done

    mov [edx], ax ; store character + attribute in video memory
    add ebx, 1 ; next char
    add edx, 2 ; next video memory position

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret