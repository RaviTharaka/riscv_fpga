`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 08/12/2016 10:09:38 AM
// Design Name: 
// Module Name: PIPELINE
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


module PIPELINE #(
    // Fixed parameters
        localparam ADDR_WIDTH                   = 32,
        localparam DATA_WIDTH                   = 32,
        localparam FUNCBIT_WIDTH                = 10,        
        localparam OPCODE_WIDTH                 =  7,
        localparam REGARRAY_ADDR_WIDTH          =  5,
        localparam ALU_CNT_WIDTH                =  4,
        localparam COMP_CNT_WIDTH               =  2
        
        
     )
    (
    
    //////////////////////////////////
    //  INSTRUCTION CACHE SIGNALS   //
    //////////////////////////////////
    
    //Standard inputs
    input                                           CLK,
    
    //Status signals between processor and cache
    input                                           CACHE_READY,    
    output                                          PIPELINE_STALL,
    
    //Input from cache
    input               [ADDR_WIDTH - 1 : 0]        PC_IF_ID, 
    input               [DATA_WIDTH - 1 : 0]        INS_IF_ID,
    
    //Output to cache
    output                                          BRANCH_TAKEN,
    output              [ADDR_WIDTH - 1 : 0]        BRANCH_ADDRESS,
    
    //////////////////////////////
    //    DATA CACHE SIGNALS    //
    //////////////////////////////
    
    output     reg     [    2      - 1 : 0]        CONTROL_DATA_CACHE,              // CONTROL_FROM_PROC = {00(idle), 01(read), 10(write), 11(flush address from cache)}
    output     reg     [ADDR_WIDTH - 1 : 0]        ADDR_TO_DATA_CACHE,
    output     reg     [DATA_WIDTH - 1 : 0]        DATA_TO_DATA_CACHE,
    input              [DATA_WIDTH - 1 : 0]        DATA_TO_PROC,
          
    input                                          CACHE_READY_DATA,
           
    
    //Temporary outputs
    output              [DATA_WIDTH - 1 : 0]        ALU,
    output                                          COMPAR
    );
    /////////////////////////////////
    //INSTRUCTION DECODE(ID) stage
    ////////////////////////////////
    
    ///Outputs
    
    //Data 
    wire                [DATA_WIDTH - 1          : 0]       RS1_ID_EX_WIRE;
    wire                [DATA_WIDTH - 1          : 0]       RS2_ID_EX_WIRE;
    wire                [DATA_WIDTH - 1          : 0]       IMM_ID_EX_WIRE;
    
    //Pipeline controle signals
    wire                [OPCODE_WIDTH - 1        : 0]       OPCODE_ID_EX_WIRE;
    wire                [FUNCBIT_WIDTH - 1       : 0]       FUNCT_ID_EX_WIRE;    
    wire                [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_ID_EX_WIRE;
    wire                [REGARRAY_ADDR_WIDTH - 1 : 0]       RS1_SEL_WIRE;
    wire                [REGARRAY_ADDR_WIDTH - 1 : 0]       RS2_SEL_WIRE;
    wire                                                    WB_VALID_ID_EX_WIRE;
    
    //EX stage controle signals
    //NOTE: EX stage control signals are generated in ID stage to minimise critical path
    wire                [ALU_CNT_WIDTH       - 1 : 0]       ALU_CNT_WIRE;     
    wire                [COMP_CNT_WIDTH      - 1 : 0]       COMP_CNT_WIRE;
    wire                                                    MUX1_CNT_WIRE;
    wire                                                    MUX2_CNT_WIRE;
    wire                                                    MUX3_CNT_WIRE; 
    
    ///////////////////////////////
    //EXECUTION STAGE(EX) stage
    ///////////////////////////////
    
    
    //Input buffers
    reg                 [ADDR_WIDTH          - 1 : 0]       PC_ID_EX; 
    reg                 [DATA_WIDTH - 1          : 0]       RS1_ID_EX;
    reg                 [DATA_WIDTH - 1          : 0]       RS2_ID_EX;
    reg                 [DATA_WIDTH - 1          : 0]       IMM_ID_EX;
    
    //EX stage controle signal input buffers
    reg                 [ALU_CNT_WIDTH       - 1 : 0]       ALU_CNT_ID_EX;     
    reg                 [COMP_CNT_WIDTH      - 1 : 0]       COMP_CNT_ID_EX;
    reg                                                     MUX1_CNT_ID_EX;
    reg                                                     MUX2_CNT_ID_EX;
    reg                                                     MUX3_CNT_ID_EX; 
    
    //EX stage buffers
    reg                 [OPCODE_WIDTH - 1        : 0]       OPCODE_ID_EX;
    reg                 [FUNCBIT_WIDTH - 1       : 0]       FUNCT_ID_EX;
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_ID_EX;
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RS1_SEL_ID_EX;
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RS2_SEL_ID_EX;
    reg                                                     WB_VALID_ID_EX;
      
    
    //Outputs
    wire                [DATA_WIDTH - 1          : 0]       ALU_OUT_WIRE;
    wire                                                    COMP_OUT_WIRE;
    
    ///////////////////////////////
    //DATA MEMORY 1(MEM1) stage
    ///////////////////////////////
    
    //Input buffers
    reg                 [DATA_WIDTH - 1          : 0]       RS2_EX_MEM1;
    reg                 [DATA_WIDTH - 1          : 0]       ALU_OUT_EX_MEM1;
    reg                                                     COMP_OUT_EX_MEM1;
    reg                 [OPCODE_WIDTH - 1        : 0]       OPCODE_EX_MEM1;     
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_EX_MEM1;
    reg                                                     WB_VALID_EX_MEM1;
    
    ///////////////////////////////
    //DATA MEMORY 2(MEM2) stage
    ///////////////////////////////
    
    //Input Buffers
    reg                 [DATA_WIDTH - 1          : 0]       ALU_OUT_MEM1_MEM2; 
    reg                                                     COMP_OUT_MEM1_MEM2;
    reg                 [OPCODE_WIDTH - 1        : 0]       OPCODE_MEM1_MEM2;   
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_MEM1_MEM2;
    reg                                                     WB_VALID_MEM1_MEM2;
  
    ///////////////////////////////
    //DATA MEMORY 3(MEM3) stage
    ///////////////////////////////
        
    //Input Buffers
    reg                 [DATA_WIDTH - 1          : 0]       ALU_OUT_MEM2_MEM3;
    reg                                                     COMP_OUT_MEM2_MEM3;
    reg                 [OPCODE_WIDTH - 1        : 0]       OPCODE_MEM2_MEM3;
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_MEM2_MEM3;
    reg                                                     WB_VALID_MEM2_MEM3;
    
    ///////////////////////////////
    //WRITE BACK(WB) stage
    ///////////////////////////////
    
    //Input Buffers
    reg                 [DATA_WIDTH - 1          : 0]       ALU_OUT_MEM3_WB;
    reg                                                     COMP_OUT_MEM3_WB;
    reg                 [OPCODE_WIDTH - 1        : 0]       OPCODE_MEM3_WB;    
    reg                 [REGARRAY_ADDR_WIDTH - 1 : 0]       RD_MEM3_WB;
    reg                                                     WB_VALID_MEM3_WB;
    
    //Final WB value is selected from data cache output or buffered alu output 
    reg                 [DATA_WIDTH - 1          : 0]       WB_DATA_FINAL;
    
    ///////////////////////////////
    //Feedback Controller 
    ///////////////////////////////
    
    
    //Outputs
    //Data
    wire                 [DATA_WIDTH - 1          : 0]       FEEDBACK_VALUE_RS1;
    wire                 [DATA_WIDTH - 1          : 0]       FEEDBACK_VALUE_RS2;
    
    //feedback control
    wire                                                     ENABLE_FEEDBACK_RS1_CNT;
    wire                                                     ENABLE_FEEDBACK_RS2_CNT;
    
    //final feedback value is selected from register output or feedback data output according to the feedback control signals
    wire                 [DATA_WIDTH - 1          : 0]       FEEDBACK_RS1_FINAL;
    wire                 [DATA_WIDTH - 1          : 0]       FEEDBACK_RS2_FINAL;
    
    ///////////////////////////////
    //Pipeline control 
    ///////////////////////////////
        
    //used to stall upto EX stage when a load is followed immediately by a dependent instrunction because it takes 3 cycles for the data to be ready
    reg                                                      STALL_ENABLE_1;    
    //used to stall upto ex stage at a branch to make sure if the branch is not taken garbage WB values are not fed into the FBC
    reg                                                      STALL_ENABLE_2;
    //used to stop the pipeline from stalling infinitely at two continuous loads which have dependent instructions following them
    reg                                                      FLAG;
    //final branch taken value is assigned from comparator output or in unconditional jump instructions
    reg                                                      BRANCH_TAKEN_FINAL;
    //used to control dumping of unwanted instructions in IF ID EX stages if a branch is taken
    reg                                                      BRANCH_TAKEN_REG;
    //to control jal instruction
    reg                                                      BRANCH_JAL;
    //to control jalr instruction
    reg                                                      BRANCH_JALR; 
    //counter1 is used to find the fnal clock cycle when stall enable is given
    reg                  [  3   :   0   ]                    COUNTER1;
    //COUNTER2 is used to flush the IF ID EX stages of the pipeline at a true branch instruction
    reg                  [  3   :   0   ]                    COUNTER2;
    
    wire                                                     STALL_1CYCLE;
    initial
    begin
        //stalls when off
        STALL_ENABLE_1          =   1'b1; 
        STALL_ENABLE_2          =   1'b1;
        BRANCH_TAKEN_FINAL      =   1'b0;
        BRANCH_TAKEN_REG        =   1'b0;
        COUNTER1                =   4'd0;
        COUNTER2                =   4'd0;
        CONTROL_DATA_CACHE      =   2'b00;
        ADDR_TO_DATA_CACHE      =   32'd0;
        DATA_TO_DATA_CACHE      =   32'd0;
    end
    
    assign  ALU                 =   ALU_OUT_EX_MEM1;
    assign  COMPAR              =   COMP_OUT_EX_MEM1;
    assign  BRANCH_TAKEN        =   BRANCH_TAKEN_FINAL;
    assign  BRANCH_ADDRESS      =   BRANCH_JALR? ALU_OUT_WIRE : {ALU_OUT_WIRE[31:1],1'b0}; //setting branch address lsb to zero if jalr
    assign  PIPELINE_STALL      =   STALL_ENABLE_1 && CACHE_READY_DATA;
   
    IDSTAGE ID(
        .INS_IN(INS_IF_ID),
        .CLK(CLK),
        .RD_OUT(RD_ID_EX_WIRE),
        .IMM_OUT(IMM_ID_EX_WIRE),
        .RS1_SEL(RS1_SEL_WIRE),
        .RS2_SEL(RS2_SEL_WIRE),
        .RS1_DATAOUT(RS1_ID_EX_WIRE),
        .RS2_DATAOUT(RS2_ID_EX_WIRE),
        .OPCODE_OUT(OPCODE_ID_EX_WIRE),
        .FUNCT_OUT(FUNCT_ID_EX_WIRE),
        .WB_VALID_OUT(WB_VALID_ID_EX_WIRE),
        .WB_DATA_IN(WB_DATA_FINAL),
        .WB_VALID_INPUT(WB_VALID_MEM3_WB),
        .RD_WB(RD_MEM3_WB),
        .ALU_CNT(ALU_CNT_WIRE),     
        .COMP_CNT(COMP_CNT_WIRE),
        .MUX1_CNT(MUX1_CNT_WIRE),
        .MUX2_CNT(MUX2_CNT_WIRE),
        .MUX3_CNT(MUX3_CNT_WIRE) 
    );
      
    
    EXSTAGE EX(
        .PC_IN(PC_ID_EX),
        .RS1_IN(RS1_ID_EX),
        .RS2_IN(RS2_ID_EX),
        .IMM_IN(IMM_ID_EX),
        .ALU_CNT_IN(ALU_CNT_ID_EX),     
        .COMP_CNT_IN(COMP_CNT_ID_EX),
        .MUX1_CNT_IN(MUX1_CNT_ID_EX),
        .MUX2_CNT_IN(MUX2_CNT_ID_EX),
        .MUX3_CNT_IN(MUX3_CNT_ID_EX),
        .ALU_OUT(ALU_OUT_WIRE),
        .COMP_OUT(COMP_OUT_WIRE)
     );
      
    
    FEEDBACK_CONTROLE FBC(
        .RS1_SEL(RS1_SEL_WIRE),
        .RS2_SEL(RS2_SEL_WIRE),
        .EN(CACHE_READY && CACHE_READY_DATA),
        .STALL_ENABLE(STALL_ENABLE_1),        //used to flush the shift reg if a branch is taken
        .RD_VALID(WB_VALID_ID_EX_WIRE && /*STALL_ENABLE_1 &&*/   !(BRANCH_TAKEN_REG || BRANCH_TAKEN_FINAL)),
        .RD_OUT(RD_ID_EX_WIRE),
        .CLK(CLK),
        .ALU_OUT_EX_MEM1_WIRE(ALU_OUT_WIRE),
        .ALU_OUT_EX_MEM1(ALU_OUT_EX_MEM1),
        .ALU_OUT_MEM1_MEM2(ALU_OUT_MEM1_MEM2),
        .ALU_OUT_MEM2_MEM3(ALU_OUT_MEM2_MEM3),
        .ALU_OUT_MEM3_WB( WB_DATA_FINAL),
        .UPDATED_RS1_VALUE(FEEDBACK_VALUE_RS1),
        .UPDATED_RS2_VALUE(FEEDBACK_VALUE_RS2),
        .MUX_RS1_SEL(ENABLE_FEEDBACK_RS1_CNT),
        .MUX_RS2_SEL(ENABLE_FEEDBACK_RS2_CNT),
        .STALL_1CYCLE(STALL_1CYCLE)
        );
        
    MUX_2to1_32bit FB_MUX_1(
        .IN1(RS1_ID_EX_WIRE),
        .IN2(FEEDBACK_VALUE_RS1),
        .OP(FEEDBACK_RS1_FINAL),
        .CONTROL(ENABLE_FEEDBACK_RS1_CNT)
        );
        
    MUX_2to1_32bit FB_MUX_2(
        .IN1(RS2_ID_EX_WIRE),
        .IN2(FEEDBACK_VALUE_RS2),
        .OP(FEEDBACK_RS2_FINAL),
        .CONTROL(ENABLE_FEEDBACK_RS2_CNT));
    
    
    //TEMP meory to emulate data cache
    
    wire [31:0] ALU_OUT_MEM2_MEM3_WIRE;
    reg  [3:0] WEA;
    reg   ENA;
    
//    blk_mem_gen_0 DATA_CACHE(
//    .addra(ALU_OUT_EX_MEM1),
//    .clka(CLK),
//    .dina(RS2_EX_MEM1),
//    .douta(ALU_OUT_MEM2_MEM3_WIRE),
//    .ena(ENA),
//    .wea(WEA)
//    );    
    
  
    
    
    always@(*)
    begin
    
    //STALL_ENABLE signal generation
    //This signal stalls the full pipeline upto EX stage and keeps the remaining DM stages and WB stages running
    //Feedback is done to the ID_EX buffer
                
//           if(STALL_1CYCLE)
//               STALL_ENABLE_1 =  1'b0;
//           else
            if(OPCODE_EX_MEM1 == 7'b0000011 && CACHE_READY) 
               STALL_ENABLE_1 =  1'b0;// && CACHE_READY_DATA;
           else if(OPCODE_MEM1_MEM2 == 7'b0000011 && CACHE_READY) 
               STALL_ENABLE_1 =  1'b0;// && CACHE_READY_DATA;
           else if(OPCODE_MEM2_MEM3 == 7'b0000011 && CACHE_READY) 
               STALL_ENABLE_1 =  1'b0;// && CACHE_READY_DATA;
           else if(OPCODE_MEM3_WB == 7'b0000011 && CACHE_READY) 
               STALL_ENABLE_1 =  1'b0;// && CACHE_READY_DATA
           else
               STALL_ENABLE_1 =  1'b1;// && CACHE_READY_DATA;
           
    //branch output controle
           if(OPCODE_ID_EX == 7'b1100011)
           begin
               BRANCH_TAKEN_FINAL = COMP_OUT_WIRE;    
               BRANCH_JAL         = 1'b0;
               BRANCH_JALR        = 1'b0;
           end
           else if(OPCODE_ID_EX == 7'b1101111)
           begin
               BRANCH_TAKEN_FINAL = 1'b1; 
               BRANCH_JAL         = 1'b1;
               BRANCH_JALR        = 1'b0;
           end
           else if(OPCODE_ID_EX == 7'b1100111)
           begin
               BRANCH_TAKEN_FINAL = 1'b1;  
               BRANCH_JAL         = 1'b0;
               BRANCH_JALR        = 1'b1;  
           end
           else
           begin
               BRANCH_TAKEN_FINAL = 1'b0;
               BRANCH_JAL         = 1'b0;
               BRANCH_JALR        = 1'b0;
           end
               
    //Emulation signal generation which are used running the block ram  
           if(OPCODE_ID_EX == 7'b0100011 && !BRANCH_TAKEN && CACHE_READY && STALL_ENABLE_1)                     // CONTROL_FROM_PROC = {00(idle), 01(read), 10(write), 11(flush address from cache)}
           begin
               CONTROL_DATA_CACHE = 2'b10;
           end
           else if(OPCODE_ID_EX == 7'b0000011 && !BRANCH_TAKEN && CACHE_READY && STALL_ENABLE_1)//7'b0100011)                     // CONTROL_FROM_PROC = {00(idle), 01(read), 10(write), 11(flush address from cache)}
           begin
               CONTROL_DATA_CACHE = 2'b01;
           end
           //read from cache
           else if(OPCODE_EX_MEM1 == 7'b0000011 && !BRANCH_TAKEN && CACHE_READY && STALL_ENABLE_1) 
           begin
               CONTROL_DATA_CACHE = 2'b01;
           end
           else if(OPCODE_MEM1_MEM2 == 7'b0000011 && !BRANCH_TAKEN && CACHE_READY && STALL_ENABLE_1) 
           begin
               CONTROL_DATA_CACHE = 2'b01;
           end
           else if(OPCODE_MEM2_MEM3 == 7'b0000011 && !BRANCH_TAKEN && CACHE_READY && STALL_ENABLE_1) 
           begin
               CONTROL_DATA_CACHE = 2'b01;
           end
           else
           begin
               CONTROL_DATA_CACHE = 2'b00;
           end            
           
           
           //data cache assignements
               ADDR_TO_DATA_CACHE = ALU_OUT_WIRE;//ALU_OUT_EX_MEM1;
               DATA_TO_DATA_CACHE = RS2_ID_EX;//RS2_EX_MEM1;  
               
    end
    
    
    //Used to select values correctly from data cache emulator or buffer
    always@(OPCODE_MEM3_WB or DATA_TO_PROC /*ALU_OUT_MEM2_MEM3_WIRE*/ or ALU_OUT_MEM3_WB)
    begin
           if(OPCODE_MEM3_WB ==  7'b0000011)
                WB_DATA_FINAL = DATA_TO_PROC;//ALU_OUT_MEM2_MEM3_WIRE;
           else
                WB_DATA_FINAL = ALU_OUT_MEM3_WB;
    end
    
    

    
    always@(posedge CLK)
    begin
    
    if(CACHE_READY_DATA)
    begin
        if(CACHE_READY)
        begin
            //registering branch taken control signal
            if(BRANCH_TAKEN_FINAL)
                BRANCH_TAKEN_REG <= 1'b1;
            
            if(COUNTER2 == 32'd2)
            begin
                BRANCH_TAKEN_REG <= 1'b0;
            end
                 
            if(BRANCH_TAKEN_REG && CACHE_READY)
                COUNTER2 <= COUNTER2 + 1;
            else if(CACHE_READY)
                COUNTER2 <= 32'd0;
            
        
        
            
            if(STALL_ENABLE_1)
            begin
                
                
                if(BRANCH_JAL)
                begin
                    PC_ID_EX    <=  32'd0; 
                    RD_ID_EX <= 5'd0;
                    RS1_ID_EX<= 32'd0;
                    RS2_ID_EX<= 32'd0;
                    IMM_ID_EX<= 32'd0;
                    OPCODE_ID_EX<= 7'd0;
                    FUNCT_ID_EX<= 10'd0;
                    WB_VALID_ID_EX <=1'b0;
                    RS1_SEL_ID_EX <= 5'd0 ;
                    RS2_SEL_ID_EX <= 5'd0 ;
                                
                    OPCODE_EX_MEM1<= OPCODE_ID_EX;
                    RS2_EX_MEM1      <=  5'd0;
                    ALU_OUT_EX_MEM1  <=  PC_IF_ID; 
                    COMP_OUT_EX_MEM1 <=  1'b0;
                    RD_EX_MEM1 <= RD_ID_EX;
                    WB_VALID_EX_MEM1 <= WB_VALID_ID_EX;
                end
                else if(BRANCH_JALR)
                begin
                
                    PC_ID_EX    <=  32'd0; 
                    RD_ID_EX <= 5'd0;
                    RS1_ID_EX<= 32'd0;
                    RS2_ID_EX<= 32'd0;
                    IMM_ID_EX<= 32'd0;
                    OPCODE_ID_EX<= 7'd0;
                    FUNCT_ID_EX<= 10'd0;
                    WB_VALID_ID_EX <=1'b0;
                    RS1_SEL_ID_EX <= 5'd0 ;
                    RS2_SEL_ID_EX <= 5'd0 ;
                    
                    
                    OPCODE_EX_MEM1<= OPCODE_ID_EX;
                    RS2_EX_MEM1      <=  5'd0;
                    ALU_OUT_EX_MEM1  <=  PC_IF_ID; 
                    COMP_OUT_EX_MEM1 <=  1'b0;
                    RD_EX_MEM1 <= RD_ID_EX;
                    WB_VALID_EX_MEM1 <= WB_VALID_ID_EX;
                end
                else
                 if(BRANCH_TAKEN_REG || BRANCH_TAKEN_FINAL)
                begin
                 //updating ID/EX buffer0
              
                 //data signals
                
                 PC_ID_EX    <=  32'd0; 
                 RD_ID_EX <= 5'd0;
                 RS1_ID_EX<= 32'd0;
                 RS2_ID_EX<= 32'd0;
                 IMM_ID_EX<= 32'd0;
                 OPCODE_ID_EX<= 7'd0;
                 FUNCT_ID_EX<= 10'd0;
                 WB_VALID_ID_EX <=1'b0;
                 RS1_SEL_ID_EX <= 5'd0 ;
                 RS2_SEL_ID_EX <= 5'd0 ;
               
                 //Control signals
                 ALU_CNT_ID_EX <= 4'd0;     
                 COMP_CNT_ID_EX <= 2'd0;
                 MUX1_CNT_ID_EX <= 1'b0;
                 MUX2_CNT_ID_EX <= 1'b0;
                 MUX3_CNT_ID_EX <= 1'b0;
               
                 
                 COUNTER1 <= 32'd0;
               
               //Updating EX/MEM1 buffer
               
               
                 OPCODE_EX_MEM1<= 7'd0;
                 RS2_EX_MEM1      <=  5'd0;
                 ALU_OUT_EX_MEM1  <=  32'd0; 
                 COMP_OUT_EX_MEM1 <=  1'b0;
                 RD_EX_MEM1 <= 5'd0;
                 WB_VALID_EX_MEM1 <= 1'b0;
                 
                end
                else
                begin
                //updating ID/EX buffer0
               
                //data signals
                
                PC_ID_EX    <=  PC_IF_ID; 
                RD_ID_EX <= RD_ID_EX_WIRE;
                RS1_ID_EX<= FEEDBACK_RS1_FINAL;
                RS2_ID_EX<= FEEDBACK_RS2_FINAL;
                IMM_ID_EX<= IMM_ID_EX_WIRE;
                OPCODE_ID_EX<= OPCODE_ID_EX_WIRE;
                FUNCT_ID_EX<= FUNCT_ID_EX_WIRE;
                WB_VALID_ID_EX <=WB_VALID_ID_EX_WIRE && STALL_ENABLE_2;
                RS1_SEL_ID_EX <= RS1_SEL_WIRE ;
                RS2_SEL_ID_EX <= RS2_SEL_WIRE ;
                
                //Control signals
                ALU_CNT_ID_EX <= ALU_CNT_WIRE;     
                COMP_CNT_ID_EX <= COMP_CNT_WIRE;
                MUX1_CNT_ID_EX <= MUX1_CNT_WIRE;
                MUX2_CNT_ID_EX <= MUX2_CNT_WIRE;
                MUX3_CNT_ID_EX <= MUX3_CNT_WIRE;
                
                
                COUNTER1 <= 32'd0;
                
                //Updating EX/MEM1 buffer
                
                
                OPCODE_EX_MEM1<= OPCODE_ID_EX;
                RS2_EX_MEM1      <=  RS2_ID_EX;
                ALU_OUT_EX_MEM1  <=  ALU_OUT_WIRE; 
                COMP_OUT_EX_MEM1 <=  COMP_OUT_WIRE;
                RD_EX_MEM1 <= RD_ID_EX;
                WB_VALID_EX_MEM1 <= WB_VALID_ID_EX;
                end
           
        end
        else
        begin
        
           
            COUNTER1 <= COUNTER1 + 1;
            
            if(COUNTER1 == 32'd3)
            begin
                 if(RS1_SEL_ID_EX == RD_MEM3_WB && WB_VALID_MEM3_WB == 1'b1 && OPCODE_MEM3_WB == 7'b0000011)                           
                           RS1_ID_EX<= DATA_TO_PROC;
                 else if(RS1_SEL_ID_EX == RD_MEM3_WB && WB_VALID_MEM3_WB == 1'b1)
                           RS1_ID_EX<= FEEDBACK_RS1_FINAL;
                 if(RS2_SEL_ID_EX == RD_MEM3_WB && WB_VALID_MEM3_WB == 1'b1 && OPCODE_MEM3_WB == 7'b0000011)
                           RS2_ID_EX<= DATA_TO_PROC;
                 else if(RS2_SEL_ID_EX == RD_MEM3_WB && WB_VALID_MEM3_WB == 1'b1)
                           RS2_ID_EX<= FEEDBACK_RS2_FINAL;
            end
            
           //makes sure garbage values are not fed into the pipeline at a stall
            WB_VALID_EX_MEM1 <= 1'b0; 
            OPCODE_EX_MEM1   <=  7'd0; 
            
//            OPCODE_EX_MEM1   <= 7'd0;
//                  //  RS2_EX_MEM1      <=  RS2_ID_EX;
//            ALU_OUT_EX_MEM1  <=  32'd0; 
//            COMP_OUT_EX_MEM1 <=  1'b0;
//            RD_EX_MEM1 <= 5'd0;
//            WB_VALID_EX_MEM1 <= 1'b0;
 
        end
         //Updating EX/MEM1 buffer
                       
       
        

       
        //updating MEM1/MEM2 buffer
        ALU_OUT_MEM1_MEM2 <= ALU_OUT_EX_MEM1;//ALU_OUT_EX_MEM1; 
        OPCODE_MEM1_MEM2 <= OPCODE_EX_MEM1;
        COMP_OUT_MEM1_MEM2 <= COMP_OUT_EX_MEM1; //COMP_OUT_EX_MEM1;
        RD_MEM1_MEM2 <= RD_EX_MEM1;
        WB_VALID_MEM1_MEM2 <= WB_VALID_EX_MEM1;
        
        //updating MEM2/MEM3 buffer
       
        OPCODE_MEM2_MEM3 <= OPCODE_MEM1_MEM2;
//        if(OPCODE_MEM1_MEM2 ==  7'b0000011 || OPCODE_MEM2_MEM3  ==  7'b0000011)
//            ALU_OUT_MEM2_MEM3 <= ALU_OUT_MEM2_MEM3_WIRE; 
//        else
        ALU_OUT_MEM2_MEM3 <= ALU_OUT_MEM1_MEM2; 
        COMP_OUT_MEM2_MEM3 <= COMP_OUT_MEM1_MEM2;
        RD_MEM2_MEM3 <= RD_MEM1_MEM2;
        WB_VALID_MEM2_MEM3 <= WB_VALID_MEM1_MEM2;
        
        //update MEM3/WB buffer
        OPCODE_MEM3_WB <= OPCODE_MEM2_MEM3;
        ALU_OUT_MEM3_WB <= ALU_OUT_MEM2_MEM3; 
        COMP_OUT_MEM3_WB <= COMP_OUT_MEM2_MEM3;
        RD_MEM3_WB <= RD_MEM2_MEM3;
        WB_VALID_MEM3_WB <= WB_VALID_MEM2_MEM3;            
      end
      
      
      end
    else
        WB_VALID_MEM3_WB <= 1'b0;
    end
endmodule
