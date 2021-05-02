`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:11:49
// Design Name: 
// Module Name: tollthebell1
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


module tollthebell1(input toll, CP, c500, input [23:0] hms, output bell);
    wire [7:0] hour12;
    hourto12 converthour(1'b1, hms[23:16], hour12);
    assign bell = (toll && CP && hms[15:8] == 8'h00 && hms[7:0] < hour12) ? c500 : 1'b0;
endmodule
