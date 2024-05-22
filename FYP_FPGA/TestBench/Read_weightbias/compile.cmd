@echo off
color 0a
"C:\iverilogAssistant\iverilog\bin\iverilog.exe" -o "Read_weightnbais_TB.o" "tb\Read_weightnbais_TB.v" "src\Read_weightnbais.v" 
"C:\iverilogAssistant\iverilog\bin\vvp.exe" "Read_weightnbais_TB.o" 
pause