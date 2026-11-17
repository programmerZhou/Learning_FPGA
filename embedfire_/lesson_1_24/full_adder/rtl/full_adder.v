module full_adder 
(
    input   wire    addend,
    input   wire    augend, 
    input   wire    carry_in,
    
    output  wire    sum,
    output  wire    carry_out 
);

wire    inst0_sum; 
wire    inst0_carry; 
wire    inst1_carry; 

half_adder half_adder_inst0 
(
.addend(addend), 
.augend(carry_in), 

.sum(inst0_sum), 
.carry(inst0_carry)
);

half_adder half_adder_inst1
(
.addend(inst0_sum), 
.augend(augend), 

.sum(sum), 
.carry(inst1_carry)
);

assign carry_out = (inst0_carry | inst1_carry);
endmodule