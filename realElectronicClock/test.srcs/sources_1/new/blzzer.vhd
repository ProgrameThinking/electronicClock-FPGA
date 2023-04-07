library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity blzzer is port(
        clk:in std_logic;
        sig:in std_logic;
        --led:out std_logic_vector(23 downto 0);
        stdclk:in std_logic;
        output:out std_logic
    );
end blzzer;

architecture stl of blzzer is
    component divider is port ( 
        stdclk:in std_logic;--100MHz
        n:in integer;
        output:out std_logic
    );
    end component;
    signal bi:std_logic;
    signal mi,fa:std_logic;
    signal temp1:std_logic_vector(11 downto 0):="100000000000"; --led(11 downto 0)
    signal temp2:std_logic_vector(11 downto 0):="000000000001"; --led(23 downto 12)
begin
    u1:divider port map(stdclk=>stdclk,n=>240790,output=>mi);
    u2:divider port map(stdclk=>stdclk,n=>227273,output=>fa);
    --u3:divider port map(stdclk=>stdclk,n=>500000,output=>flush);
	process(clk,sig)
	variable cnt_0:integer range 0 to 400;
	begin
		if(sig='1') then
			if(rising_edge(clk)) then
				cnt_0:=cnt_0+1;
				if(cnt_0=400) then
					bi<=not bi;
					cnt_0:=0;
				end if;
			end if;
		end if;
	end process;
	output<= mi when (bi='1' and sig='1')else
	         fa when(bi='0' and sig='1') else 
	         '0' when(sig='0');  
end stl;