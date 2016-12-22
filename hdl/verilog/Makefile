

SRC = main.v    \
	  clk_gen.v \
	  cpu.v     \
	  fetch.v  \
	  decode.v  \
	  execute.v  \
	  alu.v     \
	  mux.v     \
	  demux.v

TOPMOD = main
IVERILOG = /usr/local/bin/iverilog

all:
	$(IVERILOG) -s $(TOPMOD) $(SRC)
