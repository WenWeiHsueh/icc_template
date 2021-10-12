`include "define.v"

module ctrl (
    input                           clk,
    input                           rst,
    input                           pass,
    input       [`STATE_DONE_W-1:0] done_state,
    output reg                      dp_cnt_rst,
    output reg  [`STATE_W-1:0]      curr_state
);

reg [`STATE_W-1:0] next_state;

// State Register (S)
always @(posedge clk) begin
    curr_state <= next_state;
end

// Next State Logic (C)
always @(*) begin
    next_state = `S_INIT;
    if (rst) begin
        next_state[`S_G1] = 1'b1;
    end else if (pass) begin
        if (curr_state[`S_G1]) begin
            next_state[`S_G1] = 1'b1;
        end else begin
            next_state[`S_G1] = 1'b1;
        end
    end else begin
        case (1'b1)

            curr_state[`S_INIT]: begin
                next_state[`S_G1] = 1'b1;
            end

            curr_state[`S_G1]: begin
                if (done_state[`DONE_G1]) begin
                    next_state[`S_NONE1] = 1'b1;
                end else begin
                    next_state[`S_G1] = 1'b1;
                end
            end

            curr_state[`S_G2]: begin
                if (done_state[`DONE_G2]) begin
                    next_state[`S_NONE2] = 1'b1;
                end else begin
                    next_state[`S_G2] = 1'b1;
                end
            end

            curr_state[`S_G3]: begin
                if (done_state[`DONE_G3]) begin
                    next_state[`S_Y] = 1'b1;
                end else begin
                    next_state[`S_G3] = 1'b1;
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
                    next_state[`S_G1] = 1'b1;
                end else begin
                    next_state[`S_R] = 1'b1;
                end
            end 

            curr_state[`S_NONE1]: begin
                if (done_state[`DONE_NONE1]) begin
                    next_state[`S_G2] = 1'b1;
                end else begin
                    next_state[`S_NONE1] = 1'b1;
                end
            end
            
            curr_state[`S_NONE2]: begin
                if (done_state[`DONE_NONE2]) begin
                    next_state[`S_G3] = 1'b1;
                end else begin
                    next_state[`S_NONE2] = 1'b1;
                end
            end
            
        endcase
    end
end

// Output Logic (C)
// Faster than the other one???????
always @(*) begin
    dp_cnt_rst = 1'b0;
    if (rst) begin
        dp_cnt_rst = 1'b1;
    end else if (pass) begin
        if (curr_state[`S_G1]) begin
            dp_cnt_rst = 1'b0;
        end else begin
            dp_cnt_rst = 1'b1;
        end
    end else if(done_state) begin // Once the states finish, dp_cnt_rst = 1'b1
        dp_cnt_rst = 1'b1;
    end
end

// wire done_G = done_state[`DONE_G1] | done_state[`DONE_G2] | done_state[`DONE_G3];
// wire done_NONE = done_state[`DONE_NONE1] | done_state[`DONE_NONE2];

// // Output Logic (C)
// always @(*) begin
//     dp_cnt_rst = 1'b0;
//     if (rst) begin
//         dp_cnt_rst = 1'b1;
//     end else if (pass) begin
//         if (curr_state[`S_G1]) begin
//             dp_cnt_rst = 1'b0;
//         end else begin
//             dp_cnt_rst = 1'b1;
//         end
//     end else begin
//         case (1'b1)
//             curr_state[`S_G1], curr_state[`S_G2], curr_state[`S_G3]: begin
//                 if (done_G) begin
//                     dp_cnt_rst = 1'b1;
//                 end
//             end

//             curr_state[`S_Y]: begin
//                 if (done_state[`DONE_Y]) begin
//                     dp_cnt_rst = 1'b1;
//                 end
//             end

//             curr_state[`S_R]: begin
//                 if (done_state[`DONE_R]) begin
//                     dp_cnt_rst = 1'b1;
//                 end
//             end 

//             curr_state[`S_NONE1], curr_state[`S_NONE2]: begin
//                 if (done_NONE) begin
//                     dp_cnt_rst = 1'b1;
//                 end
//             end 
//         endcase
//     end
// end

endmodule