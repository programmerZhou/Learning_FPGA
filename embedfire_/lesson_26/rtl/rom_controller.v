module  rom_controller
#(
    parameter   CNT_MAX = 24'd9_999_999 
)
(
    input   wire            sys_clk     , 
    input   wire            sys_rst_n   , 
    input   wire            key1        , 
    input   wire            key2        , 
    
    output  reg     [7:0]   address     
); 


reg     [23:0]  timer   ; 
reg             key1_enable ;
reg             key2_enable ;


always @(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        timer <= 24'd0; 
    else  if (timer == CNT_MAX || key1_enable || key2_enable) 
        timer <= 24'd0; 
    else 
        timer <= timer + 24'd1; 

always @(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        key1_enable <= 1'b0; 
    else if (key2 == 1'b1) 
        key1_enable <= 1'b0; 
    else if (key1 == 1'b1) 
        key1_enable <= ~key1_enable;
    else 
        key1_enable <= key1_enable;

always @(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        key2_enable <= 1'b0; 
    else if (key1 == 1'b1) 
        key2_enable <= 1'b0; 
    else if (key2 == 1'b1) 
        key2_enable <= ~key2_enable;
    else 
        key2_enable <= key2_enable;

always @(posedge sys_clk or negedge sys_rst_n) 
    if(sys_rst_n == 1'b0) 
        address <= 8'b0; 
    else if (address == 8'd255 && timer == CNT_MAX) 
        address <= 8'b0; 
    else if (key1_enable == 1'b1) 
        address <= 8'd99; 
    else if (key2_enable == 1'b1) 
        address <= 8'd199; 
    else if (timer == CNT_MAX )
        address <= address + 8'b1; 
    else 
        address <= address;


endmodule 
