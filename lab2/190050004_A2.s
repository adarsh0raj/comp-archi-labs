.data 

prompt_one: .asciiz "Enter n: "                          # First Prompt
prompt_two: .asciiz "Enter r: "                          # Second Prompt
prompt_three: .asciiz "Wish to continue?:"               # Third prompt

.text

comb:
    addi $sp, $sp, -16
    sw $ra, 0($sp)
    sw $a0, 4($sp)
    sw $a1, 8($sp)
    sw $s0, 12($sp)

    slt $t0, $a0, $a1
    bne $t0, $0, return0

    beq $a1, $a0, return1
    beq $a1, $0, return1

    j comb_body

return0:
    addi $v0, $0, 0
    j comb_exit

return1:
    addi $v0, $0, 1
    j comb_exit

comb_body:
    addi $a0, $a0, -1
    jal comb

    move $s0, $v0

    addi $a1, $a1, -1
    jal comb

    add $t1, $s0, $v0
    move $v0, $t1
  
comb_exit:
    
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

    li $v0, 5                # read input n
    syscall
    move $t0, $v0            # store n in t0 (temporary)

    li $v0, 4
    la $a0, prompt_two
    syscall

    li $v0, 5
    syscall
    move $a1, $v0          # store r in args[1]
    move $a0, $t0          # store n in args[0]

    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal comb

    lw $ra, 0($sp)
    addi $sp, $sp, 4

    move $a0, $v0
    li $v0, 1
    syscall

EXIT:

    li $v0 10              # exit
    syscall

