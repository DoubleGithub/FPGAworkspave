library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SCHK is
    port(din,clk,rst:in std_logic;
                data:in std_logic_vector(7 downto 0);
                sout:out std_logic_vector(7 downto 0)      
        );
end SCHK;

architecture behav of SCHK is
type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8);
signal current_state,next_state:state;
begin

process (din,clk,rst,data)
    begin 
        if rst = '0' then 
            current_state <= s0 ;
        elsif clk'event and clk = '1' then
            current_state <= next_state;
        end if;
     end process;

process(current_state)
begin
     case current_state is
         when s0 => sout <= B"00000000";
				   if din = data(0) then 
                         next_state <= s1;
                    else
						next_state <= s0;
				   end if; 
         when s1 => sout <= B"00000001";
                    if din = data(1) then 
                         next_state <= s2;                            
                    else 
                         next_state <= s0;
                    end if;
         when s2 => sout <= B"00000011";
                    if din = data(2) then 
                         next_state <= s3;
                    else 
                         next_state <= s0;
                    end if;
         when s3 => 
                    sout <= B"00000111";
                    if din = data(3) then 
                         next_state <= s4;                         
                    else 
                     next_state <= s0;
                   end if;
        when s4 => sout <= B"00001111";
                   if din = data(4) then 
                        next_state <= s5;                        
                   else 
                        next_state <= s0;
                   end if;
        when s5 => sout <= B"00011111";
                   if din = data(5) then 
                        next_state <= s6;                      
                   else 
                        next_state <= s0;
                   end if;
        when s6 =>sout <= B"00111111";
                   if din = data(6) then 
                        next_state <= s7;                       
                   else 
                        next_state <= s0;
                       end if;
        when s7 =>sout <= B"01111111";
                       if din = data(7) then 
                            next_state <= s8;                         
                   else 
                        next_state <= s0;
                   end if;
        when s8 => sout <= B"11111111";
                        next_state <= s0;                    
        when others => sout <= B"00000000";
                        next_state <= s0;
        end case;
   end process;
end behav;