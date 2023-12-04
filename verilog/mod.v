module mod(input  Clk,
           input  Reset,
           input  En,
           input  [31:0] A,
           input  [31:0] B, // A % B, B operand
           output [31:0] Mod_Result,
           output We);

    wire [31:0] Sub_Result;
    wire [31:0] Dp_Result_reg;

    mod_cu cu_inst(Clk, Reset, En, A, B, Sub_Result, 
                    Done, Dp_Result_reg, Mod_Result, We);
    mod_dp dp_inst(Dp_Result_reg, B, Sub_Result, Done);
    
endmodule