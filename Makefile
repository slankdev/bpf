

MAKEFLAGS += --no-print-directory

all:
	make -C tools

clean:
	make -C tools clean

install:
	make -C tools install
