`timescale  1ns/1ns

module tb_full_adder(); 
reg     addend; 
reg     augend; 
reg     carry_in; 

wire    sum; 
wire    carry_out; 

initial 
    begin 
        addend = 1'b0; 
        augend = 1'b0; 
        carry_in = 1'b0; 
    end 
    
initial 
    begin 
        $timeformat(-9,0,"ns",6); 
        $monitor("@time %t:addend%b,augend=%b,carry_in=%b,sum=%b,carry_out=%b", $time, addend, augend, carry_in, sum, carry_out); 
    end
     
always  #10 addend <= {$random} % 2;  
always  #10 augend <= {$random} % 2;  
always  #10 carry_in <= {$random} % 2;  

full_adder full_adder_inst 
(
.addend(addend),
.augend(augend), 
.carry_in(carry_in),

.sum(sum),
.carry_out(carry_out) 
);

endmodule 