# This example shows the use of loops.
.data 

array:
    .space 20 #5 element array

prompt:
    .asciiz "Enter 5 numbers:\n"

.text

main:
	li $t0, 0 # equivalent to setting i=0
    li $s0, 20 
    li $v0, 4 #print string
    la $a0, prompt
    syscall

LOOP:

	li $v0 5 #read int
    syscall
    sw $v0, array($t0) #store int in array
    addi $t0, $t0,4
    bne $t0, $s0, LOOP


##################Exiting#################
EXIT:

	li $v0 10# exit
	syscall


