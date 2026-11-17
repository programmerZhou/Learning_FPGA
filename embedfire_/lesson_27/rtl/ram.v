module ram 
(
    input   wire            sys_clk     , 
    input   wire            sys_rst_n   , 
    input   wire            rd_key      , 
    input   wire            rw_key      , 

    output  wire            ds          , 
    output  wire            shcp        , 
    output  wire            stcp        , 
    output  wire            oe          
);

wire    [23:0]  bcd_data    ;

wire            wr_key_pluse;
wire            rd_key_pluse;
                            
wire            wren        ;
wire    [7:0]   address     ;
wire    [7:0]   wrdata      ;
wire            rden        ;

wire    [7:0]   dataout     ;


key_filter rdkey_filter
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .key_in      (rd_key   ), 
                 
    .key_pluse   (rd_key_pluse)
    
);

key_filter wrkey_filter
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .key_in      (rw_key   ), 
                 
    .key_pluse   (wr_key_pluse)
);


ram_controller ram_controller_inst
(
    .sys_clk     (sys_clk     ), 
    .sys_rst_n   (sys_rst_n   ), 
    .wr_key_pluse(wr_key_pluse), 
    .rd_key_pluse(rd_key_pluse), 

    .wren        (wren        ), 
    .address     (address     ), 
    .wrdata      (wrdata     ), 
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

    
bcd_converter bcd_converter_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 
    .data            ({12'b0, dataout}), 

    .bcd_data        (bcd_data )
);

display display_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 
    .data        (bcd_data ),  
    .point       ({6'b0}   ), 
    .sign        (1'b0     ),
    .enable      (1'b1     ), 

    .ds          (ds       ), 
    .shcp        (shcp     ), 
    .stcp        (stcp     ), 
    .oe          (oe       )

);

    


endmodule 