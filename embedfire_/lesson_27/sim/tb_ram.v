`timescale  1ns/1ns 
module tb_ram(); 

reg             sys_clk     ; 
reg             sys_rst_n   ; 
reg             rd_key      ; 
reg             rw_key      ; 

wire            ds          ; 
wire            shcp        ; 
wire            stcp        ; 
wire            oe          ;


initial     
    begin 
        sys_clk = 1'b1; 
        rd_key <= 1'b1; 
        rw_key <= 1'b1;
        sys_rst_n  <= 1'b0; 
        #20
        sys_rst_n <= 1'b1; 
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1; 
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1; 
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1; 
        #20
        rd_key <= 1'b0;
        #200 
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1;
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1;
        #20
        rd_key <= 1'b0;
        #20
        rd_key <= 1'b1;
       
    end
    

always #10  sys_clk = ~sys_clk;



ram ram_inst
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .rd_key      (rd_key   ), 
    .rw_key      (rw_key   ), 

    .ds          (ds       ), 
    .shcp        (shcp     ), 
    .stcp        (stcp     ), 
    .oe          (oe       )
);

defparam ram_inst.ram_controller_inst.CNT_MAX = 24'd9;
defparam ram_inst.rdkey_filter.CNT_MAX = 0; 
defparam ram_inst.wrkey_filter.CNT_MAX = 0; 



endmodule 