library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity keyboard4_4 is
    port(
        rst     :    in    std_logic;
        clk_scan  :    in    std_logic;
        keyin   :    in    std_logic_vector(3 downto 0);
        scan    :    out   std_logic_vector(3 downto 0);
        leds    :    out   std_logic_vector(3 downto 0));
end;
architecture keyboard4_4_arch of keyboard4_4 is
 signal scnlin    :    std_logic_vector(3 downto 0);
 signal clkfrq    :    std_logic;
 signal cntfrq    :    std_logic_vector(4 downto 0);
 signal lednum    :    std_logic_vector(7 downto 0);
 signal cntscn    :    std_logic_vector(1 downto 0);
begin
 scan <= not scnlin;
 lednum <= scnlin & (not keyin); 
 process(rst,clk_scan)		   --ȥ��ʱ��,50��Ƶ,�γ�ɨ��ʱ��
	begin
		if rst = '0' then
			clkfrq <= '0';
			cntfrq <= (others => '0');
		elsif rising_edge(clk_scan) then
			if cntfrq = "11000" then
				cntfrq <= (others => '0');
				clkfrq <= not clkfrq;
			else
				cntfrq <= cntfrq + 1;
			end if;
		end if;
	end process;
process(rst,clkfrq)    -- ����ɨ��ʱ�Ӳ���ɨ����    
    begin
        if rst = '0' then
            cntscn <= "00";
        elsif rising_edge(clkfrq) then
            if cntscn = "11" then
                cntscn <= "00";
            else
                cntscn <= cntscn+1;
            end if;
            case cntscn is
                when "00" => scnlin <= "0001";
                when "01" => scnlin <= "0010";
                when "10" => scnlin <= "0100";
                when "11" => scnlin <= "1000";
                when others => null;
            end case;
        end if;  
    end process;            
    
    process(rst, clkfrq) -- ���ݰ���������Ӧ��leds
    begin
        if(rst = '0' ) then
            leds <= "0000";
        elsif clkfrq'event and clkfrq = '0' then
            case lednum is
                when "10001000" =>
                    leds <= "0001";	--1
                when "01001000" =>
                    leds <= "0010";	--2
                when "00101000" =>
                    leds <= "0011";	--3
                when "00011000" =>
					leds <= "1010";	--A
                when "10000100" =>
                    leds <= "0100";	--4
                when "01000100" =>
					leds <= "0101";	--5
                when "00100100" =>
                    leds <= "0110";	--6	
                when "00010100" =>
                    leds <= "1011";	--B                                
                when "10000010" =>
                    leds <= "0111";	--7
                when "01000010" =>
                    leds <= "1000";	--8
                when "00100010" =>
                    leds <= "1001";	--9
                when "00010010" =>
                    leds <= "1100";	--C                  
                when "10000001" =>
                    leds <= "1110";	--*
                when "01000001" =>
                    leds <= "0000";	--0
                when "00100001" =>
                    leds <= "1111"; --#
                when "00010001" =>
                    leds <= "1101"; --D					                
                when others =>    
					null;
            end case;
        end if;
    end process;
end;