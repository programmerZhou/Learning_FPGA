`timescale  1ns/1ns

module tb_half_adder ();

reg     addend; 
reg     augend; 

wire    sum; 
wire    carry; 

initial 
    begin 
        addend <= 1'b0; 
        augend <= 1'b0; 
    end 

always #10 addend <= {$random} % 2; 
always #10 augend <= {$random} % 2; 


initial 
    begin 
        $timeformat(-9,0,"ns",6); 
        $monitor("@time %t:augend=%b,addend=%b,sum=%b,carry=%b", $time,addend, augend, sum, carry); 
    end
    
half_adder half_adder_inst 
(
    .addend(addend), 
    .augend(augend), 
    .sum(sum), 
    .carry(carry)
);
    
endmodule