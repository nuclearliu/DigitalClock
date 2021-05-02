`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:10:23
// Design Name: 
// Module Name: hourto12
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


module hourto12(input hourto12, input [7:0] hour, output reg [7:0] houroutput);
    always @ (*) 
        if (~hourto12)
            houroutput <=  hour;
        else
            case (hour)
                8'h00: houroutput <= 8'h12;
                8'h13: houroutput <= 8'h01;
                8'h14: houroutput <= 8'h02;
                8'h15: houroutput <= 8'h03;
                8'h16: houroutput <= 8'h04;
                8'h17: houroutput <= 8'h05;
                8'h18: houroutput <= 8'h06;
                8'h19: houroutput <= 8'h07;
                8'h20: houroutput <= 8'h08;
                8'h21: houroutput <= 8'h09;
                8'h22: houroutput <= 8'h10;
                8'h23: houroutput <= 8'h11;
                default: houroutput <= hour;
            endcase
endmodule