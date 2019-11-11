#################################################
# Module Name: pc5-gabriel-ribeiro.asm          #
# Author: Gabriel Ribeiro Bernardi              #
# Registration: 11821BCC036                     #
# Start Date: 11/09/2019                        #
# End Date: 11/10/2019                          #
# Programming Language: Assembly MIPS           #
#################################################

#reg: $t0, $t1, $t2: coefficients of the equation
# Inside delta function
    #reg: $t3: delta partial
    #reg: $t4, $t5: aux delta partial
# Inside bhaskara function
    #reg: $t3: store the top of stack (delta)
    #reg: $t6: store divider of general division
    #reg: $t7: quotient of division
# Inside bhaskaraNeg function
    #reg: $a0, $v0: registrators used to print the string
# Inside bhaskaraZero function
    #reg: $a0, $v0: registrators used to print the string
    #reg: $t6: receive the multiplication
    #reg: $t7: the quotient of division
# Inside sqrt function
    #reg: $t4, $t5: temp and sqrt variables
    #reg: $t6, $t7: aux registrators
# Inside bhaskaraPos function
    #reg: $a0, $v0: registrators used to print the string
    #reg: $t3, $t4: root one and root 2
    #reg: $t5: square root value of delta
    #reg: $t6: receive the multiplication
    #reg: $t7: the quotient of division
    #reg: $t8, $t9: receive values of sum operation and subtraction

.text
    j main
    delta:
        mulo $t5, $t0, $t2
        mulo $t5, $t5, 4
        mulo $t4, $t1, $t1

        sub $t3, $t4, $t5
        addi $sp, $sp, -4                            # decrement stack pointer by 4
        sw $t3, ($sp)                                # store $t3 to stack (push)

        jr $ra					                     # jump to $ra

    bhaskara:
        li $t3, 0									 # setting $t3 to value zero
        lw $t3, ($sp)		                         # store in $t3 registrator the top of stack
        addi $sp, $sp, 4                             # increment stack pointer by 4 


        li $v0, 4
        la $a0, Separators
        syscall
        li $v0, 4
        la $a0, ValorDelta
        syscall
        move $a0, $t3
        li $v0, 1
        syscall
        
        blt $t3, $zero, bhaskaraNeg                  # branch to bhaskaraNeg if $t3 less then 0
        beq $t3, $zero, bhaskaraZero                 # branch to bhaskaraZero if $t3 equals 0
        
        li $t4, 1
        li $t5, 0
        bgt $t3, $zero, sqrt                         # branch to sqrt if $t3 greater then 0
        # jr $ra                                       # jump to $ra

    bhaskaraNeg:
        li $v0, 4
        la $a0, Erro1
        syscall
        jr $ra					                     # jump to $ra

    bhaskaraZero:
        mulo $t1, $t1, -1                            # changing signal of $t1 registrator
        mulo $t6, $t0, 2                             # making the multiplication of (2 * a)
        div $t1, $t6
        mflo $t7
        
        li $v0, 4
        la $a0, Alerta1
        syscall
        li $v0, 4
        la $a0, ResultDelta0
        syscall
        move $a0, $t7                                # move $t7 content to $a0 to print
        li $v0, 1                                    # print an integer number
        syscall                                      # system call

        jr $ra					                     # jump to $ra

    bhaskaraPos:
        mulo $t1, $t1, -1                            # changing signal of $t1 registrator
        add $t8, $t1, $t5                            # receive the divider after adding the two values
        sub $t9, $t1, $t5                            # receive the divider after adding the two values
        mulo $t6, $t0, 2                             # making the multiplication of (2 * a)
        
        div $t8, $t6                                 # making the division to discover the first root
        mflo $t3                                     # receive the quotient of divison
        div $t9, $t6                                 # making the division to discover the second root
        mflo $t4                                     # receive the quotient of divison

        li $v0, 4                                    # preparing to print an string
        la $a0, ResultadoBhasPos                     # printing ResultadoBhasPos label
        syscall
        li $v0, 4                                    # preparing to print an string
        la $a0, Raiz1                                # printing Raiz1 label
        syscall

        move $a0, $t3                                # moving $t3 to $a0
        li $v0, 1                                    # preparing to print an integer number
        syscall

        li $v0, 4                                    # preparing to print an string
        la $a0, Raiz2                                # printing Raiz2 label
        syscall

        move $a0, $t4                                # moving $t4 to $a0
        li $v0, 1                                    # preparing to print an integer number
        syscall

        jr $ra					                     # jump to $ra
        
    sqrt:
        sub $t3, $t3, $t4                            # subtracting $t3 by $t4 and storing in $t3
        add $t4, $t4, 2                              # taking only the odd values
        add $t5, $t5, 1                              # updating counter
        beq $t3, $zero, bhaskaraPos                  # branch to bhaskaraPos if $t3 equals zero
        j sqrt

    #Main program    
    main:
        li $v0, 4                                        # preparing to print an string
        la $a0, Cabecalho                                # printing Cabecalho label
        syscall

        li $v0, 4                                        # preparing to print an string
        la $a0, CoefA                                    # printing CoefA label
        syscall
        li $v0, 5                                        # read an integer number (a coefficient) from keyboard
        syscall                                          # calling system
        move $t0, $v0
        
        li $v0, 4                                        # preparing to print an string
        la $a0, CoefB                                    # printing CoefB label
        syscall
        li $v0, 5                                        # read an integer number (b coefficient) from keyboard
        syscall											 # calling system
        move $t1, $v0
        
        li $v0, 4                                        # preparing to print an string
        la $a0, CoefC                                    # printing CoefC label
        syscall
        li $v0, 5                                        # read an integer number (c coefficient) from keyboard
        syscall                                          # calling system
        move $t2, $v0
        
        li $s2, 0
        jal	delta				                         # jump to delta and save position to $ra 
        jal	bhaskara    	            			     # jump to bhaskara and save position to $ra
        li $v0, 4
        la $a0, Separators
        syscall

.data
    Cabecalho: .asciiz "Digite os coeficientes da equacao:"
    CoefA: .asciiz "\na = "
    CoefB: .asciiz "b = "
    CoefC: .asciiz "c = "
    ValorDelta: .asciiz "Delta tem valor: "
    Separators: .asciiz "\n----------------------------\n"
    Erro1: .asciiz "\nNao possui raiz real"
    Alerta1: .asciiz "\nPossui 2 raizes reais iguais\n"
    ResultDelta0: .asciiz "x1 e x2 = "
    ResultadoBhasPos: .asciiz "\nRaizes\n"
    Raiz1: .asciiz "x1 = "
    Raiz2: .asciiz "\nx2 = "
