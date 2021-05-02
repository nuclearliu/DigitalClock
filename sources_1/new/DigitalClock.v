`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/21 10:50:38
// Design Name: 
// Module Name: DigitalClock
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


module DigitalClock(
    input clk, nCLR, S1, S0, Set, Adj, up, down, left, right, Adjclock, clockenable, hourto12, toll, toll1,
    input [7:0] D,
    output reg [2:0] choose1,
    output [7:0] AN,
    output [6:0] digits,
    output DP, sound,
    output [15:0] LED
    );
    wire CP, CP1, w0, w1, w2, w3, CPa, c2, c500, c1000, alarm, bell, bell1;
    wire [1:0] CPct;
    wire [2:0] CPt;
    reg cht;
    reg [1:0] CPc;
    reg [2:0] S, Load, dir, CPs, choose;
    reg [3:0] code;
    wire [7:0] hour, minute, second, hourc, minutec, houroutput;
    reg  [7:0] hourdisplay, minutedisplay, seconddisplay;
    
    assign DP = 1;
    assign w0 = ~Adj || (Adj && ~choose[0]);
    assign w1 = ((second == 8'h59) && ~Adj) || (Adj && ~choose[1]);
    assign w2 = (((second == 8'h59) && (minute == 8'h59)) && ~Adj) || (Adj && ~choose[2]);
    assign sound = ((bell || bell1 || alarm) && !Adj && !Adjclock && nCLR);
    divider #(50000000) div0(clk, nCLR, CP);
//    divider #(138889) div1(clk, nCLR, CP1);
    divider #(10000000) div2(clk, nCLR, CPa);
    divider #(100000) div3(clk, nCLR, c500);
    divider #(50000) div4(clk, nCLR, c1000);
//    divider #(25000000) div5(clk, nCLR, c2);
    
//    decoder3_8 dec(S, AN, 1'b0);
    
    always @ (up, down, Adj)
        if (~Adj && ~Adjclock)
            dir <= 3'b111;
        else begin
            if (up) begin
                dir <= 3'b111;
            end
            else if (down)
                dir <= choose;
        end
    assign CPt[0] = (Adj && ~choose[0]) ? (up||down) && CPa : CP;
    assign CPt[1] = (Adj && ~choose[1]) ? (up||down) && CPa : CP;
    assign CPt[2] = (Adj && ~choose[2]) ? (up||down) && CPa : CP;
    assign CPct[0] = (Adjclock && ~choose[1]) ? (up||down) && CPa : 1'b0;
    assign CPct[1] = (Adjclock && ~choose[2]) ? (up||down) && CPa : 1'b0;
    
    always @ (posedge clk) begin
        CPs <= CPt;
        CPc <= CPct;
        cht <= left || right;
        choose1[0] = ~choose[0];
        choose1[1] = ~choose[1];
        choose1[2] = ~choose[2];
    end
    
    counter60 cntsecond(Load[0], w0, dir[0], CPs[0], nCLR, D , second);
    counter60 cntminute(Load[1], w1, dir[1], CPs[1], nCLR, D , minute);
    counter24 cnthour(Load[2], w2, dir[2], CPs[2], nCLR, D , hour);
    
    counter60 cntminute1(1'b0, ~choose[1], dir[1], CPc[0], nCLR, D , minutec);
    counter24 cnthour1(1'b0, ~choose[2], dir[2], CPc[1], nCLR, D , hourc);
    
//    assign LED[11] = toll;
//    assign LED[12] = ({minute[7:0], second[7:0]} == 16'h5958);
    assign LED[13] = toll1;
    assign LED[14] = toll;
    assign LED[15] = clockenable;
    tollthebell ttb(toll, clk, c500, c1000, {minute[7:0], second[7:0]}, bell); //电台报时
    tollthebell1 ttb1(toll1, CP, c500, {hour[7:0], minute[7:0], second[7:0]}, bell1); //到几点响几下
    alarmclock ac(clockenable, c1000, {hour[7:0], minute[7:0], second[7:0]}, {hourc[7:0], minutec[7:0]}, alarm);
    hourto12 converthour(hourto12, hour, houroutput);
//    code2digits c2d(code, digits);
    
    always @ (Adjclock) begin
        if (~Adjclock) 
            {hourdisplay, minutedisplay, seconddisplay} <= {houroutput, minute, second};
        else
            {hourdisplay, minutedisplay, seconddisplay} <= {hourc, minutec, 8'h00};
    end
    
    always @ (posedge cht, negedge nCLR)begin
        if (~nCLR ||( ~Adj && ~Adjclock))
            choose <= 3'b110;
        else if ((choose != 3'b110) && (choose != 3'b101) && (choose != 3'b011))
            choose <= 3'b110;
        else begin
            if (left)
                choose <= {choose[1:0], choose[2]};
            if (right)
                choose <= {choose[0], choose[2:1]};
        end
    end
    always @ (S1, S0, Set)
    if (~Set)
        Load <= 3'b000;
    else
    case({S1, S0})
      2'b00: Load <= 3'b001; 
      2'b01: Load <= 3'b010; 
      2'b10: Load <= 3'b100; 
      2'b11: Load <= 3'b100; 
    endcase
//    always @ (posedge CP1, negedge nCLR)
//        if (~nCLR)
//            S <= 3'b000;
//        else if (S == 3'b101)
//            S <= 3'b000;
//        else
//            S = S + 1'b1;
//    always @ (*)
//        case(S)
//            3'b000: code = seconddisplay[3:0];
//            3'b001: code = seconddisplay[7:4];
//            3'b010: code = minutedisplay[3:0];
//            3'b011: code = minutedisplay[7:4];
//            3'b100: code = hourdisplay[3:0];
//            3'b101: code = hourdisplay[7:4];
//        endcase
    display Display({hourdisplay, minutedisplay, seconddisplay}, nCLR, digits, AN);
endmodule