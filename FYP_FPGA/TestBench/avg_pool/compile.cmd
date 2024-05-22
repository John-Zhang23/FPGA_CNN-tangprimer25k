@echo off
color 0a
"C:\iverilogAssistant\iverilog\bin\iverilog.exe" -o "avg_pool.o" "tb\avg_pool.v" "src\ave_pool.v" "src\float_add.v" "src\avg_4.v" "src\float_mult.v" 
"C:\iverilogAssistant\iverilog\bin\vvp.exe" "avg_pool.o" 
pause