
.data
	next_line: .asciiz "\n"	
.text
#input: N= how many numbers to sort should be entered from terminal. 
#It is stored in $t1	
jal input_int 
move $t1,$t4			

#input: X=The Starting address of input numbers (each 32bits) should be entered from
# terminal in decimal format. It is stored in $t2
jal input_int
move $t2,$t4

#input:Y= The Starting address of output numbers(each 32bits) should be entered
# from terminal in decimal. It is stored in $t3
jal input_int
move $t3,$t4 

#input: The numbers to be sorted are now entered from terminal.
# They are stored in memory array whose starting address is given by $t2
move $t8,$t2
move $s7,$zero	#i = 0
loop1:  beq $s7,$t1,loop1end
	jal input_int
	sw $t4,0($t2)
	addi $t2,$t2,4
      	addi $s7,$s7,1
        j loop1      
loop1end: move $t2,$t8       
#############################################################
#Do not change any code above this line
#Occupied registers $t1,$t2,$t3. Don't use them in your sort function.
#############################################################
#function: should be written by students(sorting function)

#COPY THE CONTENTS STARTING FROM MEMORY LOCATION X TO Y 
move $t8,$t2    # Temporarily storing address of input in $t8
move $t9,$t3    # Temporarily storing address of output in $t9
move $s7,$zero  # i = 0
ForCopyLoop: beq $s7,$t1,ForCopyLoopEnd    
	     lw $s1,0($t2)   # Load $s1 <- Mem[$t2 + 0]
	     sw $s1,0($t3)   # Store Mem[$t3 + 0] <- $s1
	     
	     #memory location increment
	     addi $t2,$t2,4   # $t2 = $t2 +4
	     addi $t3,$t3,4   # $t3 = $t3 +4
	     
	     #counter increment to take care of the number of numbers copied
	     addi $s7,$s7,1   # i = i + 1
	     j ForCopyLoop    # Repeat process
	     
ForCopyLoopEnd: move $t2,$t8    # $t2 = $t8 = X
                move $t3,$t9    # $t3 = $t9 = Y
                move $s7,$zero  # s7 = 0

move $t5,$t1     #t5 = t1 = N
move $t7,$t3     #t7 = t3 = Y.  Let $t7 be named Z.
subi $t5,$t1,1   #t5 = N-1                                 

#SORTING ALGO STARTS
Bubblesort: beq $s7,$t5,BubblesortEnd   # if (i = N-1), then exit the bubblesort algorithm as all numbers will be sorted
            move $s6,$zero   # j = 0
            move $t7,$t3     # Reset Z = Y for each inner for loop
            subi $t6,$t1,1   # j = N-1
            sub $t6,$t6,$s7  # j = N-1-i
            li $t0,4         # to be used to increment memory locations starting from Y
            
            InnerForLoop: beq $s6,$t6,ExitInnerForLoop   # if (j = N-1-i), then jump to ExitInnerForLoop
                          lw $t8,0($t7)                  #load $t8 <- Mem(Z), initially Z = Y
                          lw $t9,4($t7)                  #load $t9 <- Mem(4+Z)
                          slt $s3,$t8,$t9                #if Mem(Z) > Mem(Z+4), then $s3=0
                          beq $s3,$zero,Swap             #if $s3 = 0, swap both of them to sort in ascending order
                          
                   remain_InnerForLoop: #This loop needs to be executed in both the conditions, 
                                        #whether there is a swap or not.
                                        addi $s6,$s6,1    # j++
                                        addi $t7,$t7,4    # Z = Z + 4
                                        j InnerForLoop    # Jump to InnerForLoop
                          
                          
                          Swap: move $s0,$t8   # $t8 <- $s0
                                move $t8,$t9   # $t9 <- $t8
                                move $t9,$s0   # $s0 <- $t9
                                sw $t8,0($t7)  # Store Mem[$t7 + 0] <- $t8, i.e, Mem(Z) <- Mem(Z+4)
                                sw $t9,4($t7)  # Store Mem[$t7 + 4] <- $t8, i.e, Mem(Z+4) <- Mem(Z)
                                j remain_InnerForLoop    # Jump to remain_InnerForLoop
                                
	      ExitInnerForLoop: addi $s7,$s7,1   # i++
	                      j Bubblesort       # Jump to Bubblesort 
	                      
              
BubblesortEnd: 

#SORTING ALGO ENDS

#endfunction
#############################################################
#You need not change any code below this line

#print sorted numbers
move $s7,$zero	#i = 0
loop: beq $s7,$t1,end
      lw $t4,0($t3)
      jal print_int
      jal print_line
      addi $t3,$t3,4
      addi $s7,$s7,1
      j loop 
#end
end:  li $v0,10
      syscall
#input from command line(takes input and stores it in $t6)
input_int: li $v0,5
	   syscall
	   move $t4,$v0
	   jr $ra
#print integer(prints the value of $t6 )
print_int: li $v0,1		#1 implie
	   move $a0,$t4
	   syscall
	   jr $ra
#print nextline
print_line:li $v0,4
	   la $a0,next_line
	   syscall
	   jr $ra

