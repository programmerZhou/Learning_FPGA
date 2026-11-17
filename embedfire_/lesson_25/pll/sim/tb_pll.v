
`timescale  1ns/1ns

module  tb_pll(); 

reg     sys_clk     ; 

wire    sys_mul_2   ;
wire    clk_div     ;
wire    clk_pha_90  ;
wire    clk_duc_20  ;
wire    locked      ;

initial     
begin 
    sys_clk = 1'b1; 
end

always #10  sys_clk = ~sys_clk; 

pll pll_inst
(
    .sys_clk     (sys_clk    ),

    .sys_mul_2   (sys_mul_2  ), 
    .clk_div     (clk_div    ), 
    .clk_pha_90  (clk_pha_90 ), 
    .clk_duc_20  (clk_duc_20 ), 
    .locked      (locked     )
);

endmodule 