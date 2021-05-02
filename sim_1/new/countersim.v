`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 15:00:17
// Design Name: 
// Module Name: countersim
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


module countersim(
    output [7:0] hour,
    output [7:0] minute
    );
    reg nCLR, CP, dir;
    counter60 U0(1'b0, 1'b1, dir, CP, nCLR, 8'b0, minute);
    counter24 U1(1'b0, 1'b1, dir, CP, nCLR, 8'b0, hour);
    
    parameter PERIOD = 10;

   always begin
      CP = 1'b0;
      #(PERIOD/2) CP = 1'b1;
      #(PERIOD/2);
   end
   
   initial begin
   nCLR = 0;
   dir = 1;
   #10
   nCLR = 1;
   #1000
   dir = 0;
   end
endmodule
