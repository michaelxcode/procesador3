
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity unidadControl is
    Port ( --clk : in STD_LOGIC;
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  --wren : out std_logic;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end unidadControl;

architecture arqUnidadControl of unidadControl is

begin
	process(op,op3)
	begin
					if(op = "10")then				
						case op3 is
							when "000000" => -- ADD
								ALUOP <= "000000";
								
							when "010000" => --ADDcc
								ALUOP <= "010000";
								
							when "001000" => --ADDX
								ALUOP <= "001000";
								
							when "011000" => --ADDXcc
								ALUOP <= "011000";
								
							when "000100" => -- SUB
								ALUOP <= "000100";
								
							when "010100" => -- SUBcc
								ALUOP <= "010100";
								
							when "001100" => -- SUBX
								ALUOP <= "001100";
								
							when "011100" => -- SUBXcc
								ALUOP <= "011100";
								
							when "000001" => -- AND
								ALUOP <= "000001";
								
							when "010001" => -- ANDcc
								ALUOP <= "010001";
								
							when "000101" => --ANDN
								ALUOP <= "000101";
								
							when "010101" => --ANDNcc
								ALUOP <= "010101";
								
							when "000010" => -- OR
								ALUOP <= "000010";
								
							when "010010" => -- ORcc
								ALUOP <= "010010";
								
							when "000110" => --NOR
								ALUOP <= "000110";
								
							when "010110" => --NORcc
								ALUOP <= "010110";
								
							when "000011" => -- XOR
								ALUOP <= "000011";
								
							when "010011" => -- XORcc
								ALUOP <= "010011";
								
							when "000111" => -- XNOR
								ALUOP <= "000111";
								
							when "010111" => -- XNORcc
								ALUOP <= "010111";
								
							when "111100" => -- SAVE
								ALUOP <= "000000";
								
							when "111101" => -- RESTORE
								ALUOP <= "000000";
							when others => -- Cae el nop
								ALUOP <= (others=>'0');
								
							
						end case;
					else 
						ALUOP <= (others=>'0');
						--wren <= '0';
					end if;
		--end if; -- if rising_edge
	end process;
end arqUnidadControl;
