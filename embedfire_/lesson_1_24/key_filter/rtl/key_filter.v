module key_filter
#(
    parameter   CNT_MAX     = 20'd999_999
) 
(
    input   wire        sys_clk     , 
    input   wire        sys_rst_n   , 
    input   wire        key_in      , 
    
    output  reg         key_pluse   
    
);

reg     [19:0]          cnt         ; 

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        cnt <= 20'd0; 
    else if (key_in == 1'b1) 
        cnt <= 20'd0; 
    else if (cnt == CNT_MAX) 
        cnt <= CNT_MAX;
    else 
        cnt <= cnt + 1; 
        
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        key_pluse <= 1'b0; 
    else if (cnt == (CNT_MAX - 1)) 
        key_pluse <= 1'b1; 
    else 
        key_pluse <= 1'b0; 
        
        
endmodule 
