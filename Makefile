export BOOT_DIR := boot/
export BOOT_MAKE := MakeBoot.mk
export KERNAL_MAKE := MakeKernal.mk
export x86_DIR := scripts/x86


x86_build: clean
	mkdir build
	$(MAKE) -C $(x86_DIR) -f $(BOOT_MAKE) boot
	$(MAKE) -C $(x86_DIR) -f $(KERNAL_MAKE)

x86_run:
	qemu-system-x86_64 -drive format=raw,file=$(CURDIR)/build/sigmaOS.img

x86_debug:
	qemu-system-i386 -drive format=raw,file=$(CURDIR)/build/sigmaOS.img -s -S & \
	sleep 1; \
	pwndbg \
    -ex "set architecture i8086" \
    -ex "target remote localhost:1234" \

x86_build_run: x86_build x86_run

clean:
	rm -rf build