`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:12:38
// Design Name: 
// Module Name: counter24
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


module counter24(input Load, En, dir, CP, nCLR, input [7:0] D ,output reg [7:0] Q);
always @ (posedge CP, negedge nCLR) begin
    if (~nCLR)
        Q <= 8'b00000000;
    else if (Load)
        Q <= D;
    else if (~En)
        Q <= Q;
    else if (dir) begin
        if ((Q[7:4] > 2)||(Q[3:0] > 9)||((Q[7:4] == 2)&&(Q[3:0] >= 3)))
            Q <= 8'b00000000;
        else if ((Q[7:4] == 2)&&(Q[3:0] < 3))
            Q <= Q + 1;
        else if (Q[3:0] == 9) begin
            Q[7:4] <= Q[7:4] + 1;
            Q[3:0] <= 4'b0000;
            end
        else
            Q <= Q + 1;
    end
    else if (~dir) begin
        if ((Q[7:4] > 2)||(Q[3:0] > 9)||((Q[7:4] == 2)&&(Q[3:0] > 3)))
            Q <= 8'b00000000;
        else if ((Q[7:4] < 3)&&(Q[3:0] > 0))
            Q <= Q - 1;
        else if ((Q[7:4] == 0)&&(Q[3:0] == 0))begin 
            Q[7:4] <= 8'h2;
            Q[3:0] <= 8'h3;
        end
        else if (Q[3:0] == 0) begin
            Q[7:4] <= Q[7:4] - 1;
            Q[3:0] <= 4'b1001;
            end
    end
    else
        Q <= Q + 1;
end
endmodule