#################################################
# Module Name: pc3-gabriel-ribeiro.asm          #
# Author: Gabriel Ribeiro Bernardi              #
# Registration: 11821BCC036                     #
# Start Date: 09/13/2019                        #
# End Date: 09/16/2019                          #
# Programming Language: Assembly MIPS           #
#################################################
#Description (pt_BR): Fazer um programa que faca a Conjectura de Collatz. Filtrar os valores menores ou iguais a zero.
#Description (en_US): Make a program that makes a Collatz Conjecture. Filter values less than or equals zero.

.data
    Intro: .asciiz "++++++++++++++++++++++++++++++\nCollatz conjecture\n\n"
    Number: .asciiz "Type a value to K: "
    Sequence: .asciiz "\nThe sequence of Collatz conjecture is:\n"
    Space: .asciiz " "
    Zero: .asciiz "\nThe value is zero"
    LessThan: .asciiz "\nThe value is less than zero"
    NotAllowed: .asciiz "\nValue not allowed"
    PlusSimbols: .asciiz "\n++++++++++++++++++++++++++++++"
    End: .asciiz "\n\nEnd of program\n++++++++++++++++++++++++++++++"
    
.text
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, Intro				# Print a label "Intro" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, Number				# Print a label "Number" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 5					# Receive an Integer numbem from user keyboard
    syscall					# Run this previous intruction too
 
    #Filter the values if this typed numbers is less than or equals 0   
    beq $v0, 0, zero				# if the typed value is equals zero, jump to zero label and then close the program
    
    move $t0, $v0				# Move the typed Integer number stored on $v0 registrator to $t0 registrator

    li $s7, 0					# set value of $s7 registrator to zero
    slt $t4, $t0, $s7				# use this to determinate if $t0 is less than $s7. if the step is true, $t4 receive 1 else $t4 receive 0
    beq $t4, 1, lessThan			# if $t4 registrator is equals, jump to lessThan label
    #End of filter
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, PlusSimbols				# Print a label "PlusSimbols" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, Sequence				# Print a label "Sequence" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $t1, 2					# $t1 receive value 2
    div $t0, $t1				# execute the division operation, to know if the number is even or odd
    mfhi $t2					# $t2 receive the rest of division
    
    move $a0, $t0				# move the typed number to $a0 registrator
    li $v0, 1					# print the integer value
    syscall					# calling system
    
    li $v0, 4					# preparing to print a string
    la $a0, Space				# print a Space string stored in the label
    syscall					# calling system
    
    beq $t2, 0, even				# if the rest of division is equals zero, jump to label even and execute the instructions
    beq $t2, 1, odd				# if the rest of division is equals zero, jump to label odd and execute the instructions
    
    #j loop					# jump to loop label
    
loop:
    beq $t8, 1, end
    li $v0, 4					# preparing to print a string
    la $a0, Space				# print a Space string stored in the label
    syscall					# calling system

    li $t5, 2					# $t5 receive value 2
    div $t8, $t5				# execute the division operation, to know if the number is even or odd
    mfhi $t2					# $t2 receive the rest of division
    syscall					# calling system

    beq $t2, 1, odd				# if the rest of division is equals zero, jump to label odd and execute the instructions
    beq $t2, 0, even				# if the rest of division is equals zero, jump to label even and execute the instructions
    
odd:
    mulo $t0, $t0, 3				# Multiply the number by 3
    add $t0, $t0, 1				# Add 1 to number
    move $a0, $t0				# move the number to $a0 registrator to print
    li $v0, 1					# print the integer value
    syscall					# calling system
    move $t8, $a0
    
    j loop					# jump to end
    
even:
    div $t0, $t0, 2				# Execute the division operation by 2
    move $a0, $t0				# move the number to $a0 registrator to print
    li $v0, 1					# print the integer value
    syscall					# calling system
    move $t8, $a0

    j loop					# jump to end

zero:
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, PlusSimbols				# Print a label "PlusSimbols" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, Zero				# Print a label "Zero" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, NotAllowed				# Print a label "NotAllowed" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions

    j end					# jump to label end
    
lessThan:
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, PlusSimbols				# Print a label "PlusSimbols" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, LessThan				# Print a label "LessThan" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, NotAllowed				# Print a label "NotAllowed" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    
    j end					# jump to label end

end: 
    li $v0, 4					# Preparing to receive a String and put in $v0 registrator
    la $a0, End					# Print a label "End" and in the next instruction execute this previous instructions
    syscall					# Execute the instructions
    li $v0, 10
    syscall
