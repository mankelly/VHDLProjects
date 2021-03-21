library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    constant clkPer : time := 10 ns;
    
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';
    signal A     : std_logic_vector(7 downto 0) := x"08";
    signal B     : std_logic_vector(7 downto 0) := x"02";
    signal instr : std_logic_vector(7 downto 0) := x"10";
    signal Y     : std_logic_vector(7 downto 0);
begin
    
    -- clk gen
    clk <= not clk after clkPer / 2;
    
    ALU_sim : entity work.ALU
    port map(
            clk     => clk,
            reset   => reset,
            A       => A,
            B       => B,
            instr   => instr,
            Y       => Y
        );
    
    -- TB sim
    TB : process is
    begin
        
        for i in 1 to 15 loop
            wait for 10 ns;
            instr <= instr + '1';
        end loop;
        wait;
        
    end process;
    
    -- End TB
    process is
    begin
        
        wait for 160 ns;
        std.env.finish;
        
    end process;
    
end Behavioral;
