module half_adder
(
    input   wire        addend, 
    input   wire        augend, 
    
    output  wire        sum, 
    output  wire        carry
);

assign {carry, sum} = addend + augend;

endmodule 

    