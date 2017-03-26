`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Yasas Seneviratne
// 
// Create Date: 03/04/2017 08:24:33 PM
// Design Name: 
// Module Name: RISCV_PROCESSOR
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


module RISCV_PROCESSOR#(
        // Fixed parameters
        localparam ADDR_WIDTH           = 32,
        localparam DATA_WIDTH           = 32,
           
        // Primary parameters
        parameter S                     = 17,                    // Size of the cache will be 2^S bits
        parameter B                     = 9,                     // Size of a block will be 2^B bits
        parameter a                     = 1,                     // Associativity of the cache would be 2^a
        parameter T                     = 1,                     // Width to depth translation amount
        parameter W                     = 7,                     // Width of the L2-L1 bus would be 2^W
        parameter N                     = 3,                     // Number of stream buffers
        parameter n                     = 1,                     // Depth of stream buffers would be 2^n
        parameter p                     = 2,                     // Prefetch queue's depth is 2^p
        parameter V                     = 2,                     // Size of the victim cache will be 2^V cache lines
        parameter L2_DELAY_RD           = 7,                     // Delay of the second level of cache
                    
//        // Calculated parameters
//        localparam BYTES_PER_WORD       = logb2(DATA_WIDTH/8),
        
//        localparam CACHE_SIZE           = 1 << S,
//        localparam BLOCK_SIZE           = 1 << B,
//        localparam ASSOCIATIVITY        = 1 << a,
        
//        localparam TAG_WIDTH            = ADDR_WIDTH + 3 + a - S,
//        localparam LINE_ADDR_WIDTH      = S - a - B + T,
//        localparam TAG_ADDR_WIDTH       = S - a - B,
        
        localparam L2_BUS_WIDTH         = 1 << W
//        localparam BLOCK_SECTIONS       = 1 << T,
        
//        localparam SET_SIZE             = CACHE_SIZE / ASSOCIATIVITY,
//        localparam LINE_RAM_WIDTH       = 1 << (B - T),
//        localparam LINE_RAM_DEPTH       = 1 << LINE_ADDR_WIDTH,
//        localparam TAG_RAM_WIDTH        = TAG_WIDTH + BLOCK_SECTIONS,
//        localparam TAG_RAM_DEPTH        = 1 << TAG_ADDR_WIDTH,
        
//        localparam PREFETCH_QUEUE_DEPTH = 1 << p,
//        localparam STREAM_BUF_DEPTH     = 1 << n,
//        localparam STREAM_SEL_BITS      = logb2(N + 1),
        
//        localparam L2_BURST             = 1 << (B - W)
    ) (
        // Standard inputs
        input                               CLK,
        input                               RSTN,
            
        ////////////////////////
        // INSTRUCTION CACHE  //
        ////////////////////////
        
        // Output address bus from Instruction Cache to Memory
        input                               ADDR_TO_L2_READY_INS,
        output                              ADDR_TO_L2_VALID_INS,      
        output     [ADDR_WIDTH - 2 - 1 : 0] ADDR_TO_L2_INS,
                
        // Input data bus to Insruction Cache from Memory       
        input                               DATA_FROM_L2_VALID_INS,
        output                              DATA_FROM_L2_READY_INS,
        input      [L2_BUS_WIDTH   - 1 : 0] DATA_FROM_L2_INS,
        
        
        ////////////////////////
        //    DATA CACHE      //
        ////////////////////////
        
        // Write bus between Data Cache and Memory 
        input                               WR_TO_L2_READY_DAT,
        output                              WR_TO_L2_VALID_DAT,
        output     [ADDR_WIDTH - 2 - 1 : 0] WR_ADDR_TO_L2_DAT,
        output     [L2_BUS_WIDTH   - 1 : 0] DATA_TO_L2_DAT,
        output                              WR_CONTROL_TO_L2_DAT,
        input                               WR_COMPLETE_DAT,
        
        // Read address from Data Cache to Memory
        input                               RD_ADDR_TO_L2_READY_DAT,
        output                              RD_ADDR_TO_L2_VALID_DAT,
        output     [ADDR_WIDTH - 2 - 1 : 0] RD_ADDR_TO_L2_DAT,
        
        // Read data to Data Cache from Memory
        input                               DATA_FROM_L2_VALID_DAT,
        output                              DATA_FROM_L2_READY_DAT,
        input      [L2_BUS_WIDTH   - 1 : 0] DATA_FROM_L2_DAT       
          
    );
    
     // Status signals between processor and instruction cache
     wire                               PROC_READY_INS;
     wire                               CACHE_READY_INS;
     wire                               BRANCH_TAKEN_INS;
     
     // Input address bus from the processor to instruction cache
     wire                               BRANCH;
     wire   [ADDR_WIDTH - 1 : 0]        BRANCH_ADDRESS_INS;
           
     // Output data bus from instruction cache to the processor
     wire   [DATA_WIDTH - 1 : 0]        DATA_TO_PROC_INS;
     wire   [ADDR_WIDTH - 1 : 0]        PC_TO_PROC_INS;
     
     
     //Status signals between processor and data cache
     wire   [     2     - 1 : 0]        CONTROL_FROM_PROC_DATA;
     wire                               PROC_READY_DATA;
     wire                               CACHE_READY_DATA;
        
     //Input address bus from the processor to instruction cache     
     wire   [ADDR_WIDTH - 1 : 0]        ADDR_FROM_PROC_DATA;
     
     //Output data from instruction cache to processor
     wire   [DATA_WIDTH - 1 : 0]        DATA_FROM_PROC_DATA;
     wire   [DATA_WIDTH - 1 : 0]        DATA_TO_PROC_DATA;
     
     Ins_Cache # (
         .S(S),
         .B(B),
         .a(a),
         .T(T),
         .W(W),
         .L2_DELAY(L2_DELAY_RD)
     ) ins_cache (
         .CLK(CLK),
         .RSTN(RSTN),
        
         .BRANCH_ADDR_IN(BRANCH_ADDRESS_INS),
         .BRANCH(BRANCH_TAKEN_INS),
         .DATA_TO_PROC(DATA_TO_PROC_INS),
         .PC_TO_PROC(PC_TO_PROC_INS),
         .CACHE_READY(CACHE_READY_INS),
         .PROC_READY(PROC_READY_INS),
                
         .ADDR_TO_L2(ADDR_TO_L2_INS),
         .ADDR_TO_L2_READY(ADDR_TO_L2_READY_INS),
         .ADDR_TO_L2_VALID(ADDR_TO_L2_VALID_INS),
        
         .DATA_FROM_L2(DATA_FROM_L2_INS),
         .DATA_FROM_L2_VALID(DATA_FROM_L2_VALID_INS),
         .DATA_FROM_L2_READY(DATA_FROM_L2_READY_INS)
    );
    
    PIPELINE uut2(
         .CLK(CLK),
         
    //Instruction cache buses
         .CACHE_READY(CACHE_READY_INS),
         .PC_IF_ID(PC_TO_PROC_INS), //IF out to ID in
         .INS_IF_ID(DATA_TO_PROC_INS),
         .BRANCH_TAKEN(BRANCH_TAKEN_INS),
         .BRANCH_ADDRESS(BRANCH_ADDRESS_INS),
//         .ALU(ALU_OUT),
//         .COMPAR(COMPARE),
         .PIPELINE_STALL(PROC_READY_INS),
         
    //Data cache busses
    
         .CONTROL_DATA_CACHE(CONTROL_FROM_PROC_DATA), 
         .ADDR_TO_DATA_CACHE(ADDR_FROM_PROC_DATA),
         .DATA_TO_DATA_CACHE(DATA_FROM_PROC_DATA),
         .DATA_TO_PROC(DATA_TO_PROC_DATA),
              
         .PROC_READY(PROC_READY_DATA),
         .CACHE_READY_DATA(CACHE_READY_DATA)
         
    );
    
    Data_Cache #(
        .S(S),
        .B(B),
        .a(a),
        .T(T),
        .W(W),
        .L2_DELAY_RD(L2_DELAY_RD),
        .V(V)
    ) data_cache (
        .CLK(CLK),
        .CONTROL_FROM_PROC(CONTROL_FROM_PROC_DATA),              // CONTROL_FROM_PROC = {00(idle), 01(read), 10(write), 11(flush address from cache)}
        .ADDR_FROM_PROC(ADDR_FROM_PROC_DATA),
        .DATA_FROM_PROC(DATA_FROM_PROC_DATA),
        .DATA_TO_PROC(DATA_TO_PROC_DATA),
        
        .PROC_READY(PROC_READY_DATA),
        .CACHE_READY(CACHE_READY_DATA),
        
        // Ports towards the L2 cache
        .WR_TO_L2_READY(WR_TO_L2_READY_DAT),
        .WR_TO_L2_VALID(WR_TO_L2_VALID_DAT),
        .WR_ADDR_TO_L2(WR_ADDR_TO_L2_DAT),
        .DATA_TO_L2(DATA_TO_L2_DAT),
        .WR_CONTROL_TO_L2(WR_CONTROL_TO_L2_DAT),
        .WR_COMPLETE(WR_COMPLETE_DAT),
        
        .RD_ADDR_TO_L2_READY(RD_ADDR_TO_L2_READY_DAT),
        .RD_ADDR_TO_L2_VALID(RD_ADDR_TO_L2_VALID_DAT),
        .RD_ADDR_TO_L2(RD_ADDR_TO_L2_DAT),
        
        .DATA_FROM_L2_VALID(DATA_FROM_L2_VALID_DAT),
        .DATA_FROM_L2_READY(DATA_FROM_L2_READY_DAT),
        .DATA_FROM_L2(DATA_FROM_L2_DAT)       
    );
endmodule
