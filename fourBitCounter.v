//T Flip Flop
module tff(output reg q, input t, input clk, input rst);
    always @(posedge rst) begin
        if (rst) q=0;
    end
    always @(posedge clk) begin
        if(~rst) begin
            if(t) q<=~q; else q <= q;
        end
    end
endmodule

module ripplecounter(clk, t, rst, q);
    input clk, t, rst;
    output [3:0]q;

    //initiate 4 T-FF
    tff tf1(q[0], t, clk, rst);
    tff tf2(q[1], t, ~q[0], rst);
    tff tf3(q[2], t, ~q[1], rst);
    tff tf4(q[3], t, ~q[2], rst);
endmodule

//testbench
module tb;
    reg clk, rst;
    reg t;
    wire [3:0]q;
    ripplecounter dut(clk, t, rst, q);
    initial
        clk = 0;
    always
        #5 clk = ~clk;

    initial begin
        $dumpfile("RCounter.vcd");
        $dumpvars;
        rst = 0; t=1;
        #10 rst = 1;
        #10 rst = 0;
        #185 rst = 1;
        #10 rst = 0;
        #30 $finish;
    end

    initial
        $monitor("time = %g, rst = %b, clk = %b, t = %b, q = %d",$time, rst, clk, t, q);
endmodule
