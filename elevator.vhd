--Behavioral model for real-time 4 floor elevator.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity elevator is
   Port( clk : in STD_LOGIC;
         reset : in STD_LOGIC;  -- to bring back lift to default state(ground floor, halt)

         op_led : out STD_LOGIC; -- output led - status of lift (led is on when lift is open else off)

         initial_up_down : in STD_LOGIC; -- initial motion of lift

         initial_floor : in STD_LOGIC_VECTOR (3 downto 0); -- initial floor of lift

		     initial_request : in std_logic_vector(3 downto 0); -- initial request array of lift 

       output_floor : out std_logic_vector(3 downto 0);-- output floor shows the current floor of lift

		 output_request : out std_logic_vector(3 downto 0));
-- output request shows the current request status of lift
-- Note: in simulation we can't --modify it in real time,
-- but in real scenario if button pressed modifies the array.
end elevator;

architecture arch of elevator is
-- signals defined
signal request: std_logic_vector(3 downto 0);
signal floor :  STD_LOGIC_VECTOR (3 downto 0);
signal up_down :  STD_LOGIC;
signal flag: std_logic := '0';

begin
control : process(clk,reset)
begin

if reset='1' then
-- if reset lift goes to ground floor.
	floor<= "0001";
	op_led<='0';
	report "reset";

elsif rising_edge(clk) and  reset = '0' then

	if flag='0' then
	-- initial assignment to signals using given inputs
		request <= initial_request;
		floor <= initial_floor;
		up_down <=initial_up_down;
		op_led <='0';
	end if;

    report "entered";	
	op_led<='0';
	

	-- case 4th floor
	if floor="1000" then
		report "4th floor";
		if request(3)='1' then

		-- if 4th floor request open lift
			report "4th floor open";
			request(3)<='0'; -- request removed once lift opened
			op_led<='1'; -- indicates opening of lift
			
		elsif (up_down='0' and 
		(request(2)='1' or request(1) = '1' or request(0) = '1')) then
    -- case: lift moving downwards and downwards floor request available
			floor<="0100";
		else
    -- since fourth floor lift needs to move downwards
			up_down<='0';
	end if;
				
    
    -- case 3rd floor			
	elsif floor="0100" then
		report "3rd floor";
		if request(2)='1' then
		
		-- if 3rd floor request open lift
			report "3rd floor open";
			request(2)<='0'; -- request removed once lift opened
			op_led<='1';  -- indicates opening of lift
	    elsif (up_down='0' and(request(1)='1' or request(0)='1') ) then
	-- case: lift moving downwards and downwards floor request available
			floor<="0010";
		elsif(up_down='1' and (request(3)='1') ) then
	-- case: lift moving upwards and upwards floor request available
			floor<="1000";
		else
	-- case: lift moving upwards and downwards floor requests available
	-- or vice versa
	-- toggle movement of lift
			up_down<= not(up_down);
		end if;	

      
	-- case 2nd floor		
	elsif floor="0010" then
		report "2nd floor";
		if request(1)='1' then
		
		-- if 2nd floor request open lift
			report "2nd floor open";
			request(1)<='0'; -- request removed once lift opened
			op_led<='1';  -- indicates opening of lift
		elsif(up_down='0' and (request(0)='1') ) then
	-- case: lift moving downwards and downwards floor request available
			floor<="0001";
		elsif(up_down='1' and (request(2)='1' or request(3)='1') ) then
	-- case: lift moving upwards and upwards floor request available
			floor<="0100";
		else 
	-- case: lift moving upwards and downwards floor requests available
	-- or vice versa
	-- toggle movement of lift
			up_down<= not(up_down);
		end if;
		
      
	-- case 1st/ground floor
	elsif floor="0001" then
		report "1st floor";
		if request(0)='1' then
			report "1st floor open";
      
	-- if 1st floor request open lift
			request(0)<='0'; -- request removed once lift opened
			op_led<='1';  -- indicates opening of lift
		elsif(up_down='1' and 
		(request(2)='1' or request(1)='1' or request(3)='1') ) then
	-- case: lift moving upwards and upwards floor request available
			floor<="0010";
		else
	-- since first/ground floor lift needs to move upwards
			up_down<='1';
		end if;
      
      
 	else
		report "Lift stuck";
	end if;
    
flag<='1';	
end if;
  
output_floor <= floor;
output_request <= request;

end process control;
end architecture;
