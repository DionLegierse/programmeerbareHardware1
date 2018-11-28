restart

add_force clk 0 0 1 50 -repeat_every 100
add_force up 0
add_force down 0

run 110

add_force up 1
run 2000

add_force up 0
run 300

add_force down 1
run 2000

add_force down 0
run 300
