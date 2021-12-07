@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.

set PATH=%XILINX%\lib\%PLATFORM%;%XILINX%\bin\%PLATFORM%;C:/Xilinx/Vivado/2014.2/ids_lite/ISE/bin/nt64;C:/Xilinx/Vivado/2014.2/ids_lite/ISE/lib/nt64;C:/Xilinx/Vivado/2014.2/bin;%PATH%
set XILINX_PLANAHEAD=C:/Xilinx/Vivado/2014.2

xelab -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot tb_multi_stopwatch_ckt_behav --prj "C:/Users/Jesus/Google Drive/Spring 2015/2- CSCE-231/1- Labs/Lab 09/FiniteStateMachines_and_Controllers/FiniteStateMachines_and_Controllers.sim/sim_1/behav/tb_multi_stopwatch_ckt.prj"   xil_defaultlib.tb_multi_stopwatch_ckt
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
