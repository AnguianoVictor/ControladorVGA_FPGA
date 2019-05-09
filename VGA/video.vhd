library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

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
--    process(vidon, vc,hc)
--    begin
--        rojo <= "000";
--        verde <= "000";
--        azul <= "00";
--        if vidon = '1' then
--            rojo <= data(7 downto 5);
--            verde <= data(4 downto 2);
--				azul <= data(1 downto 0);
--        end if;
--    end process;
	 
	 process(hc,vc,vidon)
	 begin 
		if (hc >= "0011111010" and hc <= "0100101100") or (hc >= "0111000010" and hc <= "0111110100")then
			if (vc >= "0010010110" and vc <= "0011001000") then
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
			else 
				rojo <= "000";
				verde <= "000";
				azul <= "00";
			end if;
			else 
				rojo <= "000";
				verde <= "000";
				azul <= "00";
		end if;
		


	 end process;
end video;
