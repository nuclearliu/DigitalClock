`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:15:15
// Design Name: 
// Module Name: counter6
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


module counter6(input Load, En, dir, CP, nCLR, input [3:0] D ,output reg[3:0] Q);
integer direction;
always @ (posedge CP, negedge nCLR) begin
    if (~nCLR)
        Q <= 4'b0000;
    else begin
        if (dir)
            direction = 1;
        else
            direction = -1;
        if (Load)
            Q <= D;
        else if (~En)
            Q <= Q;
        else if ((Q == 4'b0000) && ~dir)
            Q <= 4'b0101;
        else if ((Q == 4'b0101) && dir)
            Q <= 4'b0000;
        else
            Q <= Q + direction;
    end
end
endmodule