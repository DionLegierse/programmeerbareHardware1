restart
add_force clk 0 0ps 1 50 -repeat_every 100
add_force sysReset 0
add_force watchRunning 1
add_force watchReset 0

run 3600000000
