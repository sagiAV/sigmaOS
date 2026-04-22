
boot:
	nasm -f bin $(CURDIR)/source/arch/x86_64/boot/bios.s -o $(CURDIR)/build/boot.bin