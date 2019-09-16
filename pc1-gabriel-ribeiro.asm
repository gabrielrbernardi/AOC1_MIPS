#################################################
# Module Name: pc1-gabriel-ribeiro.asm		#
# Author: Gabriel Ribeiro Bernardi		#
# Registration: 11821BCC036			#
# Start Date: 09/01/2019			#
# End Date: 09/02/2019				#
# Programming Language: Assembly MIPS		#
#################################################

	.text
main:						#Section with main code, that be executed
	li $v0, 4				#Identify an String by 4 bytes size
	la $a0, HelloWorld			#Adress of function HelloWorld
	syscall					#Perform the previous and following instructions and close the application

	.data					#Section where the informations will be allocated on RAM memory
	HelloWorld: .asciiz "\nHello World\n"	#HelloWorld function, where starting from the characters from ascii table, 
						#and the String will be printed on the user screen
	
