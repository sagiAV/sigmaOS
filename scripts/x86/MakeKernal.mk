COMMON_DIR := ../../source/kernal/source
X86_DIR := ../../source/kernal/arch/x86
BUILD_DIR := ../../build

KERNAL_ELF := $(BUILD_DIR)/kernal.elf

CC := gcc
AS := nasm

LINKER = linker.ld

ASFLAGS = -f elf32
CFLAGS := -m32 -ffreestanding -Wall -g
LDFLAGS := -m32 -ffreestanding -nostdlib -T $(LINKER)
LDFLAGS_SUFFIX_FLAGS := -Wl,-z,noexecstack



# sources search
C_SRC := $(shell find $(COMMON_DIR) -name "*.c") $(shell find $(X86_DIR) -name "*.c")
S_SRC := $(shell find $(COMMON_DIR) -name "*.s") $(shell find $(X86_DIR) -name "*.s")

# Tells make where to fins .s and .c files
vpath %.c $(COMMON_DIR) $(X86_DIR)
vpath %.s $(COMMON_DIR) $(X86_DIR)

C_OBJS := $(patsubst %.c, $(BUILD_DIR)/%.o, $(notdir $(C_SRC)))
S_OBJS := $(patsubst %.s, $(BUILD_DIR)/%.o, $(notdir $(S_SRC)))

OBJS := $(C_OBJS) $(S_OBJS)

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

$(KERNAL_ELF): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^ $(LDFLAGS_SUFFIX_FLAGS)
