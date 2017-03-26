`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 02/06/2017 09:22:40 AM
// Design Name: 
// Module Name: FEEDBACK_CONTROLE
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


module FEEDBACK_CONTROLE(
    input [4:0] RS1_SEL,
    input [4:0] RS2_SEL,
    input   EN,
    input   STALL_ENABLE,
    input RD_VALID,
    input [4:0] RD_OUT,
    input CLK,
    input [31:0] ALU_OUT_EX_MEM1_WIRE,
    input [31:0] ALU_OUT_EX_MEM1,
    input [31:0] ALU_OUT_MEM1_MEM2,
    input [31:0] ALU_OUT_MEM2_MEM3,
    input [31:0] ALU_OUT_MEM3_WB,
    output [31:0]UPDATED_RS1_VALUE,
    output [31:0]UPDATED_RS2_VALUE,
    output MUX_RS1_SEL,
    output MUX_RS2_SEL,
    output STALL_1CYCLE
    );
    
    reg [31:0]UPDATED_RS1_VALUE_L;
    reg [31:0]UPDATED_RS2_VALUE_L;
    reg MUX_RS1_SEL_L; 
    reg MUX_RS2_SEL_L; 
    
    reg [4:0] RD_SHIFTREG [4:0];
    reg       RD_WB_VALID_SHIFTREG [4:0];
    reg       STALL_1CYCLE_L;
    reg FLAG;
    initial
    begin
        MUX_RS1_SEL_L = 1'b0;
        MUX_RS2_SEL_L = 1'b0;
        FLAG = 1'b0;
    end
    always@(posedge CLK)
    begin
      if(EN)
      begin
            if(STALL_ENABLE)
            begin
            
                
                RD_SHIFTREG[0] <= RD_OUT;
                RD_SHIFTREG[1] <= RD_SHIFTREG[0];
                RD_SHIFTREG[2] <= RD_SHIFTREG[1];
                RD_SHIFTREG[3] <= RD_SHIFTREG[2];
                RD_SHIFTREG[4] <= RD_SHIFTREG[3];
                
                RD_WB_VALID_SHIFTREG[0] <= RD_VALID;
                RD_WB_VALID_SHIFTREG[1] <= RD_WB_VALID_SHIFTREG[0];
                RD_WB_VALID_SHIFTREG[2] <= RD_WB_VALID_SHIFTREG[1];
                RD_WB_VALID_SHIFTREG[3] <= RD_WB_VALID_SHIFTREG[2];
                RD_WB_VALID_SHIFTREG[4] <= RD_WB_VALID_SHIFTREG[3];
            end
            else
            begin
            
                
             //   RD_SHIFTREG[0] <= 5'd0;
                RD_SHIFTREG[1] <= 5'd0;//RD_SHIFTREG[0];
                RD_SHIFTREG[2] <= RD_SHIFTREG[1];
                RD_SHIFTREG[3] <= RD_SHIFTREG[2];
                RD_SHIFTREG[4] <= RD_SHIFTREG[3];
                
        //        RD_WB_VALID_SHIFTREG[0] <= 1'b0;
                RD_WB_VALID_SHIFTREG[1] <= 1'b0;//RD_WB_VALID_SHIFTREG[0];
                RD_WB_VALID_SHIFTREG[2] <= RD_WB_VALID_SHIFTREG[1];
                RD_WB_VALID_SHIFTREG[3] <= RD_WB_VALID_SHIFTREG[2];
                RD_WB_VALID_SHIFTREG[4] <= RD_WB_VALID_SHIFTREG[3];
            end
       end
    end
    always@(*)
    begin    
        
//        if(FLAG == 1'b0)
//        begin
            if(RS1_SEL == RD_SHIFTREG[0] && RD_WB_VALID_SHIFTREG[0] == 1'b1)
            begin
                UPDATED_RS1_VALUE_L = ALU_OUT_EX_MEM1_WIRE;
                MUX_RS1_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b1;
            end
            else 
            if(RS1_SEL == RD_SHIFTREG[1] && RD_WB_VALID_SHIFTREG[1] == 1'b1)
            begin
                UPDATED_RS1_VALUE_L = ALU_OUT_EX_MEM1;
                MUX_RS1_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS1_SEL == RD_SHIFTREG[2] && RD_WB_VALID_SHIFTREG[2] == 1'b1)
            begin
                UPDATED_RS1_VALUE_L = ALU_OUT_MEM1_MEM2;
                MUX_RS1_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS1_SEL == RD_SHIFTREG[3] && RD_WB_VALID_SHIFTREG[3] == 1'b1)
            begin
                UPDATED_RS1_VALUE_L = ALU_OUT_MEM2_MEM3;
                MUX_RS1_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS1_SEL == RD_SHIFTREG[4] && RD_WB_VALID_SHIFTREG[4] == 1'b1)
            begin
                UPDATED_RS1_VALUE_L = ALU_OUT_MEM3_WB;
                MUX_RS1_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else
            begin
                UPDATED_RS1_VALUE_L = 32'd0;
                MUX_RS1_SEL_L = 1'b0;
                STALL_1CYCLE_L = 1'b0;
            end
            
          
            if(RS2_SEL == RD_SHIFTREG[0] && RD_WB_VALID_SHIFTREG[0] == 1'b1)
            begin
                UPDATED_RS2_VALUE_L = ALU_OUT_EX_MEM1_WIRE;
                MUX_RS2_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b1;
            end
            else 
            if(RS2_SEL == RD_SHIFTREG[1] && RD_WB_VALID_SHIFTREG[1] == 1'b1)
            begin
                UPDATED_RS2_VALUE_L = ALU_OUT_EX_MEM1;
                MUX_RS2_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS2_SEL == RD_SHIFTREG[2] && RD_WB_VALID_SHIFTREG[2] == 1'b1)
            begin
                UPDATED_RS2_VALUE_L = ALU_OUT_MEM1_MEM2;
                MUX_RS2_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS2_SEL == RD_SHIFTREG[3] && RD_WB_VALID_SHIFTREG[3] == 1'b1)
            begin
                UPDATED_RS2_VALUE_L = ALU_OUT_MEM2_MEM3;
                MUX_RS2_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end
            else if(RS2_SEL == RD_SHIFTREG[4] && RD_WB_VALID_SHIFTREG[4] == 1'b1)
            begin
                UPDATED_RS2_VALUE_L = ALU_OUT_MEM3_WB;
                MUX_RS2_SEL_L = 1'b1;
                STALL_1CYCLE_L = 1'b0;
            end        
            else
            begin
                UPDATED_RS2_VALUE_L = 32'd0;
                MUX_RS2_SEL_L = 1'b0;
                STALL_1CYCLE_L = 1'b0;
            end
//          end
//          else
//          begin
//                UPDATED_RS2_VALUE_L = 32'd0;
//                MUX_RS2_SEL_L = 1'b0;
                
//                UPDATED_RS1_VALUE_L = 32'd0;
//                MUX_RS1_SEL_L = 1'b0;
//          end
          
          
//        if(RD_IN_PIPELINE)
//        begin
//            MUX_SEL_L <=1'b1;
//            if(RD_OUT == RD_SHIFTREG[0])
//                UPDATED_REG_VALUE_L <= ALU_OUT_EX_MEM1;
//            else if(RD_OUT == RD_SHIFTREG[1])
//                UPDATED_REG_VALUE_L <= ALU_OUT_MEM1_MEM2;
//            else if(RD_OUT == RD_SHIFTREG[2])
//                UPDATED_REG_VALUE_L <= ALU_OUT_MEM2_MEM3;
//            else if(RD_OUT == RD_SHIFTREG[3])
//                UPDATED_REG_VALUE_L <= ALU_OUT_MEM3_WB;
//            else
//                UPDATED_REG_VALUE_L <= 32'd0;
//        end
//        else
//        begin
//            UPDATED_REG_VALUE_L <= 32'd0;
//            MUX_SEL_L <= 1'b0;
//        end
    end
    
    assign UPDATED_RS1_VALUE = UPDATED_RS1_VALUE_L;
    assign UPDATED_RS2_VALUE = UPDATED_RS2_VALUE_L;
    assign MUX_RS1_SEL = MUX_RS1_SEL_L && STALL_ENABLE;
    assign MUX_RS2_SEL = MUX_RS2_SEL_L && STALL_ENABLE;
    assign STALL_1CYCLE = STALL_1CYCLE_L;
endmodule
