module rom 
(
    input   wire            sys_clk     , 
    input   wire            sys_rst_n   , 
    input   wire            key1        , 
    input   wire            key2        , 

    output  wire            ds          , 
    output  wire            shcp        , 
    output  wire            stcp        , 
    output  wire            oe          
);

wire            key_pluse1  ; 
wire            key_pluse2  ; 

wire    [7:0]   address     ; 
wire    [7:0]   data        ;
wire    [23:0]  bcd_data    ;

key_filter key_filter1
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .key_in      (key1   ), 
                 
    .key_pluse   (key_pluse1)
    
);

key_filter key_filter2
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .key_in      (key2   ), 
                 
    .key_pluse   (key_pluse2)
);

rom_controller rom_controller
(
    .sys_clk     (sys_clk  ), 
    .sys_rst_n   (sys_rst_n), 
    .key1        (key1     ), 
    .key2        (key2     ), 
    
    .address     (address  )
); 

rom_8x256	rom_8x256_inst (
	.address ( address ),
	.clock ( sys_clk ),
	.q ( data )
	);
    
    
bcd_converter bcd_converter_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 
    .data            ({12'b0, data}), 

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