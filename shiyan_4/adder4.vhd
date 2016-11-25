 LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 
USE IEEE.STD_LOGIC_ARITH.ALL;

entity adder4 is 
	port (a , b :in std_logic_vector(3 downto 0);
			co  : out std_logic ;
			s   : out std_logic_vector(3 downto 0);
			M   : out std_logic_vector(3 downto 0)
	);
end entity;

architecture behavioral of adder4 is 
signal c : std_logic;
signal cin : std_logic_vector(2 downto 0);
component adder1 is 
	port (a , b , ci :in std_logic;
		     co , s   :out std_logic);
end component;
begin 
	M <= "0001";
	c <= '0' ;
U0 : adder1 port map (a => a(0) , b => b(0) , ci => c ,co => cin(0) , s => s(0) );
U1 : adder1 port map (a => a(1) , b => b(1) , ci => cin(0) ,co => cin(1) , s => s(1) );
U2 : adder1 port map (a => a(2) , b => b(2) , ci => cin(1) ,co => cin(2) , s => s(2) );
U3 : adder1 port map (a => a(3) , b => b(3) , ci => cin(2) ,co => co , s => s(3) );
end behavioral;