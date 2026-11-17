module  tb_display(); 

reg             sys_clk     ; 
reg             sys_rst_n   ; 
reg     [23:0]  data        ;
reg     [5:0]   point       ; 
reg             sign        ;
reg             enable      ; 

wire            ds          ; 
wire            shcp        ; 
wire            stcp        ; 
wire            oe          ;
    
initial     
begin 
    sys_clk  = 1'b1;
    sys_rst_n <= 1'b0; 
    data <= 20'b0;
    point <= 6'b000_010; 
    sign  <= 1'b0; 
    enable <= 1'b1; 
    #20 
    sys_rst_n <= 1'b1; 
    data <= 24'h123_456; 
    #3000
    data <= 24'h654_321; 
    #3000
    data <= 24'h987_654; 
    #3000 
    data <= 20'h999_999;
end

display display_inst
(   
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n), 
    .data        (data     ),  
    .point       (point    ), 
    .sign        (sign     ),
    .enable      (enable   ), 

    .ds          (ds       ), 
    .shcp        (shcp     ), 
    .stcp        (stcp     ), 
    .oe          (oe       )

);


endmodule 