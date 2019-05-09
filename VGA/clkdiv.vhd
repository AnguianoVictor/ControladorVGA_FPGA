library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity clkdiv is
port(
    mclk, clr: in STD_LOGIC;
    clk25: 	OUT 	STD_LOGIC;
	 clk	:	OUT	STD_LOGIC;
	 cs	:	OUT	STD_LOGIC);
end clkdiv;

architecture clkdiv of clkdiv is

signal clk25p: STD_LOGIC;
signal divclk: STD_LOGIC_VECTOR(16 downto 0);

begin
    --Divisor de reloj
    process(mclk,clr)
    begin
        if clr = '1' then
            clk25p <= clk25p;
        elsif (mclk = '1' and mclk'event) then
            clk25p <= NOT clk25p;
				divclk <= divclk + 1;
        end if;
    end process;

cs <= divclk(16);
clk <= divclk(11);
clk25 <= clk25p;

end clkdiv;
