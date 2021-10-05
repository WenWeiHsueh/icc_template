`include "define.v"

module ctrl (
    input  clk,
    input  rst,
    input  done_state,
    output dp_cnt_rst,
    output reg [`STATE_W-1:0] curr_state
);

reg [`STATE_W-1:0] next_state;
// reg [`STATE_W-1:0] curr_state;

// State Register (S)
always @(posedge clk) begin
    if (rst == 1) begin
        curr_state <= 0; // ????
    end else begin
        curr_state <= next_state;
    end
    
end

// Next State Logic (C)
always @(*) begin
    next_state = `S_INIT;
    if (rst == 1) begin
        next_state[`S_G] = 1'b1;
    end else begin
        case (1'b1)
            curr_state[`S_G]: begin
                if (done_state[`DONE_G1]) begin
                    next_state[`S_NONE] = 1'b1;
                end else if (done_state[`DONE_G2]) begin
                    next_state[`S_NONE] = 1'b1;
                end else if (done_state[`DONE_G3]) begin
                    next_state[`S_Y] = 1'b1;
                end else begin
                    next_state[`S_G] = 1'b1;
                end
            end

            curr_state[`S_Y]: begin
                if (done_state[`DONE_Y]) begin
                    next_state[`S_R] = 1'b1;
                end else begin
                    next_state[`S_Y] = 1'b1;
                end
            end

            curr_state[`S_R]: begin
                if (done_state[`DONE_R]) begin
                    next_state[`S_G] = 1'b1;
                end else begin
                    next_state[`S_R] = 1'b1;
                end
            end 

            curr_state[`S_NONE]: begin
                if (done_state[`DONE_NONE1]) begin
                    next_state[`S_G] = 1'b1;
                end else if (done_state[`DONE_NONE2]) begin
                    next_state[`S_G] = 1'b1;
                end else begin
                    next_state[`S_NONE] = 1'b1;
                end
            end
            
            default: begin
                next_state = next_state;
            end
        endcase
    end
end

// wire done_state[`DONE_G] = done_state[`DONE_G1] | done_state[`DONE_G2] | done_state[`DONE_G3];
// wire done_state[`DONE_NONE] = done_state[`DONE_NONE1] | done_state[`DONE_NONE2];

wire done_G = done_state[`DONE_G1] | done_state[`DONE_G2] | done_state[`DONE_G3];
wire done_NONE = done_state[`DONE_NONE1] | done_state[`DONE_NONE2];

// Output Logic (C)
always @(*) begin
    dp_cnt_rst = 0;
    if (rst) begin
        dp_cnt_rst = 1;
    end else begin
        case (1'b1)
            curr_state[`S_G]: begin
                if (done_G) begin
                    dp_cnt_rst = 1;
                end
            end

            curr_state[`S_Y]: begin
                if (done_state[`DONE_Y]) begin
                    dp_cnt_rst = 1;
                end
            end

            curr_state[`S_R]: begin
                if (done_state[`DONE_R]) begin
                    dp_cnt_rst = 1;
                end
            end 

            curr_state[`S_NONE]: begin
                if (done_NONE) begin
                    dp_cnt_rst = 1;
                end
            end 
            
            default: begin
                dp_cnt_rst = 0;
            end 

        endcase
    end
end
endmodule