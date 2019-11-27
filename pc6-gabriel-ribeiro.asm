#################################################
# Module Name: pc6-gabriel-ribeiro.asm          #
# Author: Gabriel Ribeiro Bernardi              #
# Registration: 11821BCC036                     #
# Start Date: 11/26/2019                        #
# End Date: 11/26/2019                          #
# Programming Language: Assembly MIPS           #
#################################################

# The description of this exercice is inside github repository, on this following link: https://github.com/gabrielrbernardi/AOC1_MIPS/blob/master/pc6-Description.txt
# This program was made to training the use of recursion

#reg: $sp: stack pointer, ($sp): stack
# Inside main function
    #reg: $t0: receive the input number. After store this value on top of stack, this registrator receive 0
    #reg: $t1: this registrator will be setted to be the value of decrement, used inside the recursion function
# Inside recursion function
    #reg: $t0: receive the value of top of stack
    #reg: $t1: used to decrease value of $t0 registrator
# Inside error function:
    # the application will print an error label
# Inside endProgram function:
    # the application will print an ending label and then finish the program

.text
    .globl main
    j main

    recursion:
        lw $t0, ($sp)           # load in $t0 registrator, the value of top of stack
        addi $sp, $sp, 4        # incrementing stack pointer by 4
        
        move $a0, $t0           # moving value of $t0 to $a0 and then preparing to print an integer number
        li $v0, 1               # syscall that print an integer value
        syscall                 # do it

        beq $t0, 0, endProgram  # if value inside $t0 registrator equals zero, branch to endProgram label
                                # otherwise, the programming counter will continue to run within this function
        li $v0, 4               # preparing to print a string
        la $a0, trace           # load adress for trace label
        syscall                 # do it
        
        sub $t0, $t0, $t1       # decreasing value of $t0 registrator
        
        addi $sp, $sp, -4       # decrement stack pointer by 4
        sw $t0, ($sp)           # store $t0 to stack (push)
        j recursion

    error:
        li $v0, 4               # preparing to receive a string
        la $a0, error1          # this instruction will print an error1 label
        syscall                 # do it
        # after this error label, the programing counter will continue to endProgram label, and so, no needs a jump instruction

    endProgram:
        li $v0, 4               # preparing to receive a string
        la $a0, ending          # this instruction will print an ending label
        syscall                 # do it
        li $v0, 10				# li with code 10 means that the execution ends
        syscall					# do it

    main:
        li $v0, 4               # preparing to print a string
        la $a0, intro           # load adress for intro label
        syscall                 # do it
        li $v0, 4               # preparing to print a string
        la $a0, input           # load adress for input label
        syscall                 # do it
        li $v0, 5               # preparing to receive an integer number
        syscall                 # do it

        move $t0, $v0           # move $v0 value to $t0

        blt $t0, $zero, error

        li $v0, 4               # preparing to print a string
        la $a0, output          # load adress for output label
        syscall                 # do it

        addi $sp, $sp, -4       # decrement stack pointer by 4
        sw $t0, ($sp)           # store $t0 to stack (push)
        
        li $t0, 0               # setting the $t0 registrator to zero
        li $t1, 1               # setting value 1 to $t1 registrator

        jal recursion

        j endProgram

.data
    intro: .asciiz "=-=-=-=-=-=- RECURSION =-=-=-=-=-=-\n"
    input: .asciiz "X = "
    newLine: .asciiz "\n"
    trace: .asciiz " - "
    output: .asciiz "\nOutput: "
    error1: .asciiz "\nThis program just allow positive values\n"
    ending: .asciiz "\nEND OF PROGRAM\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="