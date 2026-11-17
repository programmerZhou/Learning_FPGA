module data_generator 
#(
    parameter   CNT_MAX     =   23'd4_999_999,
    parameter   DATA_MAX    =   20'd999_999
)
(
    input   wire            sys_clk         , 
    input   wire            sys_rst_n       , 
    
    output  reg     [19:0]  data            ,
    output  wire    [5:0]   point           ,
    output  wire            sign            , 
    output  reg             enable          
);

reg     [22:0]  counter ;
reg             counter_pluse ;

assign  point = 6'b000_000; 
assign  sign  = 1'b0; 

always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0)  
        counter <= 23'd0;
    else if(counter == CNT_MAX) 
        counter <= 23'd0; 
    else 
        counter <= counter + 1'b1; 
  
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0)
        counter_pluse <= 1'b0; 
    else if(counter == CNT_MAX - 1) 
        counter_pluse <= 1'b1; 
    else 
        counter_pluse <= 1'b0; 
        
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0)
        data <= 20'd0; 
    else if (data == DATA_MAX) 
        data <= 20'd0; 
    else if (counter_pluse == 1'b1) 
        data <= data + 20'd1;
    else 
        data <= data; 
        



always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0)
        enable <= 1'b0;
    else 
        enable <= 1'b1; 
        
endmodule
