----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 19:32:31
-- Design Name: 
-- Module Name: choosemodel - stl
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity choosemodel is port (
    clk:in std_logic;
    input:in std_logic_vector(3 downto 0);
    settime:out std_logic;
    setalarm:out std_logic;
    q8:out std_logic_vector(3 downto 0)
);
end choosemodel;

architecture stl of choosemodel is
    signal temppause:std_logic;
begin
    process(input,clk)
    begin
        if(rising_edge(clk)) then
            if(input="1011") then
                q8<=input;
                settime<='1';
                setalarm<='0';
            end if;
            if(input="1100") then
                q8<=input;
                setalarm<='1';
                settime<='0';
            end if;
            if(input="1110" or input="1010") then
                q8<="1010";
                settime<='0';
                setalarm<='0';
            end if;
        end if;
    end process;
end stl;
