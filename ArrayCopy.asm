.data # data section
source: .word 3, 1, 4, 1, 5, 9, 0 # data for addition
dest: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.text # text section

.globl main # call main by SPIM

main:

la $8, source # $8 = &source[0]
la $9, dest # $9 = &dest[0]

add $10, $0, $0 # k = $10

entry_loop: 
    sll $21,$10,2 # k_1 = k*4
    add $13,$21,$8 # $13 = 4*k(&source[0])
    lw $11,0($13) # $11 = source[k]
    beq $11,$0,exit_loop # jump to exit_loop if $11 == 0
    add $12,$21,$9 # $12 = 4*k(&source[0])
    sw $11,0($12) # $11 = dest[k]
    addi $10,$10,1 # k = k+1
    j entry_loop # jump to entry_loop

exit_loop: 
    ori   $v0, $0, 10     # system call 10 for exit
    syscall               # we are out of here.

