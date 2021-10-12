// This is generated automatically on 2021/10/05-14:08:00
// Check the # of bits for state registers !!!
// Check the # of bits for flag registers !!!

`ifndef __FLAG_DEFINE__
`define __FLAG_DEFINE__

// There're 6 states in this design
`define S_INIT                 	 0  
`define S_G1                     1
`define S_G2                     2
`define S_G3                     3
`define S_Y                    	 4  
`define S_R                    	 5  
`define S_END                  	 6
`define S_NONE1                  7
`define S_NONE2                  8
`define S_ZVEC                   9'b0
`define STATE_W                  9           

// done state
`define DONE_G1                  0
`define DONE_G2                  1
`define DONE_G3                  2
`define DONE_Y                   4
`define DONE_R                   5
`define DONE_NONE1               6
`define DONE_NONE2               7
`define STATE_DONE_W             8
`define DONE_ZVEC                8'b0

// Macro from template
`define BUF_SIZE               	 8'd66
`define READ_MEM_DELAY         	 2'd2
`define EMPTY_ADDR             	 {12{1'b0}}
`define EMPTY_DATA             	 {20{1'b0}}
`define LOCAL_IDX_W            	 16 
`define DATA_W                 	 20 

// Self-defined macro
`define CNT_W                  	 10

`endif
