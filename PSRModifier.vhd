----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:58:50 11/04/2012 
-- Design Name: 
-- Module Name:    PSRModifier - arqPSRModifier 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSRModifier is
    Port ( aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC; 
           operando1 : in  STD_LOGIC;
           operando2 : in  STD_LOGIC;
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
			  nzvc : out std_logic_vector(3 downto 0));
end PSRModifier;

architecture arqPSRModifier of PSRModifier is

begin
process(aluResult,operando1,operando2,aluOp)
begin

	if (reset ='1') then 
		nzvc <="0000";
	else
		if(aluOp = "010000" or aluOp = "011000")then--ADDCC ADDXCC
			nzvc(3) <= aluResult(31);	
			if(aluResult = X"00000000")then
				nzvc(2) <= '1';
			else
				nzvc(2) <= '0';
			end if;
			nzvc(1) <= (operando1 and operando2 and (not aluResult(31))) or ((not operando1) and (not operando2) and aluResult(31));
			nzvc(0) <= (operando1 and operando2) or ((not aluResult(31)) and (operando1 or operando2));
		else
			if(aluOp = "010100")then--SUBCC
				nzvc(3) <= aluResult(31);
				if(aluResult = X"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= ((operando1 and (not operando2) and (not aluResult(31))) or ((not operando1) and operando2 and aluResult(31)));
				nzvc(0) <= ((not operando1) and operando2) or (aluResult(31) and ((not operando1) or operando2));
			else
				if(aluOp = "010001" or aluOp = "010101" or aluOp = "010010" or aluOp = "010110" or aluOp = "010011" or aluOp = "010111")then
					nzvc(3) <= aluResult(31);
					if(aluResult = X"00000000")then
						nzvc(2) <= '1';
					else
						nzvc(2) <= '0';
					end if;
					nzvc(1) <= '0';
					nzvc(0) <= '0';
			--else
				--nzvc <= "1000";
				end if;
			end if;
		end if;
	end if;
end process;
end arqPSRModifier;
