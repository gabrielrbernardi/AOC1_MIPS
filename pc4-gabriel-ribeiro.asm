#################################################
# Module Name: pc4-gabriel-ribeiro.asm          #
# Author: Gabriel Ribeiro Bernardi              #
# Registration: 11821BCC036                     #
# Start Date: 09/18/2019                        #
# End Date: 09/18/2019                          #
# Programming Language: Assembly MIPS           #
#################################################
#Description (pt_BR): Fazer um programa que efetue o calculo dos digitos verificadores do CPF usando array de inteiros e funções.
#Description (en_US): Make a program that calculate the CPF check digits using array of integers and functions.

# Informations:
# $t0 register is index
# #t1 register is used to load world
# t2 register is used to sum numbers

# Fazer a verificacao em relacao ao cpf, na funcao verificaCPF. Olhar o arquivo txt no mesmo local onde estava esse arquivo

.data
    Separators: .asciiz "-----=====-----=====-----=====-----=====\n"
    Intro: .asciiz "CPF check digits\n"
    CPF: .space 36										# Allocate a space for the array. As CPF have 9 numbers, we will allocate 36 bytes, because 4 bytes * 9 numbers
    CPF1: .space 36										# allocate a space for the secundary array to receive the resulf of miltiplication.
    cpfDigit: .space 44								# allocate a space for array to receive the 
    Input: .asciiz "Input CPF digits: "
    newline: .asciiz "\n"
    Output: .asciiz "The CPF numbers is: "
    
.text
    li $v0, 4											# Preparing to receive a String
    la $a0, Separators									# Print the Separators label
    syscall												# Execute the previous instructions
    
    li $v0, 4											# Preparing to receive a String
    la $a0, Intro										# Print the Intro label
    syscall												# Execute the previous instructions
       
    #li $v0, 5
    #syscall
    
    #addi $s0, $zero, 4									# Set $s0 to 4
    #addi $s1, $zero, 10									# Set $s0 to 10
    #addi $s2, $zero, 12 								# Set $s0 to 4
    
    li $t0, 0											# Set index to $t0, that starts with zero.
    li $t1, 0
    li $t2, 0											# Set $t2 as sum and starts with 0
    li $t3, 10											# Registrator used by making a multiplication in verificaCPF
    li $t6, 11
    li $t7, 11
    li $t8, 11
    li $s3, 0
    li $s4, 0
    li $s5, 11
    j loop
    
loop:
	beq $t0, 36, clearIndex								# Check if the index is 36, because if the index number is 32, we store the last number on the array
	
	li $v0, 4											# Preparing to receive a String
    la $a0, Input										# Print the Input label
    syscall												# Execute the previous instructions
    
	li $v0, 5											# Read an integer number from keyboard
	syscall												# Calling system
	move $s0, $v0
	sw $s0, CPF($t0)									# Store int the array in the $t0 postition, the typed number
	addi $t0, $t0, 4									# Add 4 to index number
	
	j loop												# Jump to loop

clearIndex:
	addi $t0, $zero, 0
	li $v0, 4
	la $a0, Separators
	syscall
	li $v0, 4											# Preparing to receive a String
    la $a0, Output										# Print the Input label
    syscall												# Execute the previous instructions
	#li $t0, 0
	#j printSeparators
	j printArray
						
printArray:
	beq $t0, 36, end
	lw $t1, CPF($t0)									# Load the number in index2 position on the array and store in $t1 registrator
	li $v0, 1											# Print an integer number
	move $a0, $t1										# Move the number in index position to $a0 to print
	li $v0, 1											# Print an integer number
	syscall												# Call system
	
	addi $t0, $t0, 4									# Increase by 4 the index
	
	beq $t0, 36, printSeparators						# If the index1 is greater or equals 36 jump to printSeparators
	j printArray										# Else jump to printArray
	
printSeparators: 
	li $v0, 4											# Preparing to receive a string
	la $a0, newline										# Print the label newLine
	syscall												# Calling system
	li $v0, 4
	la $a0, Separators
	syscall
	addi $t0, $zero, 0
	j clearIndex
	
verificaCPF1:
	beq $t3, 1, somaResultadosCPF1						# if the number that we will multiply equals zero, jump to somaResultadosCPF1
	lw $t1, CPF($t0)									# Load the number in the array
	mulo $t4, $t1, $t3									# multiply numbers in the first verification
	subi $t3, $t3, 1									# decrease the number that multiply each CPF digit
	
	sw $t4, CPF1($t0)									# Store int the array in the $t0 postition, the multiplication result
	addi $t0, $t0, 4									# update the index
	bne $t0, 36, verificaCPF1							# if $t0 not equal 36, exeecute the loop
	li $t1, 0
	addi $t0, $zero, 0
	j somaResultadosCPF1

somaResultadosCPF1:
	lw $t1, CPF1($t0)									# Load the result of multiplication
	add $t2, $t2, $t1									# increase the $t2 that be a sum
	addi $t0, $t0, 4									# update the index
	bne $t0, 36, somaResultadosCPF1						# if $t0 not equal 36, remake the loop
	mulo $t5, $t2, 10
	div $t5, $t6
	mfhi $t6
	
	beq $t6, 10, atribuiResto1							# if the rest equals zero, jump to atribuiResto
	j verificaCPF2

verificaCPF2:
	beq $t3, 1, somaResultadosCPF2						# if the number that we will multiply equals zero, jump to somaResultadosCPF1
	lw $t1, CPF($t0)									# Load the number in the array
	mulo $t4, $t1, $t8									# multiply numbers in the first verification
	subi $t8, $t8, 1									# decrease the number that multiply each CPF digit
	
	sw $t4, CPF1($t0)									# Store int the array in the $t0 postition, the multiplication result
	addi $t0, $t0, 4									# update the index
	bne $t0, 36, verificaCPF1							# if $t0 not equal 36, exeecute the loop
	li $t1, 0
	addi $t0, $zero, 0
	j somaResultadosCPF2

somaResultadosCPF2:
	lw $t1, CPF1($t0)									# Load the result of multiplication
	add $t2, $t2, $t1									# increase the $t2 that be a sum
	addi $t0, $t0, 4									# update the index
	bne $t0, 36, somaResultadosCPF1						# if $t0 not equal 36, remake the loop
	mulo $t5, $t2, 10
	div $t5, $t7
	mfhi $t7
	
	beq $t7, 10, atribuiResto2							# if the rest equals zero, jump to atribuiResto
	j calculoDigito1

calculoDigito1:
	beq $t7, 0, digito01								# if the first rest equals 0, first digit is 0
	beq $t7, 1, digito01								# if the first rest equals 1, first digit is 0
	
	sub $s3, $s5, $s3
	j calculoDigito2
	
calculoDigito2:
	beq $t7, 0, digito01								# if the second rest equals 0, second digit is 0
	beq $t7, 1, digito01								# if the second rest equals 1, second digit is 0
	
	sub $s4, $s5, $s4
	j end

digito01:
	li $s3, 0

digito02:
	li $s4, 0
	
atribuiResto1:
	li $t6, 0											# $t6 receive zero
	j verificaCPF2

atribuiResto2:
	li $t7, 0											# $t7 receive zero
	
end:
	li $v0, 10											# End of the program
    syscall												# Call system
