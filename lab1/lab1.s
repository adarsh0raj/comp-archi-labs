.data 

array:
    .space 200  # 50 elements array

prompt_one:
    .asciiz "Enter the size of the array\n"

prompt_two:
    .asciiz "Enter the elements of the array\n"

.text

main:
    li $v0 4
    la $a0 prompt_one      # print first prompt
    syscall

    li $v0 5                # read size of array
    syscall
    move $s0 $v0            # store n in s0

    li $t0 0                # equivalent to setting i=0
    add $s1 $s0 $s0
    add $s1 $s1 $s1         # s1 = 4*n

    li $v0 4
    la $a0 prompt_two      # print second prompt
    syscall

LOOP:

    li $v0 5                    #read int
    syscall
    sw $v0 array($t0)           # store int in array
    addi $t0 $t0 4
    bne $t0 $s1 LOOP

main_two:

    slti $t1 $s0 2
    bne $t1 $0 if_less
    li $t1 0
    li $t2 4 
    li $s2 1               # up counter
    li $s3 1               # down counter

LOOP2:
    
    lw $t6 array($t1)
    lw $t7 array($t2) 

    slt $t3 $t6 $t7
    slt $t4 $t7 $t6

    bne $t3 $0 first_if
    bne $t4 $0 second_if
    j end_if

first_if:
    addi $s2 $s3 1
    j end_if

second_if:
    addi $s3 $s2 1
    j end_if

end_if:

    addi $t1 $t1 4
    addi $t2 $t2 4
    bne $t2 $s1 LOOP2

answer:
    
    slt $t5 $s2 $s3
    bne $t5 $0 down_max
    j up_max

down_max:
    
    li $v0 1
    move $a0 $s3
    syscall
    j EXIT

up_max:
    
    li $v0 1
    move $a0 $s2
    syscall
    j EXIT

EXIT:

    li $v0 10              # exit
    syscall

if_less:
    
    li $v0 1
    move $a0 $s0
    syscall
    j EXIT


