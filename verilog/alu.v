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
    buf Cin_buf(Cin, Sub_En); // basically same as Cin


    // B xor SUB, for Subtraction
    not (ALU0_not, ALUOp[0]);
    and SubEn_and(Sub_En, ALUOp[2], ALUOp[1], ALU0_not);
    
    genvar i;
    generate for(i = 0; i < 32; i = i+1)
        xor B_xor(B_in[i], B[i], Sub_En);
    endgenerate

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