@echo off
color 0a
"C:\iverilogAssistant\iverilog\bin\iverilog.exe" -o "avg_4_TB.o" "tb\avg_4_TB.v" "src\avg_4.v" "src\float_add.v" "src\float_mult.v" 
"C:\iverilogAssistant\iverilog\bin\vvp.exe" "avg_4_TB.o" 
pause