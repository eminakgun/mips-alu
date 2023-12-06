module alu(input Clk,
           input Reset,
           input [31:0] A,
           input [31:0] B, 
           input [ 2:0] ALUOp,
           output Z, // Z = 1, if Result = 0
           output V, // V = 1, if Overflow
           output C, //  C32 = 1, if Carry-Out
           output [31:0] Result,
           output We);

    // Mux8x1x32
    wire [31:0] MuxIn_0 = 0;
    wire [31:0] MuxIn_1 = 0;
    wire [31:0] MuxIn_2 = 0;
    wire [31:0] MuxIn_3 = 0;
    wire [31:0] MuxIn_4 = 0;
    wire [31:0] MuxIn_5 = 0;
    wire [31:0] MuxIn_6 = 0;
    mux8x1x32 mux8x1x32_inst(MuxIn_0, MuxIn_1, MuxIn_2, MuxIn_3, 
                             MuxIn_4, MuxIn_5, MuxIn_6, Mod_Result, ALUOp, Result);
    
    assign We = We_Mod; // TODO for now

    // Mod
    wire We_Mod;
    wire [31:0] Mod_Result;
    and ModEn_and(Mod_En, ALUOp[0], ALUOp[1], ALUOp[2]);
    mod mod_inst(Clk, Reset, Mod_En, A, B, Mod_Result, We_Mod);


endmodule