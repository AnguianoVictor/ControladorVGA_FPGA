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
signal centenas: STD_LOGIC_VECTOR(9 downto 0);
signal decenas: STD_LOGIC_VECTOR(9 downto 0);
signal unidades: STD_LOGIC_VECTOR(9 downto 0);
signal colorExtU: STD_LOGIC_VECTOR(7 downto 0);
signal colorExtD: STD_LOGIC_VECTOR(7 downto 0);
signal colorExtC: STD_LOGIC_VECTOR(7 downto 0);
signal datoCentenas: STD_LOGIC_VECTOR(6 downto 0);
signal datoDecenas: STD_LOGIC_VECTOR(6 downto 0);
signal datoUnidades: STD_LOGIC_VECTOR(6 downto 0);


function Numero(signal corrimiento: in STD_LOGIC_VECTOR(9 downto 0);
					signal hc, vc: in STD_LOGIC_VECTOR(9 downto 0);
					signal data: in STD_LOGIC_VECTOR(7 downto 0);
					signal digito:in STD_LOGIC_VECTOR(6 downto 0)) return STD_LOGIC_VECTOR is
					variable color: STD_LOGIC_VECTOR(7 downto 0);
		variable a,b,c,d,e,f,g: STD_LOGIC;			
	begin
			a := digito(6);
			b := digito(5);
			c := digito(4);
			d := digito(3);
			e := digito(2);
			f := digito(1);
			g := digito(0);
			if ((a = '1' )and (hc >= "0010110100" + corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0001010001" and vc <= "0001100101")) then
					-- X1 = 180 X2 = 300 Y1 = 80 Y2 = 100   A
					color := data(7 downto 0);
			elsif ((f = '1') and (hc >= "0010011011"+ corrimiento and hc <= "0010101111"+ corrimiento) and (vc >= "0001011010" and vc <= "0011001101")) then
					-- X1 = 155 X2 = 175 Y1 = 90 Y2 = 205 F
					color := data(7 downto 0);
			elsif ((g = '1') and(hc >= "0010110100"+ corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0011001000" and vc <= "0011011100")) then
					-- X1 = 180 X2 = 300 Y1 = 200 Y2 = 220 G
					color := data(7 downto 0);
			elsif ((b = '1') and(hc >= "0100110001"+ corrimiento and hc <= "0101000101"+ corrimiento) and (vc >= "0001011010" and vc <= "0011001101")) then
					-- X1 = 305 X2 = 325 Y1 = 90 Y2 = 205 B
					color := data(7 downto 0);
			elsif ((e = '1') and(hc >= "0010011011"+ corrimiento and hc <= "0010101111"+ corrimiento) and (vc >= "0011010010" and vc <= "0101000101")) then
					-- X1 = 155 X2 = 175 Y1 = 210 Y2 = 325 E
					color := data(7 downto 0);
			elsif ((c = '1') and(hc >= "0100110001"+ corrimiento and hc <= "0101000101"+ corrimiento) and (vc >= "0011010010" and vc <= "0101000101")) then
					-- X1 = 305 X2 = 325 Y1 = 210 Y2 = 325 C
					color := data(7 downto 0);
			elsif ((d = '1') and(hc >= "0010110100"+ corrimiento and hc <= "0100101100"+ corrimiento) and (vc >= "0101000000" and vc <= "0101010100")) then
					-- X1 = 180 X2 = 300 Y1 = 320 Y2 = 340  D
					color := data(7 downto 0);
			else 
					color := "00000000";
			end if;
			
		return color;
end function Numero;

begin
	 process(hc,vc,vidon,data)
		variable z: STD_LOGIC_VECTOR(19 downto 0);
		variable p: STD_LOGIC_VECTOR (11 downto 0);
		variable cen: STD_LOGIC_VECTOR (3 downto 0);
				begin
					z := (others => '0');
					z(10 downto 3):= data;
					for i in 0 to 4 loop
						--UNIDADES
						if z(11 downto 8) > 4 then
							z(11 downto 8):= z(11 downto 8)+3;
						else 
							z(11 downto 8):= z(11 downto 8);
						end if;
						--DECENAS
						if z(15 downto 12) > 4 then
							z(15 downto 12):=z(15 downto 12)+3;
						else 
							z(15 downto 12):=z(15 downto 12);
						end if;
						--CENTENAS
						if z(19 downto 16) > 4 then
							z(19 downto 16):=z(19 downto 16)+3;
						else 
							z(19 downto 16):=z(19 downto 16);
						end if;
						z(19 downto 1):= z(18 downto 0);
					end loop;
					p := z(19 downto 8);
			
			cen := p(11 downto 8);			--CENTENAS EN CODIGO BCD
			dec := p(7 downto 4);			--DECENAS EN CODIGO BCD
			uni := p(3 downto 0);			--UNIDADES EN CODIGO BCD
			
			-- CONVERVSION DE CODIGO BCD A 7 SEGMENTOS PARA LAS CENTENAS. 
			case cen is
				when "0000" => datoCentenas <= "1111110";
				when "0001" => datoCentenas <= "0110000";
				when "0010" => datoCentenas <= "1101101";
				when "0011" => datoCentenas <= "1111001";
				when "0100" => datoCentenas <= "0110011";
				when "0101" => datoCentenas <= "1011011";
				when "0110" => datoCentenas <= "1011111";
				when "0111" => datoCentenas <= "1110000";
				when "1000" => datoCentenas <= "1111111";
				when "1001" => datoCentenas <= "1111011";
				when others => datoCentenas <= "1111111";
			end case;
			
			-- CONVERVSION DE CODIGO BCD A 7 SEGMENTOS PARA LAS DECENAS. 
			case dec is
				when "0000" => datoDecenas <= "1111110";
				when "0001" => datoDecenas <= "0110000";
				when "0010" => datoDecenas <= "1101101";
				when "0011" => datoDecenas <= "1111001";
				when "0100" => datoDecenas <= "0110011";
				when "0101" => datoDecenas <= "1011011";
				when "0110" => datoDecenas <= "1011111";
				when "0111" => datoDecenas <= "1110000";
				when "1000" => datoDecenas <= "1111111";
				when "1001" => datoDecenas <= "1111011";
				when others => datoDecenas <= "1111111";
				end case;
				
				-- CONVERVSION DE CODIGO BCD A 7 SEGMENTOS PARA LAS UNIDADES. 
			case uni is
				when "0000" => datoUnidades <= "1111110";
				when "0001" => datoUnidades <= "0110000";
				when "0010" => datoUnidades <= "1101101";
				when "0011" => datoUnidades <= "1111001";
				when "0100" => datoUnidades <= "0110011";
				when "0101" => datoUnidades <= "1011011";
				when "0110" => datoUnidades <= "1011111";
				when "0111" => datoUnidades <= "1110000";
				when "1000" => datoUnidades <= "1111111";
				when "1001" => datoUnidades <= "1111011";
				when others => datoUnidades <= "1111111";
			end case;
				
			centenas <= "0000000000";				--CORRIMIENTO DE POSICION PARA UBICAR LAS CENTENAS
			decenas <= "0011100001";				--CORRIMIENTO DE POSICION PARA UBICAR LAS DECENAS
			unidades <= "0111000010";				--CORRIMIENTO DE POSICION PARA UBICAR LAS UNIDADES
			
			colorExtC <= Numero(centenas,hc,vc,data,datoCentenas);	--OBTENCION DE ESPACIO PINTADO PARA CADA SEGMENTO EN LAS CENTENAS
			colorExtD <= Numero(decenas,hc,vc,data,datoDecenas);		--OBTENCION DE ESPACIO PINTADO PARA CADA SEGMENTO EN LAS DECENAS
			colorExtU <= Numero(unidades,hc,vc,data,datoUnidades);	--OBTENCION DE ESPACIO PINTADO PARA CADA SEGMENTO EN LAS UNIDADES
			
	 end process;
	 
	 --SE VISUALIZA EL ESPACIO PINTADO DE CADA DIGITO EN CADA COLOR. 
	 rojo <= ((colorExtC(7 downto 5) or colorExtD(7 downto 5)) or colorExtU(7 downto 5)); 
	 verde <= ((colorExtC(4 downto 2) or colorExtD(4 downto 2)) or colorExtU(4 downto 2));
	 azul <= ((colorExtC(1 downto 0) or colorExtD(1 downto 0)) or colorExtU(1 downto 0));
	 
end video;

