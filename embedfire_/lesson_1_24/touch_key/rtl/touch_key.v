module touch_key
(
    input   wire        sys_clk     , 
    input   wire        sys_rst_n   , 
    input   wire        touch_key   , 
    
    output  reg         led_out
    
);

reg     touch_key_1; 
reg     touch_key_2; 
wire    touch_pluse; 

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        begin 
            touch_key_1 <= 1'b1; 
            touch_key_2 <= 1'b1; 
        end 
    else 
        begin   
            touch_key_1 <= touch_key; 
            touch_key_2 <= touch_key_1;
        end 
        
assign touch_pluse = ((touch_key_1 == 1'b0) && (touch_key_2== 1'b1)); 

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        led_out <= 1'b1;
    else if(touch_pluse == 1'b1) 
        led_out <= ~led_out; 
    else 
        led_out <= led_out; 
        
endmodule 
