`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:13:53
// Design Name: 
// Module Name: decoder3_8
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


module decoder3_8(input [2:0] a, output reg [7:0] y, input nEn);
always @(*) begin
  if (nEn)
    y <= 8'b11111111;
  else begin
    case(a)
      3'b000: y <= 8'b11111110; 
      3'b001: y <= 8'b11111101; 
      3'b010: y <= 8'b11111011; 
      3'b011: y <= 8'b11110111; 
      3'b100: y <= 8'b11101111; 
      3'b101: y <= 8'b11011111; 
      3'b110: y <= 8'b10111111; 
      3'b111: y <= 8'b01111111; 
    endcase
  end
end
endmodule
