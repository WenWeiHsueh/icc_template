`include "define.v"

module dp (
    input                           clk,
    input                           rst,
    input       [`STATE_W-1:0]      curr_state,
    input                           dp_cnt_rst,
    output reg  [`STATE_DONE_W-1:0] done_state,
    output reg                      R,
    output reg                      G,
    output reg                      Y
);

reg [`CNT_W-1:0] cnt;

// cnt
always @(posedge clk) begin
    if (dp_cnt_rst) begin
        cnt <= 0; //Must be '0' because of the width.
    end else begin
        cnt <= cnt + 1;
    end
end

// done_state
always @(*) begin
    done_state = `DONE_ZVEC;
    case (1'b1)
        curr_state[`S_G1]: begin
            if (cnt > 1022) begin
                done_state[`DONE_G1] = 1'b1;
            end
        end

        curr_state[`S_G2]: begin
            if (cnt > 126) begin
                done_state[`DONE_G2] = 1'b1;
            end
        end

        curr_state[`S_G3]: begin
            if (cnt > 126) begin
                done_state[`DONE_G3] = 1'b1;
            end
        end

        curr_state[`S_Y]: begin
            if (cnt > 510) begin
                done_state[`DONE_Y] = 1'b1;
            end 
        end

        curr_state[`S_R]: begin
            if (cnt > 1022) begin
                done_state[`DONE_R] = 1'b1;
            end 
        end
        
        curr_state[`S_NONE1]: begin
            if (cnt > 126) begin
                done_state[`DONE_NONE1] = 1'b1; 
            end
        end

        curr_state[`S_NONE2]: begin
            if (cnt > 126) begin
                done_state[`DONE_NONE2] = 1'b1; 
            end
        end
    endcase
end

// light_control
always @(*) begin
    case (1'b1)
        curr_state[`S_R]: begin
            {R, G, Y} <= {1'b1, 1'b0, 1'b0};
        end 

        curr_state[`S_G1], curr_state[`S_G2], curr_state[`S_G3]: begin
            {R, G, Y} <= {1'b0, 1'b1, 1'b0};
        end 
        
        curr_state[`S_Y]: begin
            {R, G, Y} <= {1'b0, 1'b0, 1'b1};
        end 

        curr_state[`S_NONE1], curr_state[`S_NONE2]: begin
            {R, G, Y} <= {1'b0, 1'b0, 1'b0};
        end 

        default: begin
            {R, G, Y} <= {1'b0, 1'b0, 1'b0};
        end
    endcase        
end

endmodule