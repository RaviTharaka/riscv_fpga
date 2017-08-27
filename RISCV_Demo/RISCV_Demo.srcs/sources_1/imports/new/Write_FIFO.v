`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2017 04:52:28 PM
// Design Name: 
// Module Name: Write_FIFO
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


module Write_FIFO(
    input           CLK,
    input [31 : 0]  FIFO_DATA,
    input           WRE,
    input           RESETN,
    
    output          clka,
    output [31 : 0] dina,
    output [31 : 0] addra,
    output [3  : 0] wrea,
    output          ena,
    output          rsta
    
    );
    
    reg [31:0] counter = 0;
    
    assign clka       = CLK;
    assign dina       = FIFO_DATA;
    assign addra      = counter;
    assign wrea       = {4{WRE && (counter < 512)}};
    assign ena        = 1;
    assign rsta       = 0;
    
    always @(posedge CLK) begin
        if(RESETN == 0) begin
            counter <= 0;
        end
        else begin 
            if(counter < 512 && WRE) begin
                counter <= counter + 4;
            end
        end
     end    
endmodule
