

SRC = main.v    \
	  clk_gen.v \
	  cpu.v     \
	  cpu_if.v  \
	  cpu_dc.v  \
	  cpu_ex.v  \
	  cpu_wb.v  \
	  alu.v     \
	  mux.v     \
	  demux.v   \
	  rom.v

TOPMOD = main
IVERILOG = /usr/local/bin/iverilog

all:
	$(IVERILOG) -s $(TOPMOD) $(SRC)
