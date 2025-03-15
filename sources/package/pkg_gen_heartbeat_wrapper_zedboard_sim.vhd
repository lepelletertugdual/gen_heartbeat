-- ######################################################################################################################################################################################################
-- file :
--     pkg_gen_heartbeat_wrapper_zedboard_sim.vhd
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- objective :
--     gen_heartbeat_wrapper_nexys_a7.vhd simulation wrapper package for Digilent NEXYS-A7 board evaluation.
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- level of description :
--     register tranfer level (RTL)
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- author :
--     Tugdual LE PELLETER
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- history :
--     2022-04-20
--         file creation
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- table of contents :
--     01. libraries
--     02. package header
--         02.01. constants
--             02.01.01. board features
--             02.01.02. DUT : gen_heartbeat_wrapper_nexys_a7_sim
--     03. package body
-- ######################################################################################################################################################################################################

-- ######################################################################################################################################################################################################
-- 01. libraries
-- ######################################################################################################################################################################################################

library ieee;
    use ieee.std_logic_1164.all;
	
-- ######################################################################################################################################################################################################
-- 02. package header
-- ######################################################################################################################################################################################################
	
package pkg_gen_heartbeat_wrapper_zedboard_sim is

    -- ==================================================================================================================================================================================================
	-- 02.01. constants
    -- ==================================================================================================================================================================================================
	    -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- 02.01.01. board features (do not modify)
	    -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	    constant c_led_width    : integer := 16;
	    constant c_switch_width : integer := 16;
	    constant c_osc_freq     : integer := 100_000_000;
	
	    -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		-- 02.01.02. DUT : gen_heartbeat_wrapper_nexys_a7_sim
	    -- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	    constant c_mmcm_freq              : integer   := 100_000_000;
	    constant c_heartbeat_freq         : integer   :=   5_000_000;
	    constant c_pulse_train_freq       : integer   :=   1_000_000;
	    constant c_pulse_train_polar_down : std_logic := '0';

end package pkg_gen_heartbeat_wrapper_zedboard_sim;

-- ######################################################################################################################################################################################################
-- 03. package body
-- ######################################################################################################################################################################################################

package body pkg_gen_heartbeat_wrapper_zedboard_sim is

-- None

end package body pkg_gen_heartbeat_wrapper_zedboard_sim;

-- ######################################################################################################################################################################################################
-- EOF
-- ######################################################################################################################################################################################################