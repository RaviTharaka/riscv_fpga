`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 09/09/2016 07:55:12 PM
// Design Name: 
// Module Name: 32bitEXTENDER
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


module ImmEXTENDER_32bit(
    input [2:0] EXT_CNT,
    input [24:0] IN_DATA, //ins[31:7]
    output [31:0] OUT_DATA
    );
    
    reg [31:0] OUT_DATA_L;
    
    always@(EXT_CNT or IN_DATA)
    begin
        case(EXT_CNT)
            3'b000:                 //I typre
            begin
                if(IN_DATA[24] == 1'b1)
                    OUT_DATA_L = {20'b11111111111111111111,IN_DATA[24:13]};
                else 
                    OUT_DATA_L = {20'd0,IN_DATA[24:13]};
            end
            3'b001:                 //S type
            begin
                if(IN_DATA[24]==1'b1)
                    OUT_DATA_L = {20'b11111111111111111111,IN_DATA[24:18],IN_DATA[4:0]};
                else
                    OUT_DATA_L = {20'd0,IN_DATA[24:18],IN_DATA[4:0]};
            end
            3'b010:                 //SB type
            begin
                if(IN_DATA[24]==1'b1)
                    OUT_DATA_L = {20'b11111111111111111111,IN_DATA[0],IN_DATA[23:18],IN_DATA[4:1],1'b0};
                else
                    OUT_DATA_L = {20'd0,IN_DATA[0],IN_DATA[23:18],IN_DATA[4:1],1'b0};
            end
            3'b011:                //U type
                    OUT_DATA_L = {IN_DATA[24:5],12'd0};
            3'b100:                //UJ type
            begin
                if(IN_DATA[24]==1'b1)
                    OUT_DATA_L = {12'b111111111111,IN_DATA[12:5],IN_DATA[13],IN_DATA[23:18],IN_DATA[17:14],1'b0};
                else
                    OUT_DATA_L = {12'd0,IN_DATA[12:5],IN_DATA[13],IN_DATA[23:18],IN_DATA[17:14],1'b0};
            end
            3'b101:
            begin
                OUT_DATA_L = {20'd0,IN_DATA[24:13]};
            end
            default:
                    OUT_DATA_L =32'd0;
        endcase
    end
    
    assign OUT_DATA = OUT_DATA_L;
endmodule
