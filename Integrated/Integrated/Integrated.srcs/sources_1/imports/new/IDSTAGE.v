`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 12/13/2016 09:20:33 AM
// Design Name: 
// Module Name: IDSTAGE
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


module IDSTAGE(
    INS_IN,
    CLK,
    RD_OUT,
    IMM_OUT,
    RS1_SEL,
    RS2_SEL,
    RS1_DATAOUT,
    RS2_DATAOUT,
    OPCODE_OUT,
    FUNCT_OUT,
    WB_VALID_OUT,
    
    WB_DATA_IN,
    WB_VALID_INPUT,
    RD_WB,
    
    ALU_CNT,     
    COMP_CNT,
    MUX1_CNT,
    MUX2_CNT,
    MUX3_CNT 
    
    );
    parameter REG_SIZE = 32;
    //ID stage 
    input [REG_SIZE-1:0] INS_IN;
    input CLK;  //for register 
    output [4:0] RD_OUT;
    output [REG_SIZE-1:0] IMM_OUT;
    output [4:0] RS1_SEL;
    output [4:0] RS2_SEL;
    output [REG_SIZE-1:0] RS1_DATAOUT;
    output [REG_SIZE-1:0] RS2_DATAOUT;
    output [6:0] OPCODE_OUT;
    output [9:0] FUNCT_OUT;
    output WB_VALID_OUT;
    
    //EX Stage controle signals
    output [3:0] ALU_CNT;     
    output [1:0] COMP_CNT;
    output MUX1_CNT;
    output MUX2_CNT;
    output MUX3_CNT; 
    
    //WB stage variables
    
    input [REG_SIZE-1:0] WB_DATA_IN;
    input WB_VALID_INPUT;
    input [4:0] RD_WB;
         
    wire [2:0] EXT_CNT;
    reg WB_VALID_OUT_L;
    wire WB_VALID_OUT_CNT;
    
    
    REG_ARRAY REG_ARRAY(
        .DATA_IN(WB_DATA_IN),
        .RS1_SEL(INS_IN[19:15]),
        .RS2_SEL(INS_IN[24:20]),
        .CLK(CLK),
        .RD_WB_VALID_MEM3_WB(WB_VALID_INPUT),
        .RD_WB_MEM3_WB(RD_WB),         //to update register state       
        .WB_VALID_ID(WB_VALID_OUT_L),
        .RD_WB_ID(RD_OUT),  
        .RS1_DATAOUT(RS1_DATAOUT),
        .RS2_DATAOUT(RS2_DATAOUT)
       // .STALL_EN()
        );
        
    ImmEXTENDER_32bit IMM_EXT(
        .EXT_CNT(EXT_CNT),
        .IN_DATA(INS_IN[31:7]), //ins[31:7]
        .OUT_DATA(IMM_OUT)
        );
        
    //partial decoding in to opcode and functional bits
    //wired are defined for clarity
    
    wire [6:0] OPCODE;
    wire [9:0] FUNCT;
    
    
    
   
    
    
    assign OPCODE = INS_IN[6:0];
    assign OPCODE_OUT = INS_IN[6:0];
    assign FUNCT = {INS_IN[31:25],INS_IN[14:12]};
    assign FUNCT_OUT = {INS_IN[31:25],INS_IN[14:12]};
    assign RD_OUT = INS_IN[11:7];
    assign RS1_SEL = INS_IN[19:15];
    assign RS2_SEL = INS_IN[24:20];
    assign WB_VALID_OUT = WB_VALID_OUT_L;
    
    //condition for not writing back to x0 register
    always@(*)
    begin
        if(INS_IN[11:7]==5'd0)
            WB_VALID_OUT_L = 1'b0;
        else
            WB_VALID_OUT_L = WB_VALID_OUT_CNT;
    end
    
    
    
    CONTROLER_IDSTAGE CONTROLLER(
        .OPCODE(OPCODE),
        .FUNCT(FUNCT), 
        //.STALL_STATE,
        .EXT_CNT(EXT_CNT),
        .WB_VALID_OUT(WB_VALID_OUT_CNT)
        );
     
    
    CONTROLER_EXSTAGE EX_CONTROLER(
        .OPCODE(INS_IN[6:0]),
        .FUNCT({INS_IN[31:25],INS_IN[14:12]}), 
        .ALU_CNT(ALU_CNT),
        .COMP_CNT(COMP_CNT),
        .MUX1_CNT(MUX1_CNT),
        .MUX2_CNT(MUX2_CNT),
        .MUX3_CNT(MUX3_CNT)
    );
endmodule
