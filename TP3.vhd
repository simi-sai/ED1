----------------------------------------------------------------------------------
-- Company:	FCEFyN - UNC
-- Engineer: Grupo 03 - ED1 4
-- Create Date:	05/15/2022
-- Design Name:	Trabajo Practico 3
-- Module Name:	SumadorRestador4bits - Behavioral
-- Project Name: ALU con FPGA
-- Target Devices: Spartan 3E-100 CP-132
-- Tool versions: Xilinx ISE 14.7
-- Description:	Sumador - Restador - AND - OR de 4 bits
-- Dependencies:
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: (Clock agregado para un control mas estable en las operaciones)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
	
entity SumadorRestador4bits is
    Port ( BTN1 : in STD_LOGIC;
        BTN2 : in STD_LOGIC;
        CLOCK : in STD_LOGIC;
        NUM1 : in STD_LOGIC_VECTOR (3 downto 0);
        NUM2 : in STD_LOGIC_VECTOR (3 downto 0);
        RESULTADO : out STD_LOGIC_VECTOR (3 downto 0);
        CARRY : out STD_LOGIC;
        NEG : out STD_LOGIC );
end SumadorRestador4bits;

architecture Behavioral of SumadorRestador4bits is

signal aux : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal acarreo : STD_LOGIC := '0';
signal negativo : STD_LOGIC := '0';

begin

    process(CLOCK)
    begin	

    if CLOCK = '1' and CLOCK'event then

    acarreo <= '0';	                                    -- Reseteamos los valores de...
    negativo <= '0';	                                -- ...acarreo y negativo para...
                                                        -- ...evitar arrastre del valor.
        if BTN1 = '0' then

            if BTN2 = '0' then		
		
                aux <= NUM1 + NUM2;	                    -- SUMA
		
                    if (NUM1 AND NUM2) /= "0000" then	-- Verifica si hubo Acarreo
                        acarreo <= '1';					
                    else					
                        acarreo <= '0';					
                    end if;					

            else				

                aux <= NUM1 AND NUM2;				    -- AND
						
            end if;					
					
        else					
					
            if BTN2 = '0' then				            -- OR
					
                aux <= NUM1 OR NUM2;					
					
            else					
					
                if NUM1 < NUM2 then				        -- Verifica si la resta...
                    negativo <= '1';				    -- ...dará número negativo...
                    aux <= NUM2 - NUM1;				    -- ...y en ese caso invierte...
                else				                    -- ...el orden
                    negativo <= '0';					
                    aux <= NUM1 - NUM2;
                end if;

            end if;
        end if;
    end if;
    end process;
                                                        -- Asigna los valores al...
    RESULTADO <= aux;	                                -- ...finalizar el proceso
    CARRY <= acarreo;	
    NEG <= negativo;	
	
end Behavioral;	