.data
array_a: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
array_b: .word 0x7ffffffff, 0x7ffffffe, 0x7ffffffd, 0x7ffffffc, 0x7ffffffb, 0x7ffffffa, 0x7ffffff9, 0x7ffffff8, 0x7ffffff7, 0x7ffffff6

array_outa: .asciiz "Sum a = "
array_outb: .asciiz "Sum b = "
new_line: .asciiz "\n"

.text

.globl main

main:

la $8,array_a
la $9,array_b

add $10,$0,$0 # $10 = i = 0
add $11,$0,$0 # $11 = sum = 0

entry_loop1:
    slti $13,$10,20
    beq $13,$0,exit_loop1
    sll $12,$10,2 # $12 = i*4
    add $12,$12,$8
    lw $14,0($12)
    add $11,$11,$14
    addi $10,$10,1
    j entry_loop1

exit_loop1:

    #############print(sum)

    li $v0, 4
    la $a0, array_outa
    syscall

    li $v0, 1
    add $a0,$11,$0
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    ############# end print(sum)

    add $10,$0,$0 # $10 = i = 0
    add $11,$0,$0 # $11 = sum = 0

entry_loop2:
    slti $13,$10,10
    beq $13,$0,exit_loop2
    sll $12,$10,2 # $12 = i*4
    addu $12,$12,$9
    lw $14,0($12)
    addu $11,$11,$14
    addiu $10,$10,1
    j entry_loop2

exit_loop2:
    #############print(sum)

    li $v0, 4
    la $a0, array_outb
    syscall

    li $v0, 1
    add $a0,$11,$0
    syscall

    li $v0, 4
    la $a0, new_line
    syscall

    ############# end print(sum)




ori   $v0, $0, 10     # system call 10 for exit
syscall               # we are out of here.
