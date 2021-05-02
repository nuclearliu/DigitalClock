`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:13:15
// Design Name: 
// Module Name: counter60
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


module counter60(input Load, En, dir, CP, nCLR, input [7:0] D ,output [7:0] Q);
wire w1, w2;
assign w1 = (((Q[3:0] == 4'h9) && dir && En) || ((Q[3:0] == 4'h0) && ~dir && En));
counter10 cnt10(Load, En, dir, CP, nCLR, D[3:0] , Q[3:0]);
counter6 cnt6(Load, w1, dir, CP, nCLR, D[7:4] , Q[7:4]);
endmodule