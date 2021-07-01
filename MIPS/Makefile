
SOURCES=core.v nextpc.v equally.v tb_core.v
SOURCES_DIR=Components
OUTPUT_DIR=Debug/
OUTPUT_NAME=core.out

all: compile
	vvp $(OUTPUT_DIR)$(OUTPUT_NAME)


compile: $(SOURCES)
	iverilog -o $(OUTPUT_DIR)$(OUTPUT_NAME) $(SOURCES) -y $(SOURCES_DIR)


wave: compile
	vvp $(OUTPUT_DIR)$(OUTPUT_NAME)
	gtkwave $(OUTPUT_DIR)core.vcd


