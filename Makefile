

MAKEFLAGS += --no-print-directory

all:
	make -C emu
	make -C tools
