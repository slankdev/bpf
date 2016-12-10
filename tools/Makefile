
INCLUDE = ../include

all:
	g++ -std=c++11 bod.cc  -o bod.out  -I$(INCLUDE)
	g++ -std=c++11 gen.cc  -o gen.out  -I$(INCLUDE)
	g++ -std=c++11 bemu.cc -o bemu.out -I$(INCLUDE)


clean:
	rm -f bod.out
	rm -f gen.out
	rm -f bemu.out


install:
	cp bas.py    /usr/local/bin/bas
	cp bod.out   /usr/local/bin/bod
	cp bemu.out  /usr/local/bin/bemu
