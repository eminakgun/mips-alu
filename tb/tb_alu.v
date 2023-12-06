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
        test_mod(16, 5); #1;
        $display("Result %0d, %0t", Result, $time);
        @(posedge Clk);

        test_mod(42, 11); #1;
        $display("Result %0d, %0t", Result, $time);
        @(posedge Clk);

        #10;
        $finish;
    end

    task test_mod(input [31:0] a, input [31:0] b);
        begin
            A     <= a;
            B     <= b;
            ALUOp <= MOD;
            @(posedge Clk);
            wait(We == 1);
        end
    endtask


endmodule