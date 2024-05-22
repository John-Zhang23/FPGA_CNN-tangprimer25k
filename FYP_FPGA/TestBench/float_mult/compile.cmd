@echo off
color 0a
"C:\iverilogAssistant\iverilog\bin\iverilog.exe" -o "float_Mult_TB.o" "tb\float_Mult_TB.v" "src\float_mult.v" 
"C:\iverilogAssistant\iverilog\bin\vvp.exe" "float_Mult_TB.o" 
pause