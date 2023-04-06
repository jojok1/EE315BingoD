----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2023 21:18:08
-- Design Name: 
-- Module Name: LFSR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

--63 stage LFSR with 8 bit output and setting inputs

entity LFSR is
    PORT (Clk,Rst,En: IN std_logic;
            --Input: IN std_logic_vector(1 to 63);
            Output: OUT std_logic_vector(7 downto 4));
end LFSR;

architecture Behavioral of LFSR is
    signal Stages_LFSR : std_logic_vector(1 to 63);
    signal count : integer := 1;
begin

    main_proc : process(Clk,Rst) begin
        --Async Reset
        if(Rst = '1') then
            --Reset stages with zeros
            Stages_LFSR <= (others => '0');
        elsif(rising_edge(Clk)) then
            --Synchronous
            if(count = 1) then                
                if(En = '0') then
                --Shift bits
                    for i in 63 downto 2 loop
                        stages_LFSR(i) <= stages_LFSR(i - 1);
                    end loop;
                    --Set first stage with feedback
                    Stages_LFSR(1) <= stages_LFSR(62) xnor stages_LFSR(63);
                end if;
                count <= 1;
            else
                count <= count + 1;
            end if;
            
        end if;
        --Set Output from first 4 bits
        Output(7 downto 4) <= Stages_LFSR(1 to 4);
    end process main_proc;

end Behavioral;