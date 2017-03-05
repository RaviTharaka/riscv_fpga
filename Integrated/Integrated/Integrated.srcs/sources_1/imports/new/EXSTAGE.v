`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2016 09:46:32 PM
// Design Name: 
// Module Name: EXSTAGE
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


module EXSTAGE(
    //input [4:0] RD, 
    input [31:0] PC_IN,
    input [31:0] RS1_IN,
    input [31:0] RS2_IN,
    input [31:0] IMM_IN,
    input [6:0] OPCODE_IN,
    input [14:0] FUNCT_IN,
    input [3:0] ALU_CNT_IN,     
    input [1:0] COMP_CNT_IN,
    input MUX1_CNT_IN,
    input MUX2_CNT_IN,
    input MUX3_CNT_IN,
    output [31:0] ALU_OUT,
    output COMP_OUT
   
    );
    wire [31:0] A_BUS;
    wire [31:0] B_BUS;
    wire [31:0] COMP2_BUS;
    wire [31:0] ROM_DATA;
//    wire MUX1_CNT;
//    wire MUX2_CNT;
//    wire MUX3_CNT;
//    wire [3:0] ALU_CNT;
//    wire [1:0] COMP_CNT;
        
//    CONTROLER_EXSTAGE CONTROLER(
//        .OPCODE(OPCODE_IN),
//        .FUNCT(FUNCT_IN),
//        .ALU_CNT(ALU_CNT),
//        .COMP_CNT(COMP_CNT),
//        .MUX1_CNT(MUX1_CNT),
//        .MUX2_CNT(MUX2_CNT),
//        .MUX3_CNT(MUX3_CNT));    
        
    MUX_2to1_32bit M1(
        .IN1(RS2_IN),
        .IN2(IMM_IN),
        .OP(A_BUS),
        .CONTROL(MUX1_CNT_IN));
    
    MUX_2to1_32bit M2(
        .IN1(RS1_IN),
        .IN2(PC_IN),
        .OP(B_BUS),
        .CONTROL(MUX2_CNT_IN));
     
     MUX_2to1_32bit M3(
        .IN2(RS2_IN),
        .IN1(IMM_IN),
        .OP(COMP2_BUS),
        .CONTROL(MUX3_CNT_IN));
    
  //  MUX_4to1_32bit M2(.IN1(IMM_IN),.IN2(RS2_IN),.IN3(PC_IN),.IN4(ROM_DATA),.OP(B_BUS),.CONTROL(MUX2_CNT));
        
     ALU ALU(                    // Output is latched
        .A(A_BUS),
        .B(B_BUS),
        .ALU_CONTROL(ALU_CNT_IN),
        .ALU_OUTPUT(ALU_OUT));
    
    COMPARATOR COMP(            // Output is latched
        .COMP1(RS1_IN),
        .COMP2(COMP2_BUS),
        .COMP_CONTROL(COMP_CNT_IN),
        .COMP_OUT(COMP_OUT));
endmodule
