`timescale  1ns/1ns

module  tb_bcd_converter(); 

reg     sys_clk     ; 
reg     sys_rst_n   ; 
reg     [19:0] data;

wire    [23:0]  bcd_data; 

integer i; 
initial     
begin 
    sys_clk  = 1'b1;
    sys_rst_n <= 1'b0; 
    data <= 20'b0;
    #20 
    sys_rst_n <= 1'b1; 
    for (i=0; i<999999; i=i+1)begin 
        data <= i; 
        #3000   ; 
    end
end

always #10  sys_clk = ~sys_clk; 

bcd_converter bcd_converter_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 
    .data            (data     ), 

    .bcd_data        (bcd_data )
); 
endmodule 