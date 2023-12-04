module tb_alu_1();

reg A;
reg B;
reg Cin;
wire Cout;
wire Sum;
wire P;
wire G;

alu_1 uut(A, B, Cin, Cout, Sum, P, G);

initial begin
    $dumpfile("build/tb_alu_1.vcd");
    $dumpvars(0);
    
    repeat(10) begin
        A   <= $random;
        B   <= $random;
        Cin <= 0;
        #10;
    end

end
    
endmodule