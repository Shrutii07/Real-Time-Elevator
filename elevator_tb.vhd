--Testbench for real-time 4 floor elevator.

library ieee;
use ieee.std_logic_1164.all;

entity elevator_tb is
end elevator_tb;

architecture tb of elevator_tb is
component elevator
	 port (  clk : in  STD_LOGIC;
		 reset : in  STD_LOGIC;
		 op_led : out STD_LOGIC;
		 initial_up_down : in STD_LOGIC;
		 initial_floor : in  STD_LOGIC_VECTOR (3 downto 0);
    	 initial_request : in std_logic_vector(3 downto 0);
		 output_request : out std_logic_vector(3 downto 0);
		 output_floor : out std_logic_vector(3 downto 0));
end component;

--inputs
signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal initial_up_down : STD_LOGIC := '1';
signal initial_floor : STD_LOGIC_VECTOR (3 downto 0) := "0001";
signal initial_request : std_logic_vector (3 downto 0) := "0001";

--outputs
signal op_led :  STD_LOGIC ;
signal output_request : std_logic_vector(3 downto 0);
signal output_floor : std_logic_vector(3 downto 0);

constant clk_period : time := 100 ps;

begin
 uut : elevator 
 port map(clk => clk,
          reset => reset,
          initial_floor =>  initial_floor,
          initial_request=> initial_request,
          initial_up_down => initial_up_down,
          op_led => op_led,
          output_floor => output_floor,
          output_request => output_request);
 process
 begin
	 reset<='1';
	 initial_request <= "1010";
	 clk<='1';
	 wait for clk_period;
	 clk<='0';
	 wait for clk_period;
	 
	 reset <= '0';
	 initial_floor <= "0010";
	 initial_request <= "0101";
	 for i in 0 to 10 loop
		 clk<='1';
		 wait for clk_period;
		 clk<='0';
		 wait for clk_period;
	  end loop;
	  
	 reset <= '0';
	 initial_floor <= "0100";
	 initial_request <= "1101";
	 for i in 0 to 10 loop
		 clk<='1';
		 wait for clk_period;
		 clk<='0';
		 wait for clk_period;
	  end loop;
	  
	 reset <= '0';
	 initial_floor <= "0010";
	 initial_request <= "1101";
	 for i in 0 to 10 loop
		 clk<='1';
		 wait for clk_period;
		 clk<='0';
		 wait for clk_period;
	  end loop;
	
	 reset <= '0';
	 initial_floor <= "0001";
	 initial_request <= "1110";
	 for i in 0 to 10 loop
		 clk<='1';
		 wait for clk_period;
		 clk<='0';
		 wait for clk_period;
	  end loop;
       
end process;

end tb;
