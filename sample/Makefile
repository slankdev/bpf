
INCLUDE = ../include

def: dis

all:
	@echo "Usage make [COMMAND]"
	@echo "COMMAND:"
	@echo "  dis       dissasembler"
	@echo "  gen       generate doc"


dis:
	g++ -std=c++11 dissasm.cc -I$(INCLUDE)

gen:
	g++ -std=c++11 gen.cc -I$(INCLUDE)

