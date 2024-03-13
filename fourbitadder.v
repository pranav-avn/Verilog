//Gate level hierarchical description of 4-bit adder
//Description of half adder
module halfadder (S,C,x,y);
    input x,y;
    output S,C;
    //Instantiate Primitive Gates
    xor(S,x,y);
    and(C,x,y);
endmodule

//Description of full adder
