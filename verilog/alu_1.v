module alu_1(input  A,
             input  B,
             input  Cin,
             output Cout,
             output Sum,
             output P,
             output G);

    or A_or_B(a_or_b, A, B);          // A or B
    and A_and_B(a_and_b, A, B);       // A and B

    // A + B
    not not_A_and_B(not_a_and_b, a_and_b); // ~(A and B)
    and A_xor_B(a_xor_b, not_a_and_b, a_or_b); // A xor B
    xor Sum_a_b_c(Sum, a_xor_b, Cin); // sum = (A xor B) xor Cin

    // CLL
    buf (P, a_or_b);  // Propagate
    buf (G, a_and_b); // Generate

    and(P_and_Cin, P, Cin);
    or(Cout, G, P_and_Cin); // Cout = g(i) + p(i)c(i)
    

endmodule