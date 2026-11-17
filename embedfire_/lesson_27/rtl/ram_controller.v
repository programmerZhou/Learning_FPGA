module ram_controller
#(
    parameter   CNT_MAX  =   24'd9_999_999
)
(
    input   wire            sys_clk     , 
    input   wire            sys_rst_n   , 
    input   wire            wr_key_pluse, 
    input   wire            rd_key_pluse, 

    output  reg             wren        , 
    output  reg     [7:0]   address     , 
    output  wire    [7:0]   wrdata      , 
    output  reg             rden          
);

reg    [23:0]   cnt         ;

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        cnt <= 24'd0; 
    else if (cnt == CNT_MAX || wr_key_pluse == 1'b1 
        || rd_key_pluse == 1'b1) 
        cnt <= 24'd0; 
    else if (rden == 1'b1)
        cnt <= cnt + 1; 
    else  
        cnt <= cnt;

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        wren <= 1'b0; 
    else if (address == 8'd255)
        wren <= 1'b0; 
    else if (wr_key_pluse == 1'b1) 
        wren <= 1'b1;
    else  
        wren <= wren;

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        address <= 8'b0; 
    else if ((address == 8'd255  && wren == 1'b1)
            ||(address == 8'd255  && cnt == CNT_MAX)
            || wr_key_pluse == 1'b1 
            || rd_key_pluse == 1'b1)
        address <= 8'b0; 
    else if ((wren == 1'b1) || (rden == 1 && cnt == CNT_MAX))
        address <= address + 8'b1;
    else     
        address <= address;
        
assign wrdata = (wren == 1'b1) ? address : 8'b0; 

always@(posedge sys_clk or negedge sys_rst_n)
    if (sys_rst_n == 1'b0) 
        rden <= 1'b0; 
    else if (wr_key_pluse == 1'b1)
        rden <= 1'b0; 
    else if (rd_key_pluse == 1'b1 && wren == 1'b0) 
        rden <= 1'b1; 
    else  
        rden <= rden;

endmodule