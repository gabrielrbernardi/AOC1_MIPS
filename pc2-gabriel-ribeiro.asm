#################################################
# Module Name: pc2-gabriel-ribeiro.asm          #
# Author: Gabriel Ribeiro Bernardi              #
# Registration: 11821BCC036                     #
# Start Date: 09/07/2019                        #
# End Date: 09/08/2019                          #
# Programming Language: Assembly MIPS           #
#################################################
#Description (pt_BR): O programa deve ler dois numeros inteiros, sendo o primeiro o dividendo e o segundo o divisor. Deve efetuar uma divisao inteira e imprimir o resultado e o resto.

.data
    Intro: .asciiz "+++++++++++++++++++++++++++++++++++++\nPrograma para efetuar divisao inteira\n"
    Div: .asciiz "Dividendo: "
    Divisor: .asciiz "Divisor: "
    Result: .asciiz "\nResultado: "
    Resto: .asciiz "\nResto: "
    Rodape: .asciiz "\n+++++++++++++++++++++++++++++++++++++\n"
    
.text
    # Imprime cabecalho	
    li $v0, 4				# Preparing to receive a String and put in $v0 registrator
    la $a0, Intro			# Print a label "Div" and in the next instruction execute this previous instructions
    syscall				# Execute the instructions
    #Dividendo
    li $v0, 4				# Preparing to receive a String and put in $v0 registrator
    la $a0, Div				# Print a label "Div" and in the next instruction execute this previous instructions
    syscall				# Execute the instructions
    li $v0, 5				# Receive an Integer numbem from user keyboard
    syscall				# Run this previous intruction too
    move $t0, $v0			# Move the typed Integer number stored on $v0 registrator to $t0 registrator

    #Divisor
    # This following instructions is the same of the previous instructions, so, i copied this part of the code
    li $v0, 4				# Preparing to receive a String and put in $v0 registrator
    la $a0, Divisor				# Print a label "Div" and in the next instruction execute this previous instructions
    syscall				# Execute the instructions
    li $v0, 5				# Receive an Integer numbem from user keyboard
    syscall				# Run this previous intruction too
    # End of the copied code
    move $t1, $v0			# Move the typed Integer number stored on $v0 registrator to $t1 registrator, to store the "Divisor" number

    #Resultado
    div $t0, $t1			# Execute the division with #t0 and $t1 registrator, "Dividendo" and "Divisor" numbers, respectively
    mflo $s3				# Catch the low result for division. and put on $s3 registrator
    mfhi $s4				# Catch the high result as rest of division and put this on $s4 registrator
    
    li $v0, 4				# Preparing to receive a String
    la $a0, Result			# Print the String stored int the "Result" label
    syscall
    li $v0, 1				# Preparing to print a Integer result
    move $a0, $s3			# Print the result stored in the $s3 registrator
    syscall				# Execute this previous instructions

    #Resto
    li $v0, 4				# Preparing to receive a String and put in $v0 registrator
    la $a0, Resto			# Print a label "Div" and in the next instruction execute this previous instructions
    syscall				# Execute the instructions
    li $v0, 1				# Preparing to print a Integer result
    move $a0, $s4			# Move the "Resto" of the division stored on the $s4 registrator and put this on $a0 registrator
    syscall				# Execute this previous instructions and print the $a0 registrator on the user screen
    
    #Imprime rodape
    li $v0, 4				# Preparing to receive a String and put in $v0 registrator
    la $a0, Rodape			# Print a label "Div" and in the next instruction execute this previous instructions
    syscall				# Execute the instructions
