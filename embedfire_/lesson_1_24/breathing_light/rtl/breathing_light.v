module  breathing_light
#(
    parameter   CNT_US_MAX = 6'd49     ,
    parameter   CNT_MS_MAX = 10'd999   ,
    parameter   CNT_S_MAX = 10'd999    

)
(
    input   wire        sys_clk         , 
    input   wire        sys_rst_n       , 
    
    output  reg         led_out         
);

reg     [5:0]       cnt_us  ; 
reg     [9:0]       cnt_ms  ;
reg     [9:0]       cnt_s   ;
reg                 direction;  

always@(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        cnt_us <= 6'd0; 
    else if (cnt_us == CNT_US_MAX) 
        cnt_us <= 6'd0; 
    else 
        cnt_us <= cnt_us +  6'd1; 

always@(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        cnt_ms <= 10'd0; 
    else if (cnt_ms == CNT_MS_MAX && cnt_us == CNT_US_MAX ) 
        cnt_ms <= 10'd0; 
    else if (cnt_us == CNT_US_MAX)
        cnt_ms <= cnt_ms +  10'd1; 
    else 
        cnt_ms <= cnt_ms;
        
always@(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        cnt_s <= 10'd0; 
    else if (cnt_s == CNT_S_MAX && cnt_ms == CNT_MS_MAX && cnt_us == CNT_US_MAX ) 
        cnt_s <= 10'd0; 
    else if (cnt_ms == CNT_MS_MAX && cnt_us == CNT_US_MAX)
        cnt_s <= cnt_s +  10'd1; 
    else 
        cnt_s <= cnt_s;

always@(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        direction <= 1'd0; 
    else if (cnt_s == CNT_S_MAX && cnt_ms == CNT_MS_MAX && cnt_us == CNT_US_MAX ) 
        direction <= ~direction;
   
    else 
        direction <= direction;
        
always@(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        led_out <= 1'd1; 
    else if (((direction == 1'b0) && (cnt_ms <= cnt_s)) 
            || ((direction == 1'b1)&& (cnt_ms > cnt_s)))
        led_out <= 1'd0; 
   
    else 
        led_out <= 1'd1; 

        
endmodule 