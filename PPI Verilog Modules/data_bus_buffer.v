module data_bus_buffer(DOUT, control_signal, DIN, PD);

output DOUT;
//output of the tristate buffer into the internal bus

input DIN;
//input of the tristate buffer from the internal bus

input control_signal;
//determines the direction of the data bus (0 => output) (1 => input)

inout [7:0]PD;
//connected to the system data bus. Transfers data, control word or status information



//_________________________________________________________________________________________//

assign DIN = PD;
//in case of output mode

assign PD = (control_signal || control_signal == 1'bZ || control_signal == 1'bX)? DOUT: 8'bZZZZ_ZZZZ;
//if control_signal==1 or Z or X => input  => DOUT goes into PD (input)
//if control_signal==0           => output => DOUT is floating and derived externally (output)

endmodule
