library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Procesador is
	Port ( 
				clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				procesorResult : inout  STD_LOGIC_VECTOR (31 downto 0));
end Procesador;

architecture Behavioral of Procesador is

component adder 
    Port ( operand1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operand2 : in  STD_LOGIC_VECTOR (31 downto 0);
           resultado : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PC 
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
           clkFPGA : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component nPC 
    Port ( address : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           clkFPGA : in  STD_LOGIC;
           nextInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component instructionMemory 
    Port ( 
			  --clk : in STD_LOGIC;
			  address : in  STD_LOGIC_VECTOR (31 downto 0);
           reset : in  STD_LOGIC;
           outInstruction : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component registerFile 
    Port ( --clkFPGA : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           registerSource1 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerSource2 : in  STD_LOGIC_VECTOR (4 downto 0);
           registerDestination : in  STD_LOGIC_VECTOR (4 downto 0);
           --writeEnable : in  STD_LOGIC;
			  dataToWrite : in STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource1 : out  STD_LOGIC_VECTOR (31 downto 0);
           contentRegisterSource2 : out  STD_LOGIC_VECTOR (31 downto 0));
           --contentRegisterDestination : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component unidadControl 
    Port ( --clk : in STD_LOGIC;
			  op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  --wren : out std_logic;
           ALUOP : out  STD_LOGIC_VECTOR (5 downto 0));
end component;


component ALU 
    Port ( operando1 : in  STD_LOGIC_VECTOR (31 downto 0);
           operando2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOP : in  STD_LOGIC_VECTOR (5 downto 0);
			  carry : in STD_LOGIC;
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component muxALU 
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           SEUOperando : in  STD_LOGIC_VECTOR (31 downto 0);
           selImmediate : in  STD_LOGIC;
           OperandoALU : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component signExtensionUnit 
    Port ( --clk : in STD_LOGIC;
			  simm13 : in  STD_LOGIC_VECTOR (12 downto 0);
           simm32 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component PSR 
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           nzvc : in  STD_LOGIC_VECTOR (3 downto 0);
           --nCWP : in  STD_LOGIC_VECTOR (1 downto 0);
           --CWP : out  STD_LOGIC_VECTOR (1 downto 0);
           carry : out  STD_LOGIC);
           --icc : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

component PSRModifier
    Port ( aluResult : in  STD_LOGIC_VECTOR (31 downto 0);
			  reset : in  STD_LOGIC;
           operando1 : in  STD_LOGIC;
           operando2 : in  STD_LOGIC;
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
			  nzvc : out std_logic_vector(3 downto 0));
end component;
	
	signal auxPC : std_logic_vector(31 downto 0);
	signal auxnPC : std_logic_vector(31 downto 0);
	signal auxInstMem : std_logic_vector(31 downto 0);
	--signal auxwrEnRf  : std_logic;	
	signal auxRegFile : std_logic_vector(31 downto 0);
	signal auxCrs1 : std_logic_vector(31 downto 0);
	signal auxCrs2 : std_logic_vector(31 downto 0);
	signal auxCrd : std_logic_vector(31 downto 0);
	signal auxrs1 : std_logic_vector(4 downto 0);
	signal auxrs2 : std_logic_vector(4 downto 0);
	signal auxrd : std_logic_vector(4 downto 0);
	signal auxAlu : std_logic_vector(5 downto 0);
	signal auxDwr : std_logic_vector(31 downto 0);
	signal auxCrs3 : std_logic_vector(31 downto 0);
	signal auxSeuMux : std_logic_vector(31 downto 0);
	signal auxMuxAlu : std_logic_vector(31 downto 0);
	signal auxInmMux : std_logic;
	signal carryAlu : std_logic;
	signal nzvcPsrMod : std_logic_vector(3 downto 0);
	
	begin
	
	
	
	Inst_adder: adder PORT MAP(
		operand1 =>auxPc,
		operand2 => "00000000000000000000000000000001",
		resultado => auxnPc
	);
	
	Inst_nPC: nPC PORT MAP(
		address => auxnPc,
		reset => rst,
		clkFPGA => clk,
		nextInstruction => auxPC 
	);

	Inst_PC: PC PORT MAP(
		address => auxPC,
		reset => rst,
		clkFPGA => clk,
		nextInstruction => auxInstMem
	);
	
	Inst_instructionMemory: instructionMemory PORT MAP(
		address => auxInstMem,
		reset => rst,
		outInstruction =>auxRegFile 
	);
	

	
	Inst_registerfile: registerfile PORT MAP(
		reset => rst,
		registerSource1 => auxRegFile(18 downto 14),
		registerSource2 => auxRegFile(4 downto 0),
		registerDestination=> auxRegFile(29 downto 25),
		--writeEnable => auxwrEnRf,
		dataToWrite => auxDwr,
		contentRegisterSource1 => auxCrs1,
		contentRegisterSource2 => auxCrs2);
		--contentRegisterDestination => auxCrd
	
	Inst_unidadControl: unidadControl PORT MAP(
		op => auxRegFile(31 downto 30),
		op3 => auxRegFile(24 downto 19),
		--wren => auxwrEnRf,
		ALUOP => auxAlu
	);
	
	
	
	
	Inst_ALU: ALU PORT MAP(
		operando1 => auxCrs1,
		operando2 => auxMuxAlu,
		aluOP => auxAlu,
		carry => carryAlu,
		AluResult => auxDwr
	);
	
	Inst_muxALU: muxALU PORT MAP(
		Crs2 => auxCrs2,
		SEUOperando => auxSeuMux,
		selImmediate => auxRegFile(13),
		OperandoALU => auxMuxAlu
	);
	
	Inst_SEU: signExtensionUnit PORT MAP(
		simm13 => auxRegFile(12 downto 0),
		simm32 => auxSeuMux
		);
		
	Inst_PSR: PSR PORT MAP(
		clk => clk,
		reset => rst,
		nzvc => nzvcPsrMod,
		--nCWP =>
		--CWP =>
		carry => carryAlu
		--icc =>
		);
	Inst_PSRModifier: PSRModifier PORT MAP(
		aluResult => auxDwr,
		reset => rst,
		operando1 => auxCrs1(31),
		operando2 => auxMuxAlu(31),
		aluOp => auxAlu,
		nzvc => nzvcPsrMod
		);
		
	procesorResult <= auxDwr;


end Behavioral;

