module tb_mux8x1x1();

reg In_0 = 0;
reg In_1 = 0;
reg In_2 = 0;
reg In_3 = 0;
reg In_4 = 0;
reg In_5 = 0;
reg In_6 = 0;
reg In_7 = 0;
reg [2:0] Sel = 0;
wire Out;

mux8x1x1 mux8x1x1_uut (In_0, In_1, In_2, In_3, 
                       In_4, In_5, In_6, In_7,
                       Sel, Out);

initial begin

    repeat(10) begin
        {In_0, In_1, In_2, In_3, In_4, In_5, In_6, In_7} = $random;
        Sel = $random;
        #10;
        $display("In_0: %0d, In_1: %0d, In_2: %0d, In_3: %0d, In_4: %0d, In_5: %0d, In_6: %0d, In_7: %0d", 
                  In_0, In_1, In_2, In_3, In_4, In_5, In_6, In_7);
        $display("Sel: %0b: Out %0b", Sel, Out);
    end


    
end
    
endmodule