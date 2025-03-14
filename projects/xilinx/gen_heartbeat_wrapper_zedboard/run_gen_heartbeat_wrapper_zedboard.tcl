# ######################################################################################################################################################################################################
# file :
#     run_gen_heartbeat_wrapper_nexys_a7.tcl
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# objective :
#     creating VIVADO project for simulation and bitstream generation.
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# author :
#     Tugdual LE PELLETER
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# history :
#     2022-05-10
#         file creation
# ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# table of contents :
#    01. defining environment constants
#    02. creating output files directories
#    03. creating VIVADO project
#    04. adding files
#        04.01. adding IP
#        04.02. synthesis
#            04.02.01. design
#            04.02.02. user IP
#            04.02.03. packages
#        04.03. simulation
#            04.03.01. design
#            04.03.02. user IP
#            04.03.03. packages
#            04.03.04. testbench
#        04.04. constraints
#            04.04.01. pinout
#    04. setting testbench module for simulation
#    05. setting top-level modules
#    06. updating compilation order
#    07. setting project parameters
#    08. launching design flow
#        08.01. synthesis
#        08.02. physical implementation (placing and routing) and bitstream generation
#    09. generating post-routing reports
#    10. launching VIVADO EDA tool
# ######################################################################################################################################################################################################

# ######################################################################################################################################################################################################
# 01. defining environment constants
# ######################################################################################################################################################################################################

set name_board     zedboard
set name_dut       gen_heartbeat
set name_project   ${name_dut}_wrapper_${name_board}
set name_part      xc7z020clg484-3
set name_language  vhdl
set name_top_level     ${name_dut}_wrapper_${name_board}
set name_bench     bch_${name_dut}_wrapper_${name_board}

set dir_bitstream ./bitstream
set dir_reports   ./reports

# ######################################################################################################################################################################################################
# 02. creating output files directories
# ######################################################################################################################################################################################################

file mkdir ${dir_bitstream}
file mkdir ${dir_reports}

# ######################################################################################################################################################################################################
# 03. creating VIVADO project
# ######################################################################################################################################################################################################

create_project -force -name ${name_project}

# ######################################################################################################################################################################################################
# 04. adding files
# ######################################################################################################################################################################################################
    # ==================================================================================================================================================================================================
	# 04.01. adding IP
    # ==================================================================================================================================================================================================
    read_ip ./../../sources/ip/ip_mmcm/ip_mmcm.xci

    # ==================================================================================================================================================================================================
	# 04.02. synthesis
    # ==================================================================================================================================================================================================
        # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        # 03.02.03. packages
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset sources_1 {
		    ./../../sources/package/pkg_gen_heartbeat.vhd
            ./../../sources/package/pkg_gen_heartbeat_wrapper_zedboard.vhd
        }

		# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		# 03.02.01. design
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset sources_1 {
            ./../../sources/design/gen_heartbeat.vhd
	        ./../../sources/design/gen_heartbeat_wrapper_zedboard.vhd
        }

    # ==================================================================================================================================================================================================
	# 04.03. simulation
    # ==================================================================================================================================================================================================
        # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		# 04.03.03. packages
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset sim_1 {
            ./../../sources/package/pkg_mgt_file.vhd
		    ./../../sources/package/pkg_gen_heartbeat.vhd
            ./../../sources/package/pkg_gen_heartbeat_wrapper_zedboard_sim.vhd
        }

		# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		# 04.03.01. design
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset sim_1 {
            ./../../sources/design/gen_heartbeat.vhd
	        ./../../sources/design/gen_heartbeat_wrapper_zedboard_sim.vhd
        }

        # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		# 04.03.04. testbench
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset sim_1 {
            ./../../sources/bench/bch_gen_heartbeat_wrapper_zedboard.vhd
        }

    # ==================================================================================================================================================================================================
	# 04.04. constraints
    # ==================================================================================================================================================================================================
		# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		# 04.04.01. pinout
	    # ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        add_files -fileset constrs_1 {
            ./../../constraints/pinout_zedboard.xdc
        }

# ######################################################################################################################################################################################################
# 05. setting top-level modules
# ######################################################################################################################################################################################################

set_property top ${name_top_level} [get_filesets sources_1]
set_property top ${name_bench}     [get_filesets sim_1]

# ######################################################################################################################################################################################################
# 06. updating compilation order
# ######################################################################################################################################################################################################

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

# ######################################################################################################################################################################################################
# 07. setting project parameters
# ######################################################################################################################################################################################################

set_property target_language ${name_language} [current_project]
set_property part            ${name_part}     [current_project]

# ######################################################################################################################################################################################################
# 08. launching design flow
# ######################################################################################################################################################################################################
    # ==================================================================================================================================================================================================
	# 08.01. synthesis
    # ==================================================================================================================================================================================================
    synth_design -directive        PerformanceOptimized \
			     -fsm_extraction   one_hot              \
			     -resource_sharing off                  \
			     -incremental_mode aggressive           \
			     -retiming                              \
			     -debug_log                             \
			     -verbose
    # ==================================================================================================================================================================================================
	# 08.02. physical implementation (placing and routing) and bitstream generation
    # ==================================================================================================================================================================================================
    launch_runs  impl_1 -to_step write_bitstream
    wait_on_runs impl_1

# ######################################################################################################################################################################################################
# 09. generating post-routing reports
# ######################################################################################################################################################################################################

report_utilization    -file ./${dir_reports}/rpt_post_route_utilization.txt
report_timing_summary -file ./${dir_reports}/rpt_post_route_timing.txt
report_power          -file ./${dir_reports}/rpt_post_route_power.txt
report_drc            -file ./${dir_reports}/rpt_post_route_drc.txt

# ######################################################################################################################################################################################################
# 10. launching VIVADO EDA tool
# ######################################################################################################################################################################################################

start_gui

# ######################################################################################################################################################################################################
# EOF
# ######################################################################################################################################################################################################