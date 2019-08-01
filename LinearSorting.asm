.data
array_A: .word 0, 2, 1, 6, 4, 3, 5, 3
array_B: .word 0, 0, 0, 0, 0, 0, 0, 0
array_C: .word 0, 0, 0, 0, 0, 0, 0

out1: .asciiz "A[] = \n"
free_space: .asciiz " "
new_line: .asciiz "\n"
out2: .asciiz "B[] = \n"

.text

.globl main

main:

la $8, array_A
la $9, array_B
la $10, array_C

addi $11,$0,1 # i = 1
addi $12,$0,8 # n = 8
addi $13,$0,7 # k = 7

entry_loop1:
    slt $14,$11,$12 # $14 = 1 if $11 < $12 else $14 = 0
    beq $14,$0,exit_loop1
    
    sll $15,$11,2
    add $15,$15,$8
    lw $16,0($15)

    sll $17,$16,2
    add $18,$17,$10
    lw $19,0($18) # C[i]

    addi $19,$19,1
    sw $19,0($18)

    addi $11,$11,1

    j entry_loop1

exit_loop1:
    addi $11,$0,2

entry_loop2:

    slt $14,$11,$13 # $14 = 1 if $11 < $13 else $14 = 0
    beq $14,$0,exit_loop2

    addi $19,$11,-1
    
    sll $15,$19,2
    add $16,$15,$10
    lw $17,0($16)
    lw $18,4($16)

    add $20,$17,$18
    sw $20,4($16)

    addi $11,$11,1

    j entry_loop2

exit_loop2:

    addi $11,$12,-1

entry_loop3:

    slti $14,$11,1 # $14 = 1 if $11 < 1 else $14 = 0
    bne $14,$0,exit_loop3

    sll $15,$11,2
    add $16,$15,$8
    lw $16,0($16) # A[i]

    sll $17,$16,2
    add $18,$17,$10
    lw $21,0($18) # C[A[i]]

    sll $19,$21,2
    add $20,$19,$9
    sw $16,0($20) # B[C[A[i]]] = A[i]

    addi $21,$21,-1
    sw $21,0($18)

    addi $11,$11,-1

    j entry_loop3


exit_loop3:

    li $v0,4
    la $a0, out1
    syscall

entry_loop4:

    add $11,$0,$0

    slt $14,$11,$12 # $14 = 1 if $11 < $12 else $14 = 0
    beq $14,$0,exit_loop4

    li $v0,4
    la $a0,free_space
    syscall

    sll $15,$11,2
    add $15,$15,$8
    lw $16,0($15)

    li $v0,1
    add $a0,$16,$0
    syscall

    add $11,$11,1

    j entry_loop4

exit_loop4:

    li $v0,4
    la $a0,new_line
    syscall

    li $v0,4
    la $a0, out2
    syscall

entry_loop5:

    add $11,$0,$0

    slt $14,$11,$12 # $14 = 1 if $11 < $12 else $14 = 0
    beq $14,$0,exit_loop5

    li $v0,4
    la $a0,free_space
    syscall

    sll $15,$11,2
    add $15,$15,$9
    lw $16,0($15)

    li $v0,1
    add $a0,$16,$0
    syscall

    add $11,$11,1

    j entry_loop5


exit_loop5:

    li $v0,4
    la $a0,new_line
    syscall

    ori   $v0, $0, 10     # system call 10 for exit
    syscall               # we are out of here.