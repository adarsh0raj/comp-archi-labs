# This example shows the use of the data segment.
.data

word_ds:
	.word 1 5 -1 2 0 2 -1 -1 5 6 7 8 9 10

half_ds:
	.half 2 3 5 6 1 2 3

byte_ds:
	.byte 1 2 3 4 

string_ascii:
	.ascii "This is not null terminated"

string_asciiz:
	.asciiz "This is null terminated"

#################Main Code################
.text

main:

	la $s0 word_ds
	lw $t0 0($s0)
	lw $t1 4($s0)
	# # lw $t1 7($s0)
	# # lb $t1 7($s0)

	add $t2 $t1 $t0

	li $v0 1
	move $a0 $t2
	syscall

	li $v0 4
	la $a0 string_ascii
	syscall


##################Exiting#################
	li $v0 10 # exit
	syscall

