[BITS 16]

disk_load:

    push bx
    push dx

    mov ah, 0x02 ; bios 13h interupt read value
    mov al, dh ; numbers of sectors
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 13h
    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error


    pop bx
    ret



disk_error:
    mov si, DISK_ERROR
    mov dh, ah
    mov ax, dx
    call print_str_16_bit
    call print_hex_16_bit
    jmp $

sectors_error:
    mov si, SECTORES_ERROR
    mov ah, dh
    call print_hex_16_bit
    call print_str_16_bit
    jmp $



DISK_ERROR db "Disk read error", 0
SECTORES_ERROR db "Incorrect number of sectors read", 0