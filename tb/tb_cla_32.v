module tb_cla_32 ();


wire [31:0] A;
wire [31:0] B;
wire Cin;
wire Cout;
wire [31:0] Sum;


cla_32 cla_32_0(A, B, Cin, Cout, Sum);


initial begin
    
    repeat(10) begin
        A   <= $random();
        B   <= $random();
        Cin <= 0;
        #10;
    end

end
    
endmodule