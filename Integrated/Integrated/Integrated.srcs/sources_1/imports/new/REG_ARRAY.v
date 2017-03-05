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
            REGISTER[i] = 32'd28;
        else
            REGISTER[i] = 32'd0;
        REG_STATE[i] = 1'b0;
        end
    end
    
//    always@(RS1_SEL or RS2_SEL)//posedge CLK)
//    begin
//        RS1_DATAOUT_L <= REGISTER[RS1_SEL];
//        RS2_DATAOUT_L <= REGISTER[RS2_SEL];
    
        
      /*
        
        
        // The main issue of reading from a register which is in the pipeline is mitigated here
        // REG_STATE high means the register is in the pipeline
        if(REG_STATE[RS1_SEL]==1'b1 || REG_STATE[RS2_SEL]==1'b1)
        begin
            if(RD_WB_VALID)                     //writing back is valid reading is not valid
                REGISTER[RD_WB] <= DATA_IN;    
            RS1_DATAOUT_L <=32'd0;
            RS2_DATAOUT_L <=32'd0;
            STALL_EN_L <= 1'b1;
            
        end
        else
        begin
        //writing back and reading when there is no reding register in pipeline
            if(RD_WB_VALID)                     //writing back
                REGISTER[RD_WB] <= DATA_IN;  
                                                //reading       
            RS1_DATAOUT_L <= REGISTER[RS1_SEL];
            RS2_DATAOUT_L <= REGISTER[RS2_SEL];
            STALL_EN_L <= 1'b0;
        end*/
   // end
   
    always@(*)
    begin
        RS1_DATAOUT_L = REGISTER[RS1_SEL];
        RS2_DATAOUT_L = REGISTER[RS2_SEL];
    end
    
    always@(posedge CLK)
    begin
        if(RD_WB_VALID_MEM3_WB)
        begin
            REGISTER[RD_WB_MEM3_WB]= DATA_IN;
//            REG_STATE[RD_WB_MEM3_WB] =1'b0;
        end
        

    end
    
    
//    always@(WB_VALID_ID or RD_WB_ID)
//    begin
//        if(WB_VALID_ID)
//            REG_STATE[RD_WB_ID] =1'b1;
//    end
    
           
    
    assign RS1_DATAOUT = RS1_DATAOUT_L;
    assign RS2_DATAOUT = RS2_DATAOUT_L;
endmodule
