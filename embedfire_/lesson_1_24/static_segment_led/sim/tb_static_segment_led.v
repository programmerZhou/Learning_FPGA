`timescale  1ns/1ns

module  tb_static_segment_led(); 

reg     sys_clk     ; 
reg     sys_rst_n   ; 

initial     
begin 
    sys_clk  = 1'b1;
    sys_rst_n <= 1'b0; 
    #20 
    sys_rst_n <= 1'b1; 
end

always #10  sys_clk = ~sys_clk; 

wire            ds          ; 
wire            shcp        ; 
wire            stcp        ; 
wire            oe          ;

static_segment_led static_segment_led_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 

    .ds          (ds       ), 
    .shcp        (shcp     ), 
    .stcp        (stcp     ), 
    .oe          (oe       )
);

endmodule 