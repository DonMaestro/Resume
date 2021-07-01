module rom
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=8)
(
	input [(ADDR_WIDTH-1):0] i_addr,
	output [(DATA_WIDTH-1):0] o_data
);

reg	[(DATA_WIDTH-1):0]	m_rom[0:(2**ADDR_WIDTH)-1];

initial begin
$readmemh("rom_init.dat", m_rom);
end

assign o_data = m_rom[i_addr];


endmodule
