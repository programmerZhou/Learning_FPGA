module  display
(   
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   , 
    input   wire    [23:0]  data        ,  
    input   wire    [5:0]   point       , 
    input   wire            sign        ,
    input   wire            enable      , 
    
    output  wire            ds          , 
    output  wire            shcp        , 
    output  wire            stcp        , 
    output  wire            oe          
    
);

wire    [7:0]   seg         ;
wire    [5:0]   sel         ;


selection_signal_generator selection_signal_generator_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 
    .data        (data     ),  
    .point       (point    ), 
    .sign        (sign     ),
    .enable      (enable   ), 

    .sel         (sel      ), 
    .seg         (seg      )
);

controller controller_inst
(   
    .sys_clk     (sys_clk     ),
    .sys_rst_n   (sys_rst_n   ), 
    .sel         (sel         ), 
    .seg         (seg         ),

    .ds          (ds          ), 
    .shcp        (shcp        ), 
    .stcp        (stcp        ), 
    .oe          (oe          )
);





endmodule 