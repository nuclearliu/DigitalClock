`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:11:08
// Design Name: 
// Module Name: tollthebell
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


module tollthebell(input toll, clk, c500, c1000, input [15:0] currenttime, output reg bell);
    always @ (posedge clk)
        if (toll)
            case (currenttime)
                16'h5952: bell <= c500;
                16'h5954: bell <= c500;
                16'h5956: bell <= c500;
                16'h5958: bell <= c500;
                16'h0000: bell <= c1000;
            endcase
endmodule
