
TB_DIR ?= tb
C_ARGS = -g2005
IVLOG = iverilog $(C_ARGS) -o build/$@.vvp -y verilog 


.PHONY: cla_32
cla_32:
	iverilog -f alu.files -o cla_32.vvp

.PHONY: test_cla_32
tb_cla_32:
	$(IVLOG) $(TB_DIR)/tb_cla_32.v
	vvp build/$@.vvp

tb_alu_1:
	$(IVLOG) $(TB_DIR)/$@.v
	vvp build/$@.vvp

clean:
	rm -rf *.vcd *.vvp build/*