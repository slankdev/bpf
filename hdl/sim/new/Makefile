

SRC = main.v     \
	  clk_gen.v  \
	  cpu.v      \
	  execute.v  \
	  execute_alu.v  \
	  fetch.v    \
	  decode.v   \
	  decode_function.v \
	  allocate.v \
	  mux.v mux2.v


	  # decode.v  \
	  # alu.v     \
	  # mux.v     \
	  # demux.v
	  # fetch.v  \

TOPMOD = main
IVERILOG = /usr/local/bin/iverilog

all:
	$(IVERILOG) -g2005-sv -s $(TOPMOD) $(SRC)
