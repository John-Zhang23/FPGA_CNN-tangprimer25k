@echo off
color 0a
"C:\iverilogAssistant\iverilog\bin\iverilog.exe" -o "float_Add_TB.o" "tb\float_Add_TB.v" "src\float_add.v" 
"C:\iverilogAssistant\iverilog\bin\vvp.exe" "float_Add_TB.o" 
pause