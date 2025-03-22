module pipe_stage(
    input clk,
    input rst_n,

    input in_vld,
    output in_rdy,
    input [15:0]in_data,

    output out_vld,
    input out_rdy,
    output [15:0]out_data

);
assign in_rdy = (~out_vld) || out_rdy;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        out_data <= 0;
    else if(in_vld && in_rdy)
        out_data <= in_data;
end

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)
        out_vld <= 0;
    else if(in_rdy)
        out_vld <= in_vld;
end

endmodule