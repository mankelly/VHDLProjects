library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is
    
    signal clk, reset : std_logic := '1';
    
    constant clkPer : time := 10 ns;
    
begin
    
    tb : process is
    begin
        wait for 10 ns;
        reset <= '0';
        wait;
        
    end process;
    
    clk <= not clk after clkPer / 2;
      
    cpu_8 : entity work.top(Behavioral)
    port map(
            clk => clk,
            reset => reset
            );
            
end Behavioral;
