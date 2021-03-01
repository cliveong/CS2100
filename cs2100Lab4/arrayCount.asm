   # arrayCount.asm
  .data 
arrayA: .word 1, 0, 2, 0, 3, 4, 8, 16   # arrayA has 5 values
count:  .word 999             # dummy value

  .text
main:
    # code to setup the variable mappings
	la	$t0, arrayA
	la	$t1, count

    li $v0, 5 # code for reading in the user value X
	syscall
	addi $t2, $v0, 0 #load into register
	addi $t8, $t2, 0
	
    # code for counting multiples of X in arrayA
	addi $t3, $t0, 0 # start point
    addi $t4, $t0, 32 # end point
	
	addi $t9, $zero, 0 #counter
	
	loop: slt $t5, $t3, $t4 #loop till 8
		  beq $t3, $zero, end #if equal end
		  lw $t6, 0($t3) #load array
		  beq $t3, $t4, append
		  slt $t7, $t2, $t6 #if less than X
		  bne $t7, $0, loop2
		  addi $t3, $t3, 4
		  j loop
		  
	loop2: add $t8, $t8, $t2
		   slt $t7, $t8, $t6
		   bne $t7, $s0, loop2
		   addi $t8, $t2, 0
		   j append
	
	append: addi $t7, $t7, 1
			j loop
    # code for printing result

	end:
    li   $v0, 1    # print_int
    add  $a0, $t9, $zero    # integer to print
    syscall        # print the integer
	
    # code for terminating program
    li  $v0, 10
    syscall
