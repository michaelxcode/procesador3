library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity ALU is
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
			  carry : in STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture arqALU of ALU is

begin

	process(operando1,operando2,aluOP)
	begin
	   case (aluOP) is 
		when "000000" => 
		   AluResult <= operando1 + operando2;	--add
		when "000100" =>
		   AluResult <= operando1 - operando2;--sub
		when "000010" =>
		   AluResult <= operando1 OR operando2;--or
		when "010000" =>
		   AluResult <= operando1 + operando2;--ADDcc
		when "001000" =>
		   AluResult <= (operando1 + operando2)+carry;--ADDx
		when "011000" =>
		   AluResult <= (operando1 + operando2)+carry;--ADDxcc
		when "010100" =>
		   AluResult <= operando1 - operando2;--SUBcc
		when "001100" =>
		   AluResult <= (operando1 - operando2)-carry;--SUBx
		when "011100" =>
		   AluResult <= (operando1 - operando2)-carry;--SUBxcc
		when "000001" =>
		   AluResult <= operando1 AND operando2;--AND
		when "010001" =>
		   AluResult <= operando1 AND operando2;--ANDcc
		when "000101" =>
		   AluResult <= operando1 AND ( NOT operando2);--ANDN
		when "010101" =>
		   AluResult <= operando1 AND ( NOT operando2);--ANDNcc
		when "010010" =>
		   AluResult <= operando1 OR operando2;--ORcc
		when "000110" =>
		   AluResult <= operando1 OR (NOT operando2);--ORN
		when "010110" =>
		   AluResult <= operando1 OR (NOT operando2);--ORNcc
		when "000011" =>
		   AluResult <= operando1 XOR operando2;--XOR
		when "010011" =>
		   AluResult <= operando1 XOR operando2;--XORcc
		when "000111" =>
		   AluResult <= operando1 XOR (NOT operando2);--XORN
		when "010111" =>
		   AluResult <= operando1 XOR (NOT operando2);--XORNcc
		when "111111" =>
		   AluResult <= "00000000000000000000000000000000";
		when others  => null;
		end case;
	end process;
end arqALU;
