module tb_cla_32 ();


reg [31:0] A;
reg [31:0] B;
reg Cin;
wire Cout;
wire [31:0] Sum;


cla_32 cla_32_0(A, B, Cin, Cout, Sum);


reg [32:0] result;

initial begin
    $dumpfile("build/tb_cla_32.vcd");
    $dumpvars(0);
    
    repeat(10) begin
        A   <= $random;
        B   <= $random;
        Cin <= 0;
        #10;
        result = A + B + Cin;
        if (Sum != result[31:0]) begin
            $error("Sum failed!");
        end
        if (Cout != result[32]) begin
            $error("Cout failed!");
        end
        $display("%0h", A + B + Cin);
    end

end
    
endmodule