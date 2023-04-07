----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 17:52:23
-- Design Name: 
-- Module Name: mincounter - stl
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mincounter is port (
    settime:in std_logic;
    clear:in std_logic;
    clk:in std_logic;
    sec0,sec1:in std_logic_vector(3 downto 0);
    inputmin0:in std_logic_vector(3 downto 0);
    inputmin1:in std_logic_vector(3 downto 0);
    outputmin0:out std_logic_vector(3 downto 0);
    outputmin1:out std_logic_vector(3 downto 0);
    cout:out std_logic
);
end mincounter;

architecture stl of mincounter is
    signal tempmin0:std_logic_vector(3 downto 0);
    signal tempmin1:std_logic_vector(3 downto 0);
begin
    process(clk,clear,settime)
	begin
	    if(settime='1') then
            tempmin0<=inputmin0;
            tempmin1<=inputmin1;
        elsif(clear='1') then
            tempmin0<="0000";
            tempmin1<="0000";
        elsif(rising_edge(clk)) then	--Rising edge trigger timer
            if(tempmin0="1001") then
                tempmin0<="0000";
                if(tempmin1="0101") then
                    tempmin1<="0000";
                    --cout<='1';
                else
                    tempmin1<=tempmin1+1;
                end if;
            else
                tempmin0<=tempmin0+1;
                --cout<='0';
            end if;
        end if;
	end process;
	outputmin0<=tempmin0;
	outputmin1<=tempmin1;
	cout<='1' when (tempmin0="1001" and tempmin1="0101" and sec0="1001" and sec1="0101") else '0';
end stl;
