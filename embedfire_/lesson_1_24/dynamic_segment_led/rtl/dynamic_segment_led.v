module  dynamic_segment_led
(   
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   , 
    
    output  wire            ds          , 
    output  wire            shcp        , 
    output  wire            stcp        , 
    output  wire            oe
   
);

wire    [19:0]  data   ;
wire    [5:0]   point  ;
wire            sign   ;
wire            enable ;


wire     [5:0]   sel         ;
wire     [7:0]   seg         ;
wire     [23:0]  bcd_data    ; 

data_generator data_generator_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 

    .data            (data     ),
    .point           (point    ),
    .sign            (sign     ), 
    .enable          (enable   )
);

bcd_converter bcd_converter_inst
(
    .sys_clk         (sys_clk  ), 
    .sys_rst_n       (sys_rst_n), 
    .data            (data     ), 

    .bcd_data        (bcd_data )
);

display display_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 
    .data        (bcd_data ),  
    .point       (point    ), 
    .sign        (sign     ),
    .enable      (enable   ), 

    .ds          (ds       ), 
    .shcp        (shcp     ), 
    .stcp        (stcp     ), 
    .oe          (oe       )

);

       
endmodule 