module  bcd_converter 
(
    input   wire            sys_clk         , 
    input   wire            sys_rst_n       , 
    input   wire    [19:0]  data            , 
    
    output  reg     [23:0]  bcd_data        

); 

reg     [4:0]   shift_counter   ; 
reg     [43:0]  inner_data      ; 
reg             shift_pluse     ; 

always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        shift_counter <= 5'd0; 
    else if (shift_counter == 5'd21 && shift_pluse == 1'b1) 
        shift_counter <= 5'd0; 
    else if (shift_pluse == 1'b1) 
        shift_counter <= shift_counter + 5'd1;
    else 
        shift_counter <= shift_counter; 
        
      
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        inner_data <= 44'b0;
    else if (shift_counter == 5'd0)
        inner_data <= {24'b0, data};
    else if ((shift_counter <= 5'd20) && (shift_pluse == 1'b0))
    begin 
        inner_data[23:20] <= (inner_data[23:20] > 4) ? 
            (inner_data[23:20] + 4'd3) : inner_data[23:20];
        inner_data[27:24] <= (inner_data[27:24] > 4) ? 
            (inner_data[27:24] + 4'd3) : inner_data[27:24];
        inner_data[31:28] <= (inner_data[31:28] > 4) ? 
            (inner_data[31:28] + 4'd3) : inner_data[31:28];
        inner_data[35:32] <= (inner_data[35:32] > 4) ? 
            (inner_data[35:32] + 4'd3) : inner_data[35:32];
        inner_data[39:36] <= (inner_data[39:36] > 4) ? 
            (inner_data[39:36] + 4'd3) : inner_data[39:36];
        inner_data[43:40] <= (inner_data[43:40] > 4) ? 
            (inner_data[43:40] + 4'd3) : inner_data[43:40];
    end
    else if ((shift_counter <= 5'd20) && (shift_pluse == 1'b1))
        inner_data <= inner_data << 1; 
    else 
        inner_data <= inner_data; 

always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        shift_pluse <= 1'b1; 
    else 
        shift_pluse <= ~shift_pluse;

always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0) 
        bcd_data <= 24'b0; 
    else if ((shift_counter == 21) && (shift_pluse == 1'b1))
        bcd_data <= inner_data[43:20];
    else 
        bcd_data <= bcd_data;
        
    
        
    
endmodule 