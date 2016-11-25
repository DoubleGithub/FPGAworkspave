LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;

entity adder1 is 
	port (a , b , ci : in std_logic;
		     co , s   :out std_logic);
end entity;

architecture behavioral of adder1 is 
signal inputs : std_logic_vector (2 downto 0);
begin
	inputs <= a & b & ci ;
	process (inputs)
		begin 
		case inputs is 
			when "000" => co <= '0' ;s <= '0' ;
			when "001" => co <= '0' ;s <= '1' ;
			when "010" => co <= '0' ;s <= '1' ;
			when "011" => co <= '1' ;s <= '0' ;
			when "100" => co <= '0' ;s <= '1' ;
			when "101" => co <= '1' ;s <= '0' ;
			when "110" => co <= '1' ;s <= '0' ;
			when "111" => co <= '1' ;s <= '1' ;
			when others => null ;
		end case ;
	end process;
end behavioral;