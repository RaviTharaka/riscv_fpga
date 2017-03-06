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
        parameter L2_DELAY              = 7,                     // Delay of the second level of cache
        parameter N                     = 3,                     // Number of stream buffers
        parameter n                     = 1,                     // Depth of stream buffers would be 2^n
        parameter p                     = 2,                     // Prefetch queue's depth is 2^p
        
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
        
        // Input data bus from L2 cache        
        input                               DATA_FROM_L2_VALID,
        output                              DATA_FROM_L2_READY,
        input      [L2_BUS_WIDTH   - 1 : 0] DATA_FROM_L2,
        
        // Output address bus to L2 cache
        input                               ADDR_TO_L2_READY,
        output                              ADDR_TO_L2_VALID,      
        output     [ADDR_WIDTH - 2 - 1 : 0] ADDR_TO_L2
        
        //Pipeline outputs TEMPARARY
  //      output     [DATA_WIDTH-1       : 0] PIPELINE_
          
    );
    
     // Status signals between processor and cache
     wire                               PROC_READY;
     wire                               CACHE_READY;
     wire                               BRANCH_TAKEN;
     
     // Input address bus from the processor
     wire                               BRANCH;
     wire   [ADDR_WIDTH - 1 : 0]        BRANCH_ADDRESS;
           
     // Output data bus to the processor
     wire   [DATA_WIDTH - 1 : 0]        DATA_TO_PROC;
     wire   [ADDR_WIDTH - 1 : 0]        PC_TO_PROC;
     
     
     Ins_Cache # (
         .S(S),
         .B(B),
         .a(a),
         .T(T),
         .W(W),
         .L2_DELAY(L2_DELAY)
     ) uut (
         .CLK(CLK),
         .RSTN(RSTN),
        
         .BRANCH_ADDR_IN(BRANCH_ADDRESS),
         .BRANCH(BRANCH_TAKEN),
         .DATA_TO_PROC(DATA_TO_PROC),
         .PC_TO_PROC(PC_TO_PROC),
         .CACHE_READY(CACHE_READY),
         .PROC_READY(PROC_READY),
                
         .ADDR_TO_L2(ADDR_TO_L2),
         .ADDR_TO_L2_READY(ADDR_TO_L2_READY),
         .ADDR_TO_L2_VALID(ADDR_TO_L2_VALID),
        
         .DATA_FROM_L2(DATA_FROM_L2),
         .DATA_FROM_L2_VALID(DATA_FROM_L2_VALID),
         .DATA_FROM_L2_READY(DATA_FROM_L2_READY)
    );
    
    PIPELINE uut2(
         .CLK(CLK),
         .CACHE_READY(CACHE_READY),
         .PC_IF_ID(PC_TO_PROC), //IF out to ID in
         .INS_IF_ID(DATA_TO_PROC),
         .BRANCH_TAKEN(BRANCH_TAKEN),
         .BRANCH_ADDRESS(BRANCH_ADDRESS),
//         .ALU(ALU_OUT),
//         .COMPAR(COMPARE),
         .PIPELINE_STALL(PROC_READY)
    );
endmodule
