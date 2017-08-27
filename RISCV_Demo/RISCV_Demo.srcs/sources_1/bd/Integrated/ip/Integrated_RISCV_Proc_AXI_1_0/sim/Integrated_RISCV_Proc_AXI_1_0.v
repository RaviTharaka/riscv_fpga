// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:RISCV_Proc_AXI:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module Integrated_RISCV_Proc_AXI_1_0 (
  CLK,
  EXT_FIFO_WR_ENB,
  EXT_FIFO_WR_DATA,
  P0_INIT_AXI_TXN,
  P0_TXN_DONE,
  P0_ERROR,
  M0_AXI_ACLK,
  M0_AXI_ARESETN,
  M0_AXI_AWID,
  M0_AXI_AWADDR,
  M0_AXI_AWLEN,
  M0_AXI_AWSIZE,
  M0_AXI_AWBURST,
  M0_AXI_AWLOCK,
  M0_AXI_AWCACHE,
  M0_AXI_AWPROT,
  M0_AXI_AWQOS,
  M0_AXI_AWUSER,
  M0_AXI_AWVALID,
  M0_AXI_AWREADY,
  M0_AXI_WDATA,
  M0_AXI_WSTRB,
  M0_AXI_WLAST,
  M0_AXI_WUSER,
  M0_AXI_WVALID,
  M0_AXI_WREADY,
  M0_AXI_BID,
  M0_AXI_BRESP,
  M0_AXI_BUSER,
  M0_AXI_BVALID,
  M0_AXI_BREADY,
  M0_AXI_ARID,
  M0_AXI_ARADDR,
  M0_AXI_ARLEN,
  M0_AXI_ARSIZE,
  M0_AXI_ARBURST,
  M0_AXI_ARLOCK,
  M0_AXI_ARCACHE,
  M0_AXI_ARPROT,
  M0_AXI_ARQOS,
  M0_AXI_ARUSER,
  M0_AXI_ARVALID,
  M0_AXI_ARREADY,
  M0_AXI_RID,
  M0_AXI_RDATA,
  M0_AXI_RRESP,
  M0_AXI_RLAST,
  M0_AXI_RUSER,
  M0_AXI_RVALID,
  M0_AXI_RREADY,
  P1_INIT_AXI_TXN,
  P1_TXN_DONE,
  P1_ERROR,
  M1_AXI_ACLK,
  M1_AXI_ARESETN,
  M1_AXI_AWID,
  M1_AXI_AWADDR,
  M1_AXI_AWLEN,
  M1_AXI_AWSIZE,
  M1_AXI_AWBURST,
  M1_AXI_AWLOCK,
  M1_AXI_AWCACHE,
  M1_AXI_AWPROT,
  M1_AXI_AWQOS,
  M1_AXI_AWUSER,
  M1_AXI_AWVALID,
  M1_AXI_AWREADY,
  M1_AXI_WDATA,
  M1_AXI_WSTRB,
  M1_AXI_WLAST,
  M1_AXI_WUSER,
  M1_AXI_WVALID,
  M1_AXI_WREADY,
  M1_AXI_BID,
  M1_AXI_BRESP,
  M1_AXI_BUSER,
  M1_AXI_BVALID,
  M1_AXI_BREADY,
  M1_AXI_ARID,
  M1_AXI_ARADDR,
  M1_AXI_ARLEN,
  M1_AXI_ARSIZE,
  M1_AXI_ARBURST,
  M1_AXI_ARLOCK,
  M1_AXI_ARCACHE,
  M1_AXI_ARPROT,
  M1_AXI_ARQOS,
  M1_AXI_ARUSER,
  M1_AXI_ARVALID,
  M1_AXI_ARREADY,
  M1_AXI_RID,
  M1_AXI_RDATA,
  M1_AXI_RRESP,
  M1_AXI_RLAST,
  M1_AXI_RUSER,
  M1_AXI_RVALID,
  M1_AXI_RREADY
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
input wire CLK;
output wire EXT_FIFO_WR_ENB;
output wire [31 : 0] EXT_FIFO_WR_DATA;
input wire P0_INIT_AXI_TXN;
output wire P0_TXN_DONE;
output wire P0_ERROR;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M0_AXI_ACLK CLK" *)
input wire M0_AXI_ACLK;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M0_AXI_ARESETN RST" *)
input wire M0_AXI_ARESETN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWID" *)
output wire [0 : 0] M0_AXI_AWID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWADDR" *)
output wire [31 : 0] M0_AXI_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWLEN" *)
output wire [7 : 0] M0_AXI_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWSIZE" *)
output wire [2 : 0] M0_AXI_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWBURST" *)
output wire [1 : 0] M0_AXI_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWLOCK" *)
output wire M0_AXI_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWCACHE" *)
output wire [3 : 0] M0_AXI_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWPROT" *)
output wire [2 : 0] M0_AXI_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWQOS" *)
output wire [3 : 0] M0_AXI_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWUSER" *)
output wire [0 : 0] M0_AXI_AWUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWVALID" *)
output wire M0_AXI_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI AWREADY" *)
input wire M0_AXI_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WDATA" *)
output wire [127 : 0] M0_AXI_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WSTRB" *)
output wire [15 : 0] M0_AXI_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WLAST" *)
output wire M0_AXI_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WUSER" *)
output wire [0 : 0] M0_AXI_WUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WVALID" *)
output wire M0_AXI_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI WREADY" *)
input wire M0_AXI_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI BID" *)
input wire [0 : 0] M0_AXI_BID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI BRESP" *)
input wire [1 : 0] M0_AXI_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI BUSER" *)
input wire [0 : 0] M0_AXI_BUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI BVALID" *)
input wire M0_AXI_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI BREADY" *)
output wire M0_AXI_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARID" *)
output wire [0 : 0] M0_AXI_ARID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARADDR" *)
output wire [31 : 0] M0_AXI_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARLEN" *)
output wire [7 : 0] M0_AXI_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARSIZE" *)
output wire [2 : 0] M0_AXI_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARBURST" *)
output wire [1 : 0] M0_AXI_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARLOCK" *)
output wire M0_AXI_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARCACHE" *)
output wire [3 : 0] M0_AXI_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARPROT" *)
output wire [2 : 0] M0_AXI_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARQOS" *)
output wire [3 : 0] M0_AXI_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARUSER" *)
output wire [0 : 0] M0_AXI_ARUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARVALID" *)
output wire M0_AXI_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI ARREADY" *)
input wire M0_AXI_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RID" *)
input wire [0 : 0] M0_AXI_RID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RDATA" *)
input wire [127 : 0] M0_AXI_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RRESP" *)
input wire [1 : 0] M0_AXI_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RLAST" *)
input wire M0_AXI_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RUSER" *)
input wire [0 : 0] M0_AXI_RUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RVALID" *)
input wire M0_AXI_RVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M0_AXI RREADY" *)
output wire M0_AXI_RREADY;
input wire P1_INIT_AXI_TXN;
output wire P1_TXN_DONE;
output wire P1_ERROR;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M1_AXI_ACLK CLK" *)
input wire M1_AXI_ACLK;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M1_AXI_ARESETN RST" *)
input wire M1_AXI_ARESETN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWID" *)
output wire [0 : 0] M1_AXI_AWID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWADDR" *)
output wire [31 : 0] M1_AXI_AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWLEN" *)
output wire [7 : 0] M1_AXI_AWLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWSIZE" *)
output wire [2 : 0] M1_AXI_AWSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWBURST" *)
output wire [1 : 0] M1_AXI_AWBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWLOCK" *)
output wire M1_AXI_AWLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWCACHE" *)
output wire [3 : 0] M1_AXI_AWCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWPROT" *)
output wire [2 : 0] M1_AXI_AWPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWQOS" *)
output wire [3 : 0] M1_AXI_AWQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWUSER" *)
output wire [0 : 0] M1_AXI_AWUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWVALID" *)
output wire M1_AXI_AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI AWREADY" *)
input wire M1_AXI_AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WDATA" *)
output wire [127 : 0] M1_AXI_WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WSTRB" *)
output wire [15 : 0] M1_AXI_WSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WLAST" *)
output wire M1_AXI_WLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WUSER" *)
output wire [0 : 0] M1_AXI_WUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WVALID" *)
output wire M1_AXI_WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI WREADY" *)
input wire M1_AXI_WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI BID" *)
input wire [0 : 0] M1_AXI_BID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI BRESP" *)
input wire [1 : 0] M1_AXI_BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI BUSER" *)
input wire [0 : 0] M1_AXI_BUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI BVALID" *)
input wire M1_AXI_BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI BREADY" *)
output wire M1_AXI_BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARID" *)
output wire [0 : 0] M1_AXI_ARID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARADDR" *)
output wire [31 : 0] M1_AXI_ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARLEN" *)
output wire [7 : 0] M1_AXI_ARLEN;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARSIZE" *)
output wire [2 : 0] M1_AXI_ARSIZE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARBURST" *)
output wire [1 : 0] M1_AXI_ARBURST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARLOCK" *)
output wire M1_AXI_ARLOCK;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARCACHE" *)
output wire [3 : 0] M1_AXI_ARCACHE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARPROT" *)
output wire [2 : 0] M1_AXI_ARPROT;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARQOS" *)
output wire [3 : 0] M1_AXI_ARQOS;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARUSER" *)
output wire [0 : 0] M1_AXI_ARUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARVALID" *)
output wire M1_AXI_ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI ARREADY" *)
input wire M1_AXI_ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RID" *)
input wire [0 : 0] M1_AXI_RID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RDATA" *)
input wire [127 : 0] M1_AXI_RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RRESP" *)
input wire [1 : 0] M1_AXI_RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RLAST" *)
input wire M1_AXI_RLAST;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RUSER" *)
input wire [0 : 0] M1_AXI_RUSER;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RVALID" *)
input wire M1_AXI_RVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 M1_AXI RREADY" *)
output wire M1_AXI_RREADY;

  RISCV_Proc_AXI #(
    .S(17),
    .B(9),
    .a(1),
    .T(1),
    .W(7),
    .N(1),
    .p(2),
    .V(2),
    .L2_DELAY_RD(7),
    .PROCESSOR_DATA_WIDTH(32),
    .C_M_TARGET_SLAVE_BASE_ADDR(32'H40000000),
    .C_M_AXI_BURST_LEN(4),
    .C_M_AXI_ID_WIDTH(1),
    .C_M_AXI_ADDR_WIDTH(32),
    .C_M_AXI_DATA_WIDTH(128),
    .C_M_AXI_AWUSER_WIDTH(0),
    .C_M_AXI_ARUSER_WIDTH(0),
    .C_M_AXI_WUSER_WIDTH(0),
    .C_M_AXI_RUSER_WIDTH(0),
    .C_M_AXI_BUSER_WIDTH(0)
  ) inst (
    .CLK(CLK),
    .EXT_FIFO_WR_ENB(EXT_FIFO_WR_ENB),
    .EXT_FIFO_WR_DATA(EXT_FIFO_WR_DATA),
    .P0_INIT_AXI_TXN(P0_INIT_AXI_TXN),
    .P0_TXN_DONE(P0_TXN_DONE),
    .P0_ERROR(P0_ERROR),
    .M0_AXI_ACLK(M0_AXI_ACLK),
    .M0_AXI_ARESETN(M0_AXI_ARESETN),
    .M0_AXI_AWID(M0_AXI_AWID),
    .M0_AXI_AWADDR(M0_AXI_AWADDR),
    .M0_AXI_AWLEN(M0_AXI_AWLEN),
    .M0_AXI_AWSIZE(M0_AXI_AWSIZE),
    .M0_AXI_AWBURST(M0_AXI_AWBURST),
    .M0_AXI_AWLOCK(M0_AXI_AWLOCK),
    .M0_AXI_AWCACHE(M0_AXI_AWCACHE),
    .M0_AXI_AWPROT(M0_AXI_AWPROT),
    .M0_AXI_AWQOS(M0_AXI_AWQOS),
    .M0_AXI_AWUSER(M0_AXI_AWUSER),
    .M0_AXI_AWVALID(M0_AXI_AWVALID),
    .M0_AXI_AWREADY(M0_AXI_AWREADY),
    .M0_AXI_WDATA(M0_AXI_WDATA),
    .M0_AXI_WSTRB(M0_AXI_WSTRB),
    .M0_AXI_WLAST(M0_AXI_WLAST),
    .M0_AXI_WUSER(M0_AXI_WUSER),
    .M0_AXI_WVALID(M0_AXI_WVALID),
    .M0_AXI_WREADY(M0_AXI_WREADY),
    .M0_AXI_BID(M0_AXI_BID),
    .M0_AXI_BRESP(M0_AXI_BRESP),
    .M0_AXI_BUSER(M0_AXI_BUSER),
    .M0_AXI_BVALID(M0_AXI_BVALID),
    .M0_AXI_BREADY(M0_AXI_BREADY),
    .M0_AXI_ARID(M0_AXI_ARID),
    .M0_AXI_ARADDR(M0_AXI_ARADDR),
    .M0_AXI_ARLEN(M0_AXI_ARLEN),
    .M0_AXI_ARSIZE(M0_AXI_ARSIZE),
    .M0_AXI_ARBURST(M0_AXI_ARBURST),
    .M0_AXI_ARLOCK(M0_AXI_ARLOCK),
    .M0_AXI_ARCACHE(M0_AXI_ARCACHE),
    .M0_AXI_ARPROT(M0_AXI_ARPROT),
    .M0_AXI_ARQOS(M0_AXI_ARQOS),
    .M0_AXI_ARUSER(M0_AXI_ARUSER),
    .M0_AXI_ARVALID(M0_AXI_ARVALID),
    .M0_AXI_ARREADY(M0_AXI_ARREADY),
    .M0_AXI_RID(M0_AXI_RID),
    .M0_AXI_RDATA(M0_AXI_RDATA),
    .M0_AXI_RRESP(M0_AXI_RRESP),
    .M0_AXI_RLAST(M0_AXI_RLAST),
    .M0_AXI_RUSER(M0_AXI_RUSER),
    .M0_AXI_RVALID(M0_AXI_RVALID),
    .M0_AXI_RREADY(M0_AXI_RREADY),
    .P1_INIT_AXI_TXN(P1_INIT_AXI_TXN),
    .P1_TXN_DONE(P1_TXN_DONE),
    .P1_ERROR(P1_ERROR),
    .M1_AXI_ACLK(M1_AXI_ACLK),
    .M1_AXI_ARESETN(M1_AXI_ARESETN),
    .M1_AXI_AWID(M1_AXI_AWID),
    .M1_AXI_AWADDR(M1_AXI_AWADDR),
    .M1_AXI_AWLEN(M1_AXI_AWLEN),
    .M1_AXI_AWSIZE(M1_AXI_AWSIZE),
    .M1_AXI_AWBURST(M1_AXI_AWBURST),
    .M1_AXI_AWLOCK(M1_AXI_AWLOCK),
    .M1_AXI_AWCACHE(M1_AXI_AWCACHE),
    .M1_AXI_AWPROT(M1_AXI_AWPROT),
    .M1_AXI_AWQOS(M1_AXI_AWQOS),
    .M1_AXI_AWUSER(M1_AXI_AWUSER),
    .M1_AXI_AWVALID(M1_AXI_AWVALID),
    .M1_AXI_AWREADY(M1_AXI_AWREADY),
    .M1_AXI_WDATA(M1_AXI_WDATA),
    .M1_AXI_WSTRB(M1_AXI_WSTRB),
    .M1_AXI_WLAST(M1_AXI_WLAST),
    .M1_AXI_WUSER(M1_AXI_WUSER),
    .M1_AXI_WVALID(M1_AXI_WVALID),
    .M1_AXI_WREADY(M1_AXI_WREADY),
    .M1_AXI_BID(M1_AXI_BID),
    .M1_AXI_BRESP(M1_AXI_BRESP),
    .M1_AXI_BUSER(M1_AXI_BUSER),
    .M1_AXI_BVALID(M1_AXI_BVALID),
    .M1_AXI_BREADY(M1_AXI_BREADY),
    .M1_AXI_ARID(M1_AXI_ARID),
    .M1_AXI_ARADDR(M1_AXI_ARADDR),
    .M1_AXI_ARLEN(M1_AXI_ARLEN),
    .M1_AXI_ARSIZE(M1_AXI_ARSIZE),
    .M1_AXI_ARBURST(M1_AXI_ARBURST),
    .M1_AXI_ARLOCK(M1_AXI_ARLOCK),
    .M1_AXI_ARCACHE(M1_AXI_ARCACHE),
    .M1_AXI_ARPROT(M1_AXI_ARPROT),
    .M1_AXI_ARQOS(M1_AXI_ARQOS),
    .M1_AXI_ARUSER(M1_AXI_ARUSER),
    .M1_AXI_ARVALID(M1_AXI_ARVALID),
    .M1_AXI_ARREADY(M1_AXI_ARREADY),
    .M1_AXI_RID(M1_AXI_RID),
    .M1_AXI_RDATA(M1_AXI_RDATA),
    .M1_AXI_RRESP(M1_AXI_RRESP),
    .M1_AXI_RLAST(M1_AXI_RLAST),
    .M1_AXI_RUSER(M1_AXI_RUSER),
    .M1_AXI_RVALID(M1_AXI_RVALID),
    .M1_AXI_RREADY(M1_AXI_RREADY)
  );
endmodule
