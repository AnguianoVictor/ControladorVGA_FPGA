library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_640x480 is
port( clr,clk25: in STD_LOGIC;
        hsync, vsync,hsyncmeasure,vsyncmeasure: out STD_LOGIC;
        hc,vc: out STD_LOGIC_VECTOR(9 downto 0);
        vidon: out STD_LOGIC);
end vga_640x480;

architecture vga_640x480 of vga_640x480 is

constant hpixel: STD_LOGIC_VECTOR(9 downto 0):="1100100000";--800px
constant vlines: STD_LOGIC_VECTOR(9 downto 0):="1000001001";--521 px
constant hbp: STD_LOGIC_VECTOR(9 downto 0):="0010010000";--128+16=144px
constant hfp: STD_LOGIC_VECTOR(9 downto 0):="1100010000";--128+16+640=784px
constant vbp: STD_LOGIC_VECTOR(9 downto 0):="0000011111";--2+29=31px
constant vfp: STD_LOGIC_VECTOR(9 downto 0):="0111111111";--2+29+480=511px
signal hcs, vcs: STD_LOGIC_VECTOR(9 downto 0);--contadores vertical y horizontal
signal vflag: STD_LOGIC;-- Bandera para indicar que avance el contador de lineas verticales
signal hsyncm : STD_LOGIC;
signal vsyncm : STD_LOGIC;
begin
    -- Contador para la senal de sincron ˜ ıa vertical ´
    process(clr,clk25)
    begin
        if clr = '1' then
            hcs <= "0000000000";
        elsif(clk25 ='1' and clk25'event) then
            if(hcs = hpixel - 1) then
                hcs <= "0000000000";
                vflag <= '1'; --Habilita el contador vertical
            else
                hcs <= hcs +1;
                vflag <= '0';
            end if;
        end if;
    end process;

    --Contador para senal de sincron ˜ ıa horizontal ´
    process(clr, clk25)
    begin
        if(clr ='1') then
            vcs <= "0000000000";
        elsif (clk25 = '1' and clk25'event and vflag = '1') then
            if (vcs = vlines - 1) then
                vcs <= "0000000000";
            else
                vcs <= vcs + 1;
            end if;
        end if;
    end process;

    --Asignacion a se ´ nales de sincron ˜ ıa´
    hsyncm <= '0' when (hcs < "0001111111") else '1'; --menor a 128
    vsyncm <= '0' when (vcs < "0000000010") else '1'; --menor a 2
	 
	 hsync <= hsyncm;
    vsync <= vsyncm;
	 
	 hsyncmeasure <= hsyncm;
	 vsyncmeasure <= vsyncm;
    
    --Senal de video ˜
    vidon <= '1' when ((hcs>=hbp) and (hcs<hfp) and (vcs>=vbp) and (vcs<vfp)) else '0';
    
    --Asignacion de contadores a puertos ´
    hc <= hcs;
    vc <= vcs;
end vga_640x480;