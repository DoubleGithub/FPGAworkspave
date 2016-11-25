library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity BCD2SEG is
	port(	en : in std_logic;
			bcdin: in std_logic_vector(3 downto 0);
			segout:out std_logic_vector(6 downto 0)
	);

end BCD2SEG ;

architecture behav of BCD2SEG is 
begin 
process (en,bcdin)
begin 
	if en = '1'	then
		case bcdin is
			when "0000" => segout <= "1111110";
			when "0001" => segout <= "0110000";
			when "0010" => segout <= "1101101";
			when "0011" => segout <= "1111001";
			when "0100" => segout <= "0110011";
			when "0101" => segout <= "1011011";
			when "0110" => segout <= "1011111";
			when "0111" => segout <= "1110000";
			when "1000" => segout <= "1111111";
			when "1001" => segout <= "1111011";
			when others => null;
		end case;
	end if;
end process;
end behav;