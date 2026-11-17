module  selection_signal_generator
#(
    parameter   CNT_MAX =   16'd49_999
)
(   
    input   wire            sys_clk     ,
    input   wire            sys_rst_n   , 
    input   wire    [23:0]  data        ,  
    input   wire    [5:0]   point       , 
    input   wire            sign        ,
    input   wire            enable      , 
    
    output  reg     [5:0]   sel         , 
    output  reg     [7:0]   seg         
);

reg     [15:0]  timer         ;
reg             timer_pluse   ; 
reg     [2:0]   selecter      ;
reg     [3:0]   digit         ;
reg     [5:0]   inner_sel     ;
reg             dot           ;
wire    [23:0]  inner_data    ;

assign  inner_data = sign == 1'b1 ? 
            (data[23:4] == 20'b0 ? {16'HBBBB, 4'HA, data[3:0]} 
            :data[23:8] == 16'b0 ?{12'HBBB, 4'HA, data[7:0]} 
            : data[23:12] == 12'b0 ?{8'HBB, 4'HA, data[11:0]} 
            : data[23:16] == 8'b0 ?{4'HBB, 4'HA, data[15:0]}
            : data[23:20] == 4'b0 ?{4'HA, data[19:0]}: data):
             (data[23:4] == 20'b0 ?{20'HBBBBB, data[3:0]}
             :data[23:8] == 16'b0 ? {16'HBBBB, data[7:0]} 
            : data[23:12] == 12'b0 ?{12'HBBB, data[11:0]} 
            : data[23:16] == 8'b0 ?{8'HBB,  data[15:0]}
            : data[23:20] == 4'b0 ?{4'HB, data[19:0]} : data);
            
always@(posedge sys_clk or negedge sys_rst_n) 
    if (sys_rst_n == 1'b0)
        timer <= 15'd0; 
    else if(timer == CNT_MAX)
        timer <= 15'd0; 
    else 
        timer <= timer + 1'd1; 

always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        timer_pluse <= 1'b0; 
    else if(timer == CNT_MAX - 1) 
        timer_pluse <= 1'b1; 
    else 
        timer_pluse <= 1'b0; 
        
always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        selecter <= 3'd0; 
    else if (timer_pluse == 1'b1  && selecter == 3'd5) 
        selecter <= 3'd0;
    else if (timer_pluse == 1'b1) 
        selecter <= selecter + 3'd1; 
    else 
        selecter <= selecter;

always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        digit <= 4'd0;
    else 
        case (selecter) 
            4'd0: digit <= inner_data[3:0]; 
            4'd1: digit <= inner_data[7:4]; 
            4'd2: digit <= inner_data[11:8]; 
            4'd3: digit <= inner_data[15:12]; 
            4'd4: digit <= inner_data[19:16]; 
            4'd5: digit <= inner_data[23:20]; 
            default:digit <= inner_data[3:0]; 
        endcase 
 
always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        dot <= 1'b1;
    else 
        dot <= ~point[selecter];
        
always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        inner_sel <= 6'b000_001; 
    else 
        inner_sel <= 6'b000_001 << selecter;
        
always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        sel <= 6'b000_001; 
    else 
        sel <= inner_sel;

always@(posedge sys_clk or negedge sys_rst_n)     
    if (sys_rst_n == 1'b0) 
        seg <= 8'hff; 
    else case(digit)
        4'd0:   seg <=  {dot,7'b100_0000};
        4'd1:   seg <=  {dot,7'b111_1001};
        4'd2:   seg <=  {dot,7'b010_0100};
        4'd3:   seg <=  {dot,7'b011_0000};
        4'd4:   seg <=  {dot,7'b001_1001};
        4'd5:   seg <=  {dot,7'b001_0010};
        4'd6:   seg <=  {dot,7'b000_0010};
        4'd7:   seg <=  {dot,7'b111_1000};
        4'd8:   seg <=  {dot,7'b000_0000};
        4'd9:   seg <=  {dot,7'b001_0000};
        4'd10 : seg  <=  8'b1011_1111          ;    //显示负号
        4'd11 : seg  <=  8'b1111_1111          ;    //不显示任何字符
        default:seg  <=  8'b1100_0000;
    endcase
    

   
       
endmodule 