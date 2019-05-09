library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_vga is
port( mclk, clr: in STD_LOGIC;
    hsync, vsync,hsyncmeasure,vsyncmeasure: out STD_LOGIC;
    rojo,verde: out STD_LOGIC_VECTOR(2 downto 0);
    azul: out STD_LOGIC_VECTOR(1 downto 0);
	 --data: in STD_LOGIC_VECTOR(7 downto 0);
	 clk:	inout	STD_LOGIC;
	 cs:	inout	STD_LOGIC;
	 rx:	in STD_LOGIC
);
end top_vga;

architecture top_vga of top_vga is
component video is
port(
    vidon: in STD_LOGIC;
    hc, vc: in STD_LOGIC_VECTOR(9 downto 0);
    rojo,verde: out STD_LOGIC_VECTOR(2 downto 0);
    azul: out STD_LOGIC_VECTOR(1 downto 0);
	 data: in STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component vga_640x480 is
port( clr,clk25: in STD_LOGIC;
    hsync, vsync,hsyncmeasure,vsyncmeasure: out STD_LOGIC;
    hc,vc: out STD_LOGIC_VECTOR(9 downto 0);
    vidon: out STD_LOGIC
    );
end component;

component clkdiv is
port(
    mclk, clr: in STD_LOGIC;
    clk25: OUT STD_LOGIC;
	clk	:	OUT	STD_LOGIC;
	 cs	:	OUT	STD_LOGIC
);
end component;

component Lectura is
	Port(		clk: in STD_LOGIC;
				cs:	in STD_LOGIC;
				rx:	in STD_LOGIC;
				data: out STD_LOGIC_VECTOR(7 downto 0)
		);
end component;
signal clk25s, vidons: STD_LOGIC;
signal hcs, vcs: STD_LOGIC_VECTOR(9 downto 0);
signal data: STD_LOGIC_VECTOR(7 downto 0);

begin
    U1: vga_640x480 port map (clr => clr, clk25 => clk25s, hsync => hsync,
    vsync => vsync, hsyncmeasure => hsyncmeasure, vsyncmeasure => vsyncmeasure, hc=>hcs, vc=>vcs, vidon=>vidons);
    U2: video port map (vidon => vidons, hc => hcs, vc => vcs, rojo => rojo,
    verde => verde, azul => azul,data => data);
    U3: clkdiv port map (mclk => mclk, clr => clr, clk25 => clk25s, clk => clk, cs => cs);
	 U4: Lectura port map (clk => clk, cs => cs, data => data, rx => rx);
end top_vga;

