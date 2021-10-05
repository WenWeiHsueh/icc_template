`include "define.v"

module dp (
    input  clk,
    input  reset,
    input  curr_state,
    input  dp_cnt_rst,
    output done_state
);

reg [`CNT_W-1:0] cnt;
wire reset = red_done | rst; // since I have to reset the done signal either red_done or rst 
reg [`STATE_DONE_W-1:0] done_state;

// cnt
always @(posedge clk) begin
    if (dp_cnt_rst) begin
        cnt <= 0;
    end else begin
        cnt <= cnt + 1;
    end
end

// S_G
always @(posedge clk) begin
    if (reset) begin
        done_state[`DONE_G1] <= 1'b0;
        done_state[`DONE_G2] <= 1'b0;
        done_state[`DONE_G3] <= 1'b0;
    end else begin
        if (curr_state[`S_G]) begin
            if (done_state[`DONE_G1] == 1'b0) begin
                if (cnt > 1024) begin
                    done_state[`DONE_G1] <= 1'b1;
                end
            end else if (done_state[`DONE_G2] == 1'b0) begin
                if (cnt > 128) begin
                    done_state[`DONE_G2] <= 1'b1;
                end
            end else if (done_state[`DONE_G3] == 1'b0)) begin
                if (cnt > 128) begin
                    done_state[`DONE_G3] <= 1'b1;
                end
            end
        end
    end
end

// S_Y
always @(posedge clk) begin
    if (reset) begin
        done_state[`DONE_Y] <= 1'b0;
    end else begin
        if (curr_state[`S_Y]) begin
            if (done_state[`DONE_Y] == 1'b0) begin
                if (cnt > 512) begin
                    done_state[`DONE_Y] <= 1'b1;
                end 
            end
        end
    end
end
  
// S_R
always @(posedge clk) begin
    if (reset) begin
        done_state[`DONE_R] <= 1'b0;
    end else begin
        if (curr_state[`S_R]) begin
            if (done_state[`DONE_R] == 1'b0) begin
                if (cnt > 1024) begin
                    done_state[`DONE_R] <= 1'b1;
                end 
            end
        end
    end
end  

// S_NONE
always @(posedge clk) begin
    if (reset) begin
        done_state[`DONE_NONE1] <= 1'b0;
        done_state[`DONE_NONE2] <= 1'b0;
    end else begin
        if (curr_state[`S_NONE]) begin
            if (done_state[`DONE_NONE1] == 1'b0) begin
                if (cnt > 128) begin
                    done_state[`DONE_NONE1] <= 1'b1; 
                end
            end else if (done_state[`DONE_NONE2] == 1'b0) begin
                if (cnt > 128) begin
                    done_state[`DONE_NONE2] <= 1'b1; 
                end
            end
        end
    end
end
endmodule