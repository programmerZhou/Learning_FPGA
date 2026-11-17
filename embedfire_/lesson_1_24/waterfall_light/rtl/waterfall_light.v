module waterfall_light
#(
    parameter   CNT_MAX     =   25'd24_999_999
)
(
    input   wire            sys_clk     , 
    input   wire            sys_rst_n   , 
    
    output  reg     [3:0]   led_out     
);

reg     [24:0]  cnt; 
reg             pluse; 

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        cnt <= 25'd0; 
    else if (cnt == CNT_MAX) 
        cnt <= 25'd0; 
    else    
        cnt <= cnt + 25'd1; 

always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        pluse <= 1'b0; 
    else if (cnt == (CNT_MAX - 25'd1)) 
        pluse <= 1'b1; 
    else 
        pluse <= 1'b0; 
        
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        led_out <= 4'b1110; 
    else if (pluse == 1'b1)
        led_out <= {led_out[2:0], led_out[3]}; 
    else 
        led_out <= led_out; 
        
endmodule 