----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 18:04:26
-- Design Name: 
-- Module Name: hourcounter - stl
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

entity hourcounter is port (
    settime:in std_logic;
    clear:in std_logic;
    clk:in std_logic;
    inputhour0:in std_logic_vector(3 downto 0);
    inputhour1:in std_logic_vector(3 downto 0);
    outputhour0:out std_logic_vector(3 downto 0);
    outputhour1:out std_logic_vector(3 downto 0);
    cout:out std_logic
);
end hourcounter;

architecture stl of hourcounter is
    signal temphour0:std_logic_vector(3 downto 0);
    signal temphour1:std_logic_vector(3 downto 0);
begin
    process(clk,clear,settime)
    begin
        if(settime='1') then
            temphour0<=inputhour0;
            temphour1<=inputhour1;
        elsif(clear='1') then
            temphour0<="0000";
            temphour1<="0000";
        elsif(rising_edge(clk)) then
            if(temphour0="0011" and temphour1="0010") then
                temphour0<="0000";
                temphour1<="0000";
            elsif(temphour0="1001") then
                temphour1<=temphour1+1;
                temphour0<="0000";
            else
                temphour0<=temphour0+1;
            end if;
        end if;
    end process;
    outputhour0<=temphour0;
    outputhour1<=temphour1;
end stl;
