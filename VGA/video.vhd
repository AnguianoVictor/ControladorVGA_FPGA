library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity video is
port( vidon: in STD_LOGIC;
        hc, vc: in STD_LOGIC_VECTOR(9 downto 0);
        rojo,verde: out STD_LOGIC_VECTOR(2 downto 0);
        azul: out STD_LOGIC_VECTOR(1 downto 0);
		  data: in	STD_LOGIC_VECTOR(7 downto 0)
);
end video;

architecture video of video is
begin
	 process(hc,vc,vidon,data)
	 begin
		rojo <= "000";
		verde <= "000";
		azul <= "00";
		if vidon = '1' then
			rojo <= hc(4) & hc(4) & hc (4);
			verde <= not(hc(4) & hc(4) & hc (4));
			azul <= hc(4) & hc(4);
		end if;
	 end process;
	 
end video;

