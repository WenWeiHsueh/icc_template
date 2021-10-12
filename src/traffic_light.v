`include "define.v"

module traffic_light (
    input  clk,
    input  rst,
    input  pass,
    output R,
    output G,
    output Y
);

// DO NOT FORGET TO DO THIS.
wire [`STATE_W-1:0] curr_state;
wire [`STATE_DONE_W-1:0] done_state;

ctrl ctrl_traffic_light(
    .clk(clk),
    .rst(rst),
    .pass(pass),
    .done_state(done_state),
    .dp_cnt_rst(dp_cnt_rst),
    .curr_state(curr_state)// in the () is not the default name
);

dp dp_traffic_light(
    .clk(clk),
    .rst(rst),
    .done_state(done_state),
    .dp_cnt_rst(dp_cnt_rst),
    .curr_state(curr_state),
    .R(R),
    .G(G),
    .Y(Y)
);

endmodule
