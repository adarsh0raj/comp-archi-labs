# This example shows the use of branches.
.text

main:
	
	li $t0 0x0
	li $t1 0x0
	
	beq $t0 $0 NOT_EQUAL

NOT_EQUAL:

	li $t1 2
	j EXIT


EQUAL:
	
	li $t1 1


##################Exiting#################
EXIT:

	li $v0 10# exit
	syscall


