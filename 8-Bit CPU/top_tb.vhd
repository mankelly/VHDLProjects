library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
generic(DATA_WIDTH : integer := 8);
end top_tb;

architecture Behavioral of top_tb is
    
    constant clkPer : time := 10 ns;
    
    signal clk    : std_logic := '1';
    signal reset  : std_logic := '1'; 
    signal wr     : std_logic := '0';
    signal A      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"08"; -- Decimal 8
    signal B      : std_logic_vector(DATA_WIDTH-1 downto 0) := x"04"; -- Decimal 4
    signal opcode : std_logic_vector(DATA_WIDTH-1 downto 0) := x"00"; -- add operation
    signal Y      : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    
begin
    
    -- Clock Gen
    clk <= not clk after clkPer / 2;
    
    -- Port Map
    topTB : entity work.top(Behavioral)
    generic map(DATA_WIDTH => DATA_WIDTH)
    port map(
            clk    => clk,
            reset  => reset,
            wr     => wr,
            A      => A,
            B      => B,
            opcode => opcode,
            Y      => Y
            );
    
    -- Testbench Code
    tb : process is
    begin
    
        wait for 10 ns;
        reset  <= '0';
        wr     <= '1';
        wait for 10 ns;
        opcode <= x"02"; -- sub
        wait for 10 ns;
        opcode <= x"14"; -- two's comp of A
        wait for 10 ns;
        opcode <= x"08"; -- and
        wait for 10 ns;
        opcode <= x"09"; -- or
        wait for 10 ns;
        opcode <= x"0a"; -- xor
        wait for 10 ns;
        opcode <= x"1b"; -- one's comp of A
        wait for 10 ns;
        opcode <= x"0e"; -- rotate A right
        wait for 10 ns;
        opcode <= x"1e"; -- rotate A left
        wait for 10 ns;
        wr <= '0';
        wait; -- end tb
        
    end process;
    
    -- Stop Sim
    stop : process is
    begin
        
        wait for 120 ns;
        std.env.finish;
        
    end process;
    
    
end Behavioral;
