.data 

prompt_one: .asciiz "Enter a: "                         
prompt_two: .asciiz "Enter m: "                          
prompt_three: .asciiz "Wish to continue?: "   
char1: .asciiz "*"         
char2: .asciiz " = 1 (mod "
char3: .asciiz ")\n"

.text

gcd_extend:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)

    bne $a0, $0, gcd_body

    addi $v0, $0, 0
    addi $v1, $0, 1
    j gcd_exit

gcd_body:
    
    move $t0, $a0
    div $a1, $a0
    mfhi $a0
    move $a1, $t0
    mflo $s0

    jal gcd_extend

    move $t2, $v0
    mul $t3, $s0, $v0
    sub $v0, $v1, $t3
    move $v1, $t2
    
gcd_exit:
    
    lw $s0, 12($sp)
    lw $a1, 8($sp)
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 16

    jr $ra

main:
    li $v0, 4
    la $a0, prompt_one       # print first prompt
    syscall

    li $v0, 5                # read input a
    syscall
    move $t0, $v0            # store a in t0 (temporary)

    li $v0, 4
    la $a0, prompt_two
    syscall

    li $v0, 5
    syscall
    move $a1, $v0          # store m in args[1]
    move $a0, $t0          # store a in args[0]

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal gcd_extend

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    move $t2, $a0
    move $t3, $a1
    move $t4, $v0
    move $t5, $v1

    div $t4, $t3
    mfhi $t6
    add $t6, $t6, $t3
    div $t6, $t3
    mfhi $s1

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, char1
    syscall

    li $v0, 1
    move $a0, $s1
    syscall

    li $v0, 4
    la $a0, char2
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    li $v0, 4
    la $a0, char3
    syscall

EXIT:

    li $v0 10              # exit
    syscall

