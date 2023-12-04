
TB_DIR ?= tb
C_ARGS = -g2005
IVLOG = iverilog $(C_ARGS) -o build/$@.vvp -y verilog 

TARGETS = cla_32 tb_cla_32 tb_alu_1 tb_mod tb_alu

$(TARGETS):
	$(IVLOG) $(TB_DIR)/$@.v
	vvp build/$@.vvp
	
clean:
	rm -rf *.vcd *.vvp build/*