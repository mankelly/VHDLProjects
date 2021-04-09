library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_ctrl is
    port(
        signal opcode : in std_logic_vector(3 downto 0);
        signal alu_op : in std_logic_vector(1 downto 0);
        signal alu_control : out std_logic_vector(2 downto 0)
        );
end alu_ctrl;
    
architecture Behavioral of alu_ctrl is
    
    signal alu_select : std_logic_vector(5 downto 0);
    
begin

    alu_ctrl_out : process(alu_select) is
    begin
        
        case alu_select is
            
            when "10XXXX" => alu_control <= "111"; -- ld word [DO NOTHING]
            when "01XXXX" => alu_control <= "111"; -- jump [DO NOTHING]
            when "000011" => alu_control <= "100"; -- pass through A
            when "000100" => alu_control <= "101"; -- pass through B
            when "000101" => alu_control <= "011"; -- two's comp
            when "000110" => alu_control <= "001"; -- and
            when "000111" => alu_control <= "010"; -- or
            when "001000" => alu_control <= "000"; -- add
            when others => alu_control <= "111";
            
        end case;
        
    end process;
    
    alu_select <= alu_op & opcode;
    
end Behavioral;
