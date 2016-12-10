

MAKEFLAGS += --no-print-directory

all:
	make -C emu
	make -C tools

clean:
	make -C emu   clean
	make -C tools clean
