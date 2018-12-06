restart

add_force clk 0 0 1 50 -repeat_every 100
add_force sysReset 0
add_force buttons 00

run 310

add_force buttons 10

run 100

add_force buttons 00

run 500

add_force buttons 10

run 100

add_force buttons 00

run 200

add_force buttons 01

run 100

add_force buttons 00

run 300

add_force buttons 10

run 100

add_force buttons 00

run 500

add_force sysReset 1

run 100

add_force sysReset 0

run 500
