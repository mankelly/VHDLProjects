library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memory_tb is
end memory_tb;

architecture sim of memory_tb is
    --constant clkFreq : integer := 100e6;
    --constant clkPer  : time    := 1000 ms / clkFreq;
    constant clkPer : time := 10 ns;
    
    signal clk      : std_logic := '0';
    signal wr_en    : std_logic := '0';
    signal rd_addr  : std_logic_vector(3 downto 0) := x"0";
    signal wr_addr  : std_logic_vector(3 downto 0) := x"0";
    signal wr_data  : std_logic_vector(7 downto 0);
    signal rd_data  : std_logic_vector(7 downto 0);
    
begin
    -- port map
    mem_sim: entity work.memory(Behavioral) 
    generic map(ADDR_WIDTH => 4, DATA_WIDTH => 8)
    port map(
        clk     => clk,
        wr_en   => wr_en,
        rd_addr => to_integer(unsigned(rd_addr)),
        wr_addr => to_integer(unsigned(wr_addr)),
        wr_data => wr_data,
        rd_data => rd_data);
    
    -- Clk Gen
    clk <= not clk after clkPer / 2;
    
    -- TB process
    process is
    begin
        
        wr_data <= x"0A";
        wr_en <= '1';
        wait for 10 ns;
        wr_addr <= x"1";
        wr_data <= x"12";
        wait for 10 ns;
        wr_addr <= x"2";
        wr_data <= x"69";
        wait for 10 ns;
        wr_en <= '0';
        rd_addr <= x"1";
        wait for 10 ns;
        rd_addr <= x"2";
        wait;
        
    end process;
    
    process is
    begin
    
        wait for 100 ns;
        std.env.finish;
    
    end process;
    
end sim;
