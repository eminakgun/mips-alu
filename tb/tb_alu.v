module tb_alu();

    reg Clk = 0;
    reg Reset = 0;
    reg [31:0] A = 0;
    reg [31:0] B = 0;
    reg [ 2:0] ALUOp = 0;
    wire C; //  C32 = 1, if Carry-Out
    wire [31:0] Result;
    wire We;

    parameter AND  = 0;
    parameter  OR  = 1;
    parameter XOR  = 2;
    parameter NOR  = 3;
    parameter LESS = 4;
    parameter ADD  = 5;
    parameter SUB  = 6;
    parameter MOD  = 7;
           
    alu alu_0(Clk, Reset, A, B, ALUOp, C, Result, We);

    always #5 Clk = ~Clk;
           
    initial begin
        $dumpfile("build/tb_alu.vcd");
        $dumpvars(0);

        Reset <= 1; #10;
        Reset <= 0; #10;

        send_instruction(1, 100, LESS); #10 // 1
        send_instruction(500, 333, LESS); #10 // 0
        send_instruction(-100, -300, LESS); #10 // 0
        send_instruction(-500, -300, LESS); #10 // 1
        send_instruction(-1, 100, LESS); #10  //1
        
        send_instruction($random, $random, AND); #10;
        send_instruction($random, $random, OR); #10;
        send_instruction($random, $random, XOR); #10;
        send_instruction($random, $random, NOR); #10;
        send_instruction($random, $random, LESS); #10;
        send_instruction($random, $random, ADD); #10;
        send_instruction($random, $random, SUB); #10;
        #3;

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

    task send_instruction(input [31:0] a, input [31:0] b, input [2:0] op);
    begin
        A     <= a;
        B     <= b;
        ALUOp <= op;
        wait(We == 1);
        #1;
        $display("Instruction Results,");
        $display("A:      %b", a);
        $display("B:      %b", b);
        $display("Result: %b, @%0t", Result, $time);
        $display("ALUop: %0d", op);
    end
    endtask

    task test_mod(input [31:0] a, input [31:0] b);
        begin
            A     <= a;
            B     <= b;
            ALUOp <= MOD;
            @(posedge Clk);
            @(posedge We);
        end
    endtask


endmodule