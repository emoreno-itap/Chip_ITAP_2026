
/*
 * 8-bit Ripple Carry Adder
 * Half Adder + Full Adder
 */

`default_nettype none

module tt_um_8bitadder (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire ena,
    input  wire clk,
    input  wire rst_n
);

    // Internal signals
    wire [7:0] sum;
    wire cout;

    // 8-bit Ripple Carry Adder
    rca8 adder (
        .A(ui_in),
        .B(uio_in),
        .cin(1'b0),
        .SUM(sum),
        .cout(cout)
    );

    // Output assignments
    assign uo_out  = sum;
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Unused signals
    wire _unused = &{ena, clk, rst_n, cout, 1'b0};

endmodule


// ----------------------------------
// HALF ADDER
// ----------------------------------

module halfadder (
    input  wire a,
    input  wire b,
    output wire s,
    output wire cout
);

    assign s    = a ^ b;
    assign cout = a & b;

endmodule


// ----------------------------------
// FULL ADDER
// ----------------------------------

module fulladder (
    input  wire cin,
    input  wire a,
    input  wire b,
    output wire s,
    output wire cout
);

    wire s_tmp;
    wire cout_tmp1;
    wire cout_tmp2;

    halfadder h0 (
        .a(a),
        .b(b),
        .s(s_tmp),
        .cout(cout_tmp1)
    );

    halfadder h1 (
        .a(s_tmp),
        .b(cin),
        .s(s),
        .cout(cout_tmp2)
    );

    assign cout = cout_tmp1 | cout_tmp2;

endmodule


// ----------------------------------
// 8-BIT RIPPLE CARRY ADDER
// ----------------------------------

module rca8 (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire cin,
    output wire [7:0] SUM,
    output wire cout
);

    wire [7:0] carry;

    fulladder fa0 (
        .cin(cin), .a(A[0]), .b(B[0]),
        .s(SUM[0]), .cout(carry[0])
    );

    fulladder fa1 (
        .cin(carry[0]), .a(A[1]), .b(B[1]),
        .s(SUM[1]), .cout(carry[1])
    );

    fulladder fa2 (
        .cin(carry[1]), .a(A[2]), .b(B[2]),
        .s(SUM[2]), .cout(carry[2])
    );

    fulladder fa3 (
        .cin(carry[2]), .a(A[3]), .b(B[3]),
        .s(SUM[3]), .cout(carry[3])
    );

    fulladder fa4 (
        .cin(carry[3]), .a(A[4]), .b(B[4]),
        .s(SUM[4]), .cout(carry[4])
    );

    fulladder fa5 (
        .cin(carry[4]), .a(A[5]), .b(B[5]),
        .s(SUM[5]), .cout(carry[5])
    );

    fulladder fa6 (
        .cin(carry[5]), .a(A[6]), .b(B[6]),
        .s(SUM[6]), .cout(carry[6])
    );

    fulladder fa7 (
        .cin(carry[6]), .a(A[7]), .b(B[7]),
        .s(SUM[7]), .cout(carry[7])
    );

    assign cout = carry[7];

endmodule

`default_nettype wire
