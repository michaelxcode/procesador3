
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity muxALU is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end muxALU;

architecture arqMuxALU of muxALU is

begin

	process(Crs2,SEUOperando,selImmediate)
	begin
		if(selImmediate = '1')then
			OperandoALU <= SEUOperando;
		else
			if(selImmediate = '0')then
				OperandoALU <= Crs2;
			end if;
		end if;
	end process;

end arqMuxALU;

