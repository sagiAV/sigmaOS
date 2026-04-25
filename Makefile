
export BOOT_MAKE := MakeBoot.mk
export x86_BOOT := source/boot/x86

x86_build: clean
	mkdir build
	$(MAKE) -C $(x86_BOOT) -f $(BOOT_MAKE) boot

x86_run:
	qemu-system-x86_64 -hda $(CURDIR)/build/boot.bin

x86_build_run: x86_build
	qemu-system-x86_64 -hda $(CURDIR)/build/boot.bin

clean:
	rm -rf build