MAKEFLAGS += --no-builtin-rules

MKDIR := mkdir -p
RM := rm -rf
CC := arm-none-eabi-gcc -c
LD := arm-none-eabi-gcc
OBJCOPY := arm-none-eabi-objcopy
ASM := arm-none-eabi-as
ASMFLAGS := -Iinclude
PYTHON := python3

CFLAGS += -MMD -MP
CFLAGS += -W -Wall -Wextra
CFLAGS += -std=gnu99 -pedantic-errors
CFLAGS += -O0
CFLAGS += -Iinclude
CFLAGS += -ffreestanding -fno-builtin -nostdlib
CFLAGS += -mcpu=arm7tdmi -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -mthumb-interwork -mthumb
LDFLAGS += -O0 --specs=nosys.specs -mcpu=arm7tdmi -mtune=arm7tdmi -fomit-frame-pointer -ffast-math -nostartfiles

rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

SOURCES_C := $(call rwildcard, src, *.c)
SOURCES_ASM := $(call rwildcard, src, *.S)
SOURCES := $(SOURCES_C) $(SOURCES_ASM)
OBJECTS_C := $(patsubst src/%.c, obj/src/%.c.o, $(SOURCES_C))
OBJECTS_ASM := $(patsubst src/%.S, obj/src/%.S.o, $(SOURCES_ASM))
OBJECTS := $(OBJECTS_C) $(OBJECTS_ASM)
DIRECTORIES := $(patsubst src/%, obj/src/%, $(dir $(SOURCES)))
EXECUTABLE := bin/gbaemu-tests
DEPENDENCIES := $(patsubst src/%.c, obj/src/%.c.d, $(SOURCES_C))

all: dirs $(EXECUTABLE).gba

obj/%.c.o: %.c
	$(CC) $(CFLAGS) $< -o $@

obj/%.S.o: %.S
	$(ASM) $(ASMFLAGS) $< -o $@

obj/res.tar: res
	tar cf $@ $<

obj/src/res.S.o: obj/res.tar

$(EXECUTABLE).gba: $(EXECUTABLE).elf
	$(OBJCOPY) -O binary $< $@
	$(PYTHON) header.py $@

$(EXECUTABLE).elf: $(OBJECTS)
	$(LD) $(LDFLAGS) $^ -o $@ -T src/gba.ld

clean:
	$(RM) bin obj

-include $(DEPENDENCIES)

dirs:
	$(MKDIR) bin $(DIRECTORIES)

.PHONY: all clean dirs
