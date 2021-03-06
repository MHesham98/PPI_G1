module INOUT_Mode(A, WRITE , READ, DATA, PortA, PortB, PortC);

//Defining the arguments and their address size
inout [7:0]DATA;
inout [7:0]PortA;
inout [7:0]PortB;
inout [7:0]PortC;

input [1:0] A;
input WRITE, READ;

//register to save the last control register
reg [7:0]Control_Register;

always @ (DATA, A, WRITE, READ)
begin
//multiplexing either inout or writing in the control register

if(A == 3)
begin
Control_Register = DATA;
end
else if(A == 2)
begin
INOUT_C(WRITE,READ,Control_Register,DATA,PortC);
end
else if(A == 1)
begin
INOUT_B(WRITE,READ,Control_Register,DATA,PortB);
end
else if(A == 0)
begin
INOUT_A(WRITE,READ,Control_Register,DATA,PortA);
end


end
endmodule
