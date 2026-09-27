x86_BOOT_DIR := ../../source/boot/x86
INCLUDE_DIR := ../../include
STAGE_1 := ../../build/boot_stage_1.bin
STAGE_2 := ../../build/boot_stage_2.bin
OS_IMG := ../../build/sigmaOS.img

boot:
	nasm -f bin -i $(INCLUDE_DIR) $(x86_BOOT_DIR)/boot_stage_1.s -o $(STAGE_1)
	nasm -f bin -i $(INCLUDE_DIR) $(x86_BOOT_DIR)/boot_stage_2.s -o $(STAGE_2)
	dd if=/dev/zero of=$(OS_IMG) bs=512 count=2880
	dd if=$(STAGE_1) of=$(OS_IMG) bs=512 count=1 conv=notrunc
	dd if=$(STAGE_2) of=$(OS_IMG) bs=512 seek=1 conv=notrunc