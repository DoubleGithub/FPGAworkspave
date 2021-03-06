library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity cnt24 is
	port(clk:in std_logic;
	     sel,rst,en:in std_logic;
	     ch:out std_logic_vector(3 downto 0);
	     cl:out std_logic_vector(3 downto 0)
	     );
end cnt24;
architecture behac of cnt24 is
signal ch_t:std_logic_vector(3 downto 0);
signal cl_t:std_logic_vector(3 downto 0);
begin
	ch<=ch_t;
	cl<=cl_t;
process(clk,rst,en,sel)
begin
	if rst='0'	then
		ch_t<="0000";
		cl_t<="0000";
	elsif rising_edge(clk)	then
		if en ='1'	then
			if cl_t="1001"then
				ch_t<=ch_t+1;
				cl_t<="0000";
			else
				cl_t<=cl_t+1;
			end if;
				
			if sel='0' then
				if ch_t="0010"	and cl_t="0011"	then
					ch_t<="0000";
					cl_t<="0000";
				end if;
			--end if;
			
			elsif sel='1' then
				if ch_t="0001"and cl_t="0001"	then
					ch_t<="0000";
					cl_t<="0000";
				end if;
			end if;
		end if ;
	end if;
end process;
end behac;