`timescale  1ns/1ns

module  tb_data_generator(); 

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

wire    [19:0]  data   ;
wire    [5:0]   point  ;
wire            sign   ;
wire            enable ;

data_generator 
#(
    .CNT_MAX     (23'd4_9 )  ,
    .DATA_MAX    (20'd999_999)
)
data_generator_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 

    .data            (data     ),
    .point           (point    ),
    .sign            (sign     ), 
    .enable          (enable   )
);


endmodule 