

SRC = main.v    \
	  clk_gen.v \
	  cpu.v     \
	  execute.v

	  # decode.v  \
	  # alu.v     \
	  # mux.v     \
	  # demux.v
	  # fetch.v  \

TOPMOD = main
IVERILOG = /usr/local/bin/iverilog

all:
	$(IVERILOG) -s $(TOPMOD) $(SRC)
