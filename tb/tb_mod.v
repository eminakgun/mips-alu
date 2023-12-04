module tb_mod();

reg Clk = 0;
reg Reset = 0;
reg En = 0;

reg  [31:0] A = 0;
reg  [31:0] B = 0;
wire [31:0] Mod_Result;
wire We;

mod uut(Clk, Reset, En, A, B, Mod_Result, We);

always begin
    Clk = ~Clk; 
    #5;
end

initial begin
    $dumpfile("build/tb_mod.vcd");
    $dumpvars(0);
    
    Reset <= 1;
    #10;
    Reset <= 0;

    #10;
    // 16 % 5
    En <= 1;
    A <= 16;
    B <= 5;
    #1;
    #100;
    //repeat(100) @Clk;
    //En <= 0;
    $finish;
end
    
endmodule