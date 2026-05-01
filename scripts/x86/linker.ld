OUTPUT_FORMAT(elf32-i386)
ENTRY(kernal_start)

SECTIONS
{
    . = 0xC0000000;
    PROVIDE(kernal_virt_start_addr = .);

    .head.text : {
        *(.head.text)
    }

    .text : {
        *(.text)
    }

    . = ALIGN(4k);
    .data : {
        *(.data)
    }

    . = ALIGN(4k);
    .bss :
    {
            _BSS_START = ABSOLUTE(.);
            *(.bss)
            *(COMMON)
    }
    _BSS_SIZE = ABSOLUTE(.) - _BSS_START;

    . = ALIGN(4k);
    .rodata : {
        *(.rodata)
    }

    . = ALIGN(4096);
    PROVIDE(kernel_virt_end_addr = .);

}