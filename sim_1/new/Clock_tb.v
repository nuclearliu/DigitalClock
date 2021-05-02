`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/21 14:30:24
// Design Name: 
// Module Name: Clock_tb
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


module Clock_tb(

    );
    reg CP, Load, nCLR;
    reg [7:0] D;
    wire [7:0] Q0, Q1;
    counter60 cnt60(Load, 1'b1, CP, nCLR, D , Q0);
    counter24 cnt24(Load, En, CP, nCLR, D , Q1);
    
    initial begin
        CP = 0;
        nCLR = 1;
        D = 8'b00100000;
        #0.5 nCLR = 0;
        #0.5 nCLR = 1;
        #20 Load = 1;
        #1 Load = 0;
    end
    always begin
        #1 CP = ~CP;
    end
endmodule
