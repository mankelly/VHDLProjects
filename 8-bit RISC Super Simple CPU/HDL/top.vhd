library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    port(
        signal clk : in std_logic;
        signal reset : in std_logic
        );
end top;

architecture Behavioral of top is
    
    signal instr : std_logic_vector(7 downto 0);
    signal j, reg_to_mem, mem_to_reg, wr_to_A, wr_to_B : std_logic;
    signal alu_op : std_logic_vector(1 downto 0);
    
begin
    
    data_path_unit : entity work.data_path(Behavioral)
    port map(
            clk => clk,
            reset => reset,
            j => j,
            reg_to_mem => reg_to_mem,
            mem_to_reg => mem_to_reg,
            wr_to_A => wr_to_A,
            wr_to_B => wr_to_B,
            alu_op => alu_op,
            instr => instr
            );
    
    ctrl_unit : entity work.ctrl(Behavioral)
    port map(
            instr => instr,
            j => j,
            reg_to_mem => reg_to_mem,
            mem_to_reg => mem_to_reg,
            wr_to_A => wr_to_A,
            wr_to_B => wr_to_B,
            alu_op => alu_op
            );
    
end Behavioral;