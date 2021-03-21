library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_tb is
generic (ADDR_WIDTH : integer := 4);
end fifo_tb;

architecture Behavioral of fifo_tb is
    
    constant clkPer : time := 10 ns;
    
    signal clk      : std_logic := '1';
    signal reset    : std_logic := '1';
    signal wr       : std_logic := '0';
    signal rd       : std_logic := '0';
    signal full     : std_logic;
    signal empty    : std_logic;
    signal wr_addr  : std_logic_vector(ADDR_WIDTH-1 downto 0);
    signal rd_addr  : std_logic_vector(ADDR_WIDTH-1 downto 0);
    
begin
    
    -- Clock Gen
    clk <= not clk after clkPer / 2;
    
    i_FIFO : entity work.fifo_ctrl(Behavioral)
    port map(
            clk     => clk,
            reset   => reset,
            wr      => wr,
            rd      => rd,
            full    => full,
            empty   => empty,
            wr_addr => wr_addr,
            rd_addr => rd_addr
            );
    
    -- Testbench Code       
    TB : process is
    begin
    
        wait for 10 ns;
        reset <= '0';
        wr <= '1';
        -- write until full
        for i in 1 to 15 loop
            
            wait for 10 ns;
            
        end loop;
        
        -- read and write
        wait for 30 ns;
        rd <= '1';
        
        -- read until empty
        wait for 10 ns;
        wr <= '0';
        for j in 1 to 15 loop
            
            wait for 10 ns;
            
        end loop;
        
        wait;
        
    end process;
    
    -- Stop Simulation
    process is
    begin
        
        wait for 400 ns;
        std.env.finish;
        
    end process;

end Behavioral;
