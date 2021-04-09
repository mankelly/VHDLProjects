library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity instr_mem is
    port( 
        signal clk : in std_logic;
        signal addr : in std_logic_vector(3 downto 0);
        signal instr : out std_logic_vector(7 downto 0)
        );
end instr_mem;

architecture Behavioral of instr_mem is
    
    type reg_arr is array(15 downto 0) of std_logic_vector(7 downto 0);
    signal mem : reg_arr;
    
begin
    
    process is 
    begin
        
        mem(0) <= "11010010"; -- load A with d'2
        mem(1) <= "00110000"; -- store A in mem(0)
        mem(2) <= "00100000"; -- load B with mem(0)
        mem(3) <= "11010100"; -- load A with d'8
        mem(4) <= "10000000"; -- A <= A + B
        mem(5) <= "10010001"; -- PC <= d'1 [points to mem(1)]
        mem(6) <= "00000000";
        mem(7) <= "00000000";
        mem(8) <= "00000000";
        mem(9) <= "00000000";
        mem(10) <= "00000000";
        mem(11) <= "00000000";
        mem(12) <= "00000000";
        mem(13) <= "00000000";
        mem(14) <= "00000000";
        mem(15) <= "00000000";
        wait;
        
    end process;
    
    instr <= mem(to_integer(unsigned(addr)));
    
end Behavioral;
