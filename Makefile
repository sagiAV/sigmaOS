
export ARCH_DIR := source/arch
export BOOT_MAKE := boot/MakeBoot.mk
export x86_64 := x86_64

.PHONY: x86_64 clean
all: x86_64 clean

x86_64:
	mkdir build
	$(MAKE) --file $(ARCH_DIR)/$(x86_64)/$(BOOT_MAKE) boot

help:
	echo @"hello"

clean:
	rm -rf build