----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/04/05 22:57:44
-- Design Name: 
-- Module Name: choosebit_tb - stl
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

entity choosebit_tb is
--  Port ( );
end choosebit_tb;

architecture stl of choosebit_tb is
    component main is port ( 
        clk:in std_logic;
        btn1,btn2:in std_logic;
        settime,setalarm:in std_logic;
        start:in std_logic;
        outputchoose:out std_logic_vector(7 downto 0)
    );
    end component;
    signal clk,btn1,btn2,settime,setalarm:std_logic;
    signal start:std_logic:='0';
    signal output:std_logic_vector(7 downto 0);
    
begin
     u1:main port map(clk=>clk,btn1=>btn1,btn2=>btn2,settime=>settime,setalarm=>setalarm,start=>start,outputchoose=>output);
     --u1:main port map(clk=>clk,btn1=>btn1,btn2=>btn2,start=>start,outputchoose=>output);
     process begin
         clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns; clk <= '0'; wait for 1 ns;
         btn1<='1';
         settime<='0';
         setalarm<='1';
         clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns; clk <= '0'; wait for 1 ns;
         start<='1';
         clk <= '0'; wait for 1 ns; clk <= '1'; wait for 1 ns; clk <= '0'; wait for 1 ns;
         settime<='0';
         setalarm<='0';
     end process;

end stl;
