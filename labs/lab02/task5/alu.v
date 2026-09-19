module alu (
    input [3:0] a,
    input [3:0] b,
    input op,              // 0 = add, 1 = sub
    output reg [3:0] result
);

reg [3:0] b_inv;
reg [3:0] b_twos;

always @(*) begin
    case (op)

        1'b0: begin
            result = a + b;        // add
        end

        1'b1: begin
            b_inv  = ~b;           // one's complement
            b_twos = b_inv + 1;    // two's complement
            result = a + b_twos;   // subtraction
        end

    endcase
end

endmodule
