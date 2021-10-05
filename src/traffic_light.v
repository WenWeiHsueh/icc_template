`include "define.v"

module traffic_light (
    input  clk,
    input  rst,
    input  pass,
    output R,
    output G,
    output Y
);

wire [`STATE_DONE_W-1:0] done_state;
wire [`STATE_DONE_W-1:0] done_state_ctrl;

assign done_state_ctrl = done_state;

// light_control
always @(*) begin
    case (1'b1)
        curr_state[`S_R]: begin
            {R, G, Y} = {1'b1, 1'b0, 1'b0};
        end 

        curr_state[`S_G]: begin
            {R, G, Y} = {1'b0, 1'b1, 1'b0};
        end 
        
        curr_state[`S_Y]: begin
            {R, G, Y} = {1'b0, 1'b0, 1'b1};
        end 

        curr_state[`S_NONE]: begin
            {R, G, Y} = {1'b0, 1'b0, 1'b0};
        end 

        default: begin
            {R, G, Y} = {1'b0, 1'b0, 1'b0};
        end
    endcase
end

ctrl ctrl_traffic_light(
    .clk(clk),
    .rst(rst),
    .done_state(done_state_ctrl),
    .dp_cnt_rst(dp_cnt_rst),
    .curr_state(curr_state)
);

dp dp_traffic_light(
    .clk(clk),
    .rst(rst),
    .done_state(done_state),
    .dp_cnt_rst(dp_cnt_rst),
    .curr_state(curr_state)
);

endmodule
