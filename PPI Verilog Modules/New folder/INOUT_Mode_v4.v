/*module INOUT_Mode_v4(DATA, PortA, PortB, PortC,ENABLE, A);

inout [7:0]DATA;
inout [7:0]PortA;
inout [7:0]PortB;
inout [7:0]PortC;
input [1:0]A;

always @ (DATA, PortA, PortB, PortC, A)
begin
if(ENABLE == 1)
begin
Write_On_DATA WOD(DATA, PortA, PortB, PortC, A);
end

end






endmodule
*/