library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity data_path is
    port(
        signal clk : in std_logic;
        signal reset : in std_logic;
        signal j, reg_to_mem, mem_to_reg, wr_to_A, wr_to_B : in std_logic;
        signal alu_op : in std_logic_vector(1 downto 0);
        signal instr : out std_logic_vector(7 downto 0)
        );
end data_path;

architecture Behavioral of data_path is
    
    signal PC, PC_next : std_logic_vector(3 downto 0);
    signal IR : std_logic_vector(7 downto 0);
    signal alu_out : std_logic_vector(7 downto 0);
    signal C : std_logic;
    signal F : std_logic_vector(1 downto 0);
    signal reg_A, reg_A_next : std_logic_vector(7 downto 0);
    signal reg_B, reg_B_next : std_logic_vector(7 downto 0);
    signal alu_control : std_logic_vector(2 downto 0);
    signal data_mem_out : std_logic_vector(7 downto 0);
    signal wr_back_reg : std_logic_vector(7 downto 0);
    signal ld_imm : std_logic_vector(7 downto 0);
    signal jump, jumpC, jumpZ, jumpN : std_logic_vector(3 downto 0); -- instruction pointers
    
begin
    
    reg_seg : process(clk, reset) is
    begin
        
        if reset = '1' then
            PC <= x"0";
            reg_A <= x"00";
            reg_B <= x"00";
        
        else
            if rising_edge(clk) then
                PC <= PC_next;
                reg_A <= reg_A_next;
                reg_B <= reg_B_next;
                
            end if;
            
        end if;
        
    end process;
    
--    dflt : process(PC, reg_A, reg_B) is
--    begin
--        PC_next <= PC;
--        reg_A_next <= reg_A;
--        reg_B_next <= reg_B;
        
--        if j = '0' then
--            PC_next <= PC + x"1";
--        else
--            PC_next <= IR(3 downto 0);
--        end if;
--    end process;
    
    instr_mem_unit : entity work.instr_mem(Behavioral)
    port map(
            clk => clk,
            addr => PC,
            instr => IR
            );
    
    alu_ctrl_unit : entity work.alu_ctrl(Behavioral)
    port map(
            opcode => IR(7 downto 4),
            alu_op => alu_op,
            alu_control => alu_control
            );
    
    alu_unit : entity work.alu(Behavioral)
    port map(
            alu_control => alu_control,
            A => reg_A,
            B => reg_B,
            Y => alu_out,
            C => C,
            F => F
            );
    
    data_mem_unit : entity work.memory(Behavioral)
    port map(
            clk => clk,
            addr => IR(3 downto 0),
            wr_en => reg_to_mem,
            wr_data => alu_out,
            rd_data => data_mem_out
            );
    
    
    wr_back_reg <= alu_out when mem_to_reg = '0' else data_mem_out;
    ld_imm <= x"0" & IR(3 downto 0);
    reg_A_next <= wr_back_reg when (wr_to_A = '1' and alu_op = "00") else 
                  ld_imm when (wr_to_A = '1' and alu_op = "10") else reg_A;
    reg_B_next <= wr_back_reg when wr_to_B = '1' else reg_B;
    
    jumpC <= IR(3 downto 0) when (j = '1' and C = '1') else PC + x"1";
    jumpZ <= IR(3 downto 0) when (j = '1' and F(1) = '1') else jumpC;
    jumpN <= IR(3 downto 0) when (j = '1' and F(0) = '1') else jumpZ;
    jump <= IR(3 downto 0) when j = '1' else jumpN;
    PC_next <= jump;
    
    instr <= IR;
    
end Behavioral;
