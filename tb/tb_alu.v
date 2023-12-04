module tb_alu();

    reg Clk = 0;
    reg Reset = 0;
    reg [31:0] A = 0;
    reg [31:0] B = 0;
    reg [ 2:0] ALUOp = 0;
    wire Z; // Z = 1, if Result = 0
    wire V; // V = 1, if Overflow
    wire C; //  C32 = 1, if Carry-Out
    wire [31:0] Result;
    wire We;

    parameter MOD = 7;
           
    alu alu_0(Clk, Reset, A, B, ALUOp, Z, V, C, Result, We);

    always #5 Clk = ~Clk;
           
    initial begin
        $dumpfile("build/tb_alu.vcd");
        $dumpvars(0);

        Reset <= 1; #10;
        Reset <= 0; #10;

        // Test Mod
        A     <= 16;
        B     <= 5;
        ALUOp <= MOD;
        @We;
        $display("Result %0d", Result);

        #10;
        $finish;
    end



endmodule