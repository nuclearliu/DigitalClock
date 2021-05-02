`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 15:44:58
// Design Name: 
// Module Name: display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display(
    input [23:0] currentTime,
    input nCLR,
    output [6:0] digits,
    output [5:0] AN
    );
    reg [3:0] code;
    reg [2:0] S;
    divider #(138889) div1(clk, nCLR, CP1);
    decoder3_8 dec(S, AN, 1'b0);
    always @ (posedge CP1, negedge nCLR)
        if (~nCLR)
            S <= 3'b000;
        else if (S == 3'b101)
            S <= 3'b000;
        else
            S = S + 1'b1;
    always @ (*)
        case(S)
            3'b000: code = currentTime[3:0];
            3'b001: code = currentTime[7:4];
            3'b010: code = currentTime[11:8];
            3'b011: code = currentTime[15:12];
            3'b100: code = currentTime[19:16];
            3'b101: code = currentTime[23:20];
        endcase
    code2digits c2d(code, digits);
endmodule
