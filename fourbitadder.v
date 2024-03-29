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
module fulladder(S,C,x,y,z);
    input x,y,z;
    output S,C;
    wire S1, D1, D2; //Outputs of first XOR and two AND Gates
    //Instantiate the half adder
    halfadder HA1(S1,D1,x,y);
    halfadder HA2(S,D2,S1,z);
    or g1(C,D2,D1);
endmodule

//Test
module four_bit_adder(S,C4,A,B,C0);
    input[3:0]A,B;
    input C0;
    output[3:0]S;
    output C4;
    wire C1, C2, C3; //Intermediate Carries

    //Instantiate Full adder cells
    fulladder FA0(S[0], C1, A[0], B[0], C0),
        FA1(S[1], C2, A[1], B[1], C1),
        FA2(S[2], C3, A[2], B[2], C2),
        FA3(S[3], C4, A[3], B[3], C3);
endmodule

module testbench();
    //Inputs
    reg[3:0]a;
    reg[3:0]b;
    reg cin;
    //Outputs
    wire[3:0]sum;
    wire cout;

    four_bit_adder DUT(
        .A(a),
        .B(b),
        .C0(cin),
        .S(sum),
        .C4(cout)
    );
    reg clk;
    reg rst;

    //Initial values
    initial begin
        clk = 0;
        rst = 1;
        #20;
        rst = 0;
    end

    //Clock
    always begin
        #10 clk = ~clk;
    end

    //Test Sequence
    reg[3:0]i;
    always @(posedge clk, posedge rst) begin
        if(rst)begin
            i=0;
        end else begin
            //Apply all possible values(0-9)
            a<=$random%16;
            b<=$random%16;
            cin<=$random%2;
            #20;
            i = i+1;
            if(i == 10) $finish;
        end
        $monitor("%d: a= %b, b=%b, cin=%b, sum=%b, cout=%b",$time, a, b, cin, sum, cout);
    end
endmodule
