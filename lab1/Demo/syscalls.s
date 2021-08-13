# This example shows the use of system calls.
main: 


############Taking Inputs###############
li $v0 5 # read int
syscall
move $t0 $v0 # the result of the syscall is stored in v0
             # we move it to t0 to prevent overwriting   


li $v0 5 # read int
syscall
move $t1 $v0


############Addition####################
add $t1 $t1 $t0 


############Print Statement##########
li $v0 1 # print int
move $a0 $t1
syscall


li $v0 10 # exit
syscall