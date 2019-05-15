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
signal cantidad: STD_LOGIC_VECTOR(9 downto 0);

procedure Numero(signal corrimiento: in STD_LOGIC_VECTOR(9 downto 0);
						signal hc, vc: in STD_LOGIC_VECTOR(9 downto 0);
						signal rojo,verde: out STD_LOGIC_VECTOR(2 downto 0);
						signal azul: out STD_LOGIC_VECTOR(1 downto 0)) is
   
   
   
begin
		if (hc >= "0010110100" + corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0001010001" and vc <= "0001100101") then
				-- X1 = 180 X2 = 300 Y1 = 80 Y2 = 100
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0010011011"+ corrimiento and hc <= "0010101111"+ corrimiento) and (vc >= "0001011010" and vc <= "0011001101") then
				-- X1 = 155 X2 = 175 Y1 = 90 Y2 = 205
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0010110100"+ corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0011001000" and vc <= "0011011100") then
				-- X1 = 180 X2 = 300 Y1 = 200 Y2 = 220  
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0100110001"+ corrimiento and hc <= "0101000101"+ corrimiento) and (vc >= "0001011010" and vc <= "0011001101") then
				-- X1 = 305 X2 = 325 Y1 = 90 Y2 = 205
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0010011011"+ corrimiento and hc <= "0010101111"+ corrimiento) and (vc >= "0011010010" and vc <= "0101000101") then
				-- X1 = 155 X2 = 175 Y1 = 210 Y2 = 325
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0100110001"+ corrimiento and hc <= "0101000101"+ corrimiento) and (vc >= "0011010010" and vc <= "0101000101") then
				-- X1 = 305 X2 = 325 Y1 = 210 Y2 = 325
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		elsif (hc >= "0010110100"+ corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0101000000" and vc <= "0101010100") then
				-- X1 = 180 X2 = 300 Y1 = 320 Y2 = 340  
				rojo <= data(7 downto 5);
				verde <= data(4 downto 2);
				azul <= data(1 downto 0);
		else 
				rojo <= "000";
				verde <= "000";
				azul <= "00";
		end if;
end procedure Numero;

begin
	 process(hc,vc,vidon)
	 begin 
	 cantidad <= data&"00";
		Numero(cantidad,hc,vc,rojo,verde,azul);
	 end process;
end video;
