`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Sneviratne
// 
// Create Date: 09/09/2016 08:56:17 PM
// Design Name: 
// Module Name: REG_ARRAY
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


module REG_ARRAY(
    input [31:0] DATA_IN,
    input [4:0] RS1_SEL,
    input [4:0] RS2_SEL,
    input CLK,
    input RD_WB_VALID_MEM3_WB,
    input [4:0] RD_WB_MEM3_WB,         // register which is written back to  
    input WB_VALID_ID,
    input [4:0] RD_WB_ID,    
    output [31:0] RS1_DATAOUT,
    output [31:0] RS2_DATAOUT,
    output STALL_EN
    );
    
    reg [31:0] REGISTER [0:31];
    reg REG_STATE [0:31];       // to check wether the register write back is still in pipeline
    reg [31:0] RS1_DATAOUT_L;
    reg [31:0] RS2_DATAOUT_L;
    reg STALL_EN_L;
    
    integer i;
    initial
    begin
        for(i=0;i<32;i=i+1)
        begin
        if(i==2)
            REGISTER[i] = 32'd1024;
        else
            REGISTER[i] = 32'd0;
        REG_STATE[i] = 1'b0;
        end
    end
 
   
    always@(*)
    begin
        RS1_DATAOUT_L = REGISTER[RS1_SEL];
        RS2_DATAOUT_L = REGISTER[RS2_SEL];
    end
    
    always@(posedge CLK)
    begin
        if(RD_WB_VALID_MEM3_WB)
        begin
            REGISTER[RD_WB_MEM3_WB] <= DATA_IN;
        end
        

    end
    
    assign RS1_DATAOUT = RS1_DATAOUT_L;
    assign RS2_DATAOUT = RS2_DATAOUT_L;
endmodule
