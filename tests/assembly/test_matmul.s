.import ../../src/matmul.s
.import ../../src/utils.s
.import ../../src/dot.s

# static values for testing
.data
m0: .word 1 2 3 4 5 6 7 8 9
m1: .word 1 2 3 4 5 6 7 8 9
d: .word 0 0 0 0 0 0 0 0 0 # allocate static space for output

# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d

.text
main:
    # Load addresses of input matrices (which are in static memory),
    # and set their dimensions
    
    la s0,m0
    la s3,m1
    la s6,d
    
    # set the rows (height) of m0
    li s1,3   

    # set the columns (width) of m0
    li s2,3

    # set the rows (height) of m1
    li s4,3

    # set the columns (width) of m0
    li s5,3

    # Call matrix multiply, m0 * m1
    mv a0,s0
    mv a1,s1
    mv a2,s2
    mv a3,s3
    mv a4,s4
    mv a5,s5
    mv a6,s6
    jal matmul



    # Print the output (use print_int_array in utils.s)
    la s0,d
    
    # Set dimensions of d
    li s1,3 # MAKE CHANGES HERE
    li s2 3 # MAKE CHANGES HERE
    jal print_int_array



    # Exit the program
    jal exit