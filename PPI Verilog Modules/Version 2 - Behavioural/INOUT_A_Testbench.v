module INOUT_A_Testbench();

reg [7:0]Control_Register;
wire [7:0]DATA;
wire [7:0]PortA;
wire [7:0]PortB;
wire [7:0]PortC;
reg READ,WRITE;

reg[1:0]A;

reg [7:0]DATA_reg;
reg [7:0]PortA_reg;
reg [7:0]PortB_reg;
reg [3:0]PortC_U_reg;
reg [3:0]PortC_L_reg;

assign DATA = DATA_reg;
assign PortA = PortA_reg;
assign PortB = PortB_reg;
assign PortC = {PortC_U_reg,PortC_L_reg};

initial
begin
$monitor("A = %b  ||  DATA = %d  || PortA = %d || PortB = %d || PortC = %d",A, DATA , PortA, PortB, PortC);

READ <= 1;
WRITE <= 0;
A = 2'b11;
DATA_reg <= 8'b1001_1011;

#10
READ <= 0;
WRITE <= 1;
A=00;
PortA_reg <= 255;

#10
PortA_reg <= 8;


#10
PortA_reg <= 9;
#10
PortA_reg <= 3;
#10
PortA_reg <= 1;
end

INOUT_Mode_Case a(A, WRITE , READ, DATA, PortA, PortB, PortC);

endmodule
