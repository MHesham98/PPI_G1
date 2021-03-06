module New_TOP(A,READ,WRITE,CS,RESET,DATA,PortA,PortB,PortC);

input [1:0] A;

input READ,WRITE,CS,RESET;

inout [7:0]DATA;
inout [7:0]PortA;
inout [7:0]PortB;
inout [7:0]PortC;


reg [7:0]DATA_reg;
reg [7:0]PortA_reg;
reg [7:0]PortB_reg;
reg [7:0]PortC_reg;


reg[7:0] Control_Register;



assign DATA = (WRITE && ~READ && ~CS && ~RESET)?DATA_reg:(CS)?DATA_reg:8'bzzzz_zzzz;
assign PortA = (~WRITE && READ && ~CS && ~RESET)?PortA_reg:(CS)?PortA_reg:8'bzzzz_zzzz;
assign PortB = (~WRITE && READ && ~CS && ~RESET)?PortB_reg:(CS)?PortB_reg:8'bzzzz_zzzz;
assign PortC = (~WRITE && READ && ~CS && ~RESET)?PortC_reg:(CS)?PortC_reg:8'bzzzz_zzzz;


always @ (A,READ,WRITE,CS,RESET,DATA,PortA,PortB,PortC)
begin

case(A)
2'b11: Control_Register <= DATA;
endcase

if(RESET)
begin
//Setting all Ports to Input mode
Control_Register = 8'b10011011;
end


if(Control_Register[7] == 1)
begin

if(WRITE && ~READ && ~CS && ~RESET)
begin
case(A)
2'b00: if(Control_Register[7:4] == 4'b1000) begin DATA_reg <= PortA;  end
2'b01: if({Control_Register[7],Control_Register[2],Control_Register[1]} == 3'b100) begin DATA_reg <= PortB; end
2'b10: if({Control_Register[7:5],Control_Register[3],Control_Register[0]} == 5'b10000)begin DATA_reg <= PortC; end 

endcase
/*
2'b00: if(Control_Register[7:4] == 4'b1000) begin DATA_reg <= PortA;  end
2'b01: if({Control_Register[7],Control_Register[2],Control_Register[1]} == 3'b100) begin DATA_reg <= PortB; end
2'b10: if({Control_Register[7:5],Control_Register[3],Control_Register[0]} == 5'b10000)begin DATA_reg <= PortC; end




2'b00: DATA_reg <= PortA;
2'b01: DATA_reg <= PortB;
2'b10: DATA_reg <= PortC; 
*/

end

else if(~WRITE && READ && ~CS && ~RESET)
begin
case(A)
2'b00: if(Control_Register[7:4] == 4'b1001) begin PortA_reg <= DATA;  end
2'b01: if({Control_Register[7],Control_Register[2],Control_Register[1]} == 3'b101) begin PortB_reg <= DATA; end
2'b10: if({Control_Register[7:5],Control_Register[3],Control_Register[0]} == 5'b10011)begin PortC_reg <= DATA; end
2'b11: Control_Register <= DATA;
endcase
/*2'b00: if(Control_Register[7:4] == 4'b1001) begin PortA_reg <= DATA;  end
2'b01: if({Control_Register[7],Control_Register[2],Control_Register[1]} == 3'b101) begin PortB_reg <= DATA; end
2'b10: if({Control_Register[7:5],Control_Register[3],Control_Register[0]} == 5'b10011)begin PortC_reg <= DATA; end
2'b11: Control_Register <= DATA;

2'b00: PortA_reg <= DATA; 
2'b01:  PortB_reg <= DATA;
2'b10: PortC_reg <= DATA;
2'b11: Control_Register <= DATA;



*/
end

/*
else if(CS)
begin
DATA_reg <= DATA_reg;
PortA_reg <= 8'bzzzz_zzzz;
PortB_reg <= 8'bzzzz_zzzz;
PortC_reg <= 8'bzzzz_zzzz;
end
*/

end



else if(Control_Register[7] == 0)
begin


PortC_reg[DATA[3:1]] <= DATA[0];

end

else

PortC_reg = 8'bzzzz_zzzz;

end
endmodule
