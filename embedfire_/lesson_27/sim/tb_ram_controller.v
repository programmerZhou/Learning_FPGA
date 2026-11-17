`timescale  1ns/1ns 
module tb_ram_controller(); 

reg             sys_clk     ;
reg             sys_rst_n   ;
reg             wr_key_pluse;
reg             rd_key_pluse;
                            
wire            wren        ;
wire    [7:0]   address     ;
wire    [7:0]   wrdata      ;
wire            rden        ;

wire    [7:0]   dataout     ;


initial     
    begin 
        sys_clk = 1'b1; 
        sys_rst_n  <= 1'b0; 
        wr_key_pluse <= 1'b0; 
        rd_key_pluse <= 1'b0;
        #20
        sys_rst_n <= 1'b1; 
        #1000
        rd_key_pluse <= 1'b1;
        #20
        rd_key_pluse <= 1'b0; 
        #60000 
        wr_key_pluse <= 1'b1; 
        #20 
        wr_key_pluse <= 1'b0; 
        #6000
        
        rd_key_pluse <= 1'b1;
        #20
        rd_key_pluse <= 1'b0; 
        #6000
        
        rd_key_pluse <= 1'b1;
        #20
        rd_key_pluse <= 1'b0; 

    end
    

always #10  sys_clk = ~sys_clk;

ram_controller
#(
    .CNT_MAX    (24'd9)
)ram_controller_inst
(
    .sys_clk     (sys_clk     ), 
    .sys_rst_n   (sys_rst_n   ), 
    .wr_key_pluse(wr_key_pluse), 
    .rd_key_pluse(rd_key_pluse), 

    .wren        (wren        ), 
    .address     (address     ), 
    .wrdata      (wrdata      ), 
    .rden        (rden        )  
);

ram_8x256_one	ram_8x256_one_inst (
	.aclr       ( ~sys_rst_n ),
	.address    ( address ),
	.clock      ( sys_clk ),
	.data       ( wrdata ),
	.rden       ( rden ),
	.wren       ( wren),
	.q          ( dataout )
	);




endmodule 