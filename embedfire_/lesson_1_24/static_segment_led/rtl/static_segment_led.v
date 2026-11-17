module  static_segment_led
#(
    parameter   CNT_MAX =   25'd24_999_999
)
(   
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   , 
    
    output  wire            ds          , 
    output  wire            shcp        , 
    output  wire            stcp        , 
    output  wire            oe
   
);

wire     [5:0]   sel         ;
wire     [7:0]   seg         ;
segment_selecter
#(
    .CNT_MAX    (25'd24_999_999)
)segment_selecter_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 
    
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