module pll
(
    input   wire    sys_clk     , 
 
    
    
    output  wire    sys_mul_2   , 
    output  wire    clk_div     , 
    output  wire    clk_pha_90  , 
    output  wire    clk_duc_20  , 
    output  wire    locked       
   


);


pll_ip pll_ip_inst(
    .inclk0 (sys_clk),
    .c0     (sys_mul_2    ),
    .c1     (clk_div    ),
    .c2     (clk_pha_90    ),
    .c3     (clk_duc_20    ), 
    .locked (locked)
);

endmodule 