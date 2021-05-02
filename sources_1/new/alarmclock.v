`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 13:08:12
// Design Name: 
// Module Name: alarmclock
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


module alarmclock(input clockenable, cp, input [23:0] hms, input [15:0] hmclock, output reg alarm);
    always @ (*)
        if (!clockenable)
            alarm = 1'b0;
        else
            if ((hms[23:8] == hmclock[15:0]) && hms[0] == 1'b0)
                alarm <= cp;
            else
                alarm <= 1'b0;
endmodule