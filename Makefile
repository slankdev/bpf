

MAKEFLAGS += --no-print-directory

all:
	make -C emu
	make -C sample gen
	make -C sample dis
