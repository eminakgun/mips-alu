module alu(input Clk,
           input Reset,
           input [31:0] A,
           input [31:0] B, 
           input [ 2:0] ALUOp,
           output C, //  C32 = 1, if Carry-Out
           output [31:0] Result,
           output We);


    wire [31:0] B_in;
    wire        Cout;
    wire [31:0]  Sum;
    wire [31:0]  AND;
    wire [31:0]   OR;
    wire [31:0]  XOR;
    wire [31:0]  NOR;
    wire [31:0] Less;

    // CLA-32
    wire Cin;
    cla_32 cla_32_inst(A, B_in, Cin, Cout, Sum, AND, OR, XOR, NOR);
    
    // Cin selection
    buf Cin_buf(Cin, Sub_En); // basically same as Sub_En

    // B xor SUB, for Subtraction
    not (ALU0_not, ALUOp[0]);
    and SubEn_and(Sub_En, ALUOp[2], ALUOp[1], ALU0_not);
    
	 xor B_xor_0( B_in[0],  B[0],  Sub_En);
	 xor B_xor_1( B_in[1],  B[1],  Sub_En);
	 xor B_xor_2( B_in[2],  B[2],  Sub_En);
	 xor B_xor_3( B_in[3],  B[3],  Sub_En);
	 xor B_xor_4( B_in[4],  B[4],  Sub_En);
	 xor B_xor_5( B_in[5],  B[5],  Sub_En);
	 xor B_xor_6( B_in[6],  B[6],  Sub_En);
	 xor B_xor_7( B_in[7],  B[7],  Sub_En);
	 xor B_xor_8( B_in[8],  B[8],  Sub_En);
	 xor B_xor_9( B_in[9],  B[9],  Sub_En);
	 xor B_xor_10(B_in[10], B[10], Sub_En);
	 xor B_xor_11(B_in[11], B[11], Sub_En);
	 xor B_xor_12(B_in[12], B[12], Sub_En);
	 xor B_xor_13(B_in[13], B[13], Sub_En);
	 xor B_xor_14(B_in[14], B[14], Sub_En);
	 xor B_xor_15(B_in[15], B[15], Sub_En);
	 xor B_xor_16(B_in[16], B[16], Sub_En);
	 xor B_xor_17(B_in[17], B[17], Sub_En);
	 xor B_xor_18(B_in[18], B[18], Sub_En);
	 xor B_xor_19(B_in[19], B[19], Sub_En);
	 xor B_xor_20(B_in[20], B[20], Sub_En);
	 xor B_xor_21(B_in[21], B[21], Sub_En);
	 xor B_xor_22(B_in[22], B[22], Sub_En);
	 xor B_xor_23(B_in[23], B[23], Sub_En);
	 xor B_xor_24(B_in[24], B[24], Sub_En);
	 xor B_xor_25(B_in[25], B[25], Sub_En);
	 xor B_xor_26(B_in[26], B[26], Sub_En);
	 xor B_xor_27(B_in[27], B[27], Sub_En);
	 xor B_xor_28(B_in[28], B[28], Sub_En);
	 xor B_xor_29(B_in[29], B[29], Sub_En);
	 xor B_xor_30(B_in[30], B[30], Sub_En);
	 xor B_xor_31(B_in[31], B[31], Sub_En);

    // Less logic
    // TODO
    
    // Mod
    wire We_Mod;
    wire [31:0] Mod_Result;
    and ModEn_and(Mod_En, ALUOp[0], ALUOp[1], ALUOp[2]);
    mod mod_inst(Clk, Reset, Mod_En, A, B, Mod_Result, We_Mod);

    // Mux8x1x32
    mux8x1x32 mux8x1x32_inst(AND, OR, XOR, NOR, Less, Sum, Sum, Mod_Result, ALUOp, Result);

    // 2:1 Mux for Write Enable, We
    // Mod_En We
    // 0      1
    // 1      We_Mod
    not Mod_En_not(ModEn_not, Mod_En);
    and Mod_We_and(We_Mod_En, Mod_En,  We_Mod);
    or  We_or     (We, ModEn_not, We_Mod_En);

endmodule