:: ###################################################################################################################################################################################
:: file :
::     run_gen_heartbeat.bat
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: purpose :
::     running gen_heartbeat TCL script.
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: limitation :
::     none.
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: author :
::     Tugdual LE PELLETER
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: history :
::     2023-11-11
::         file creation
:: -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:: table of contents :
::    01. defining VIVADO EDA tool path
::    02. running tcl script
:: ###################################################################################################################################################################################

:: ###################################################################################################################################################################################
:: 01. defining VIVADO EDA tool path
:: ###################################################################################################################################################################################

set PATH=C:\Applications\Xilinx\Vivado\2022.2\bin;C:Applications\Xilinx\Vivado\2022.2\lib\win64.o;%PATH%
set XILINX_VIVADO=C:\Applications\Xilinx\Vivado\2022.2

:: ###################################################################################################################################################################################
:: 02. running tcl script
:: ###################################################################################################################################################################################

vivado -mode tcl -source ./run_gen_heartbeat.tcl

:: ###################################################################################################################################################################################
:: EOF
:: ###################################################################################################################################################################################
