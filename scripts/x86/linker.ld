OUTPUT_FORMAT(elf32-i386)
ENTRY(kernal_start)

HIGHER_HALF_KERNAL = 0xC0000000;
CURR_LOAD = 0x10000;

SECTIONS
{
    . = HIGHER_HALF_KERNAL;

    PROVIDE(kernal_virt_start_addr = .);

    .head.text : AT(ADDR(.head.text) - HIGHER_HALF_KERNAL + CURR_LOAD)
    {
        *(.head.text)
    }

    .text : AT(ADDR(.text) - HIGHER_HALF_KERNAL + CURR_LOAD)
    {
        *(.text)
    }

    . = ALIGN(4k);
    .data : AT(ADDR(.data) - HIGHER_HALF_KERNAL + CURR_LOAD)
    {
        *(.data)
    }

    . = ALIGN(4k);
    .bss : AT(ADDR(.bss) - HIGHER_HALF_KERNAL + CURR_LOAD)
    {
            _BSS_START = ABSOLUTE(.);
            *(.bss)
            *(COMMON)
    }
    _BSS_SIZE = ABSOLUTE(.) - _BSS_START;

    . = ALIGN(4k);
    .rodata : AT(ADDR(.rodata)- HIGHER_HALF_KERNAL + CURR_LOAD)
    {
        *(.rodata)
    }

    . = ALIGN(4096);
    PROVIDE(kernel_virt_end_addr = .);

}