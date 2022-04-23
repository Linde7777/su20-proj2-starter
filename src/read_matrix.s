.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
# If you receive an fopen error or eof, 
# this function exits with error code 50.
# If you receive an fread error or eof,
# this function exits with error code 51.
# If you receive an fclose error or eof,
# this function exits with error code 52.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp,sp,-40
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw s3,12(sp)
    sw s4,16(sp)
    sw s5,20(sp)
    sw s6,24(sp)
    sw s7,28(sp)
    sw s9,32(sp)
    sw ra,36(sp)

    mv s0,a0    
    mv s1,a1    
    mv s2,a2    

    # fopen
    mv a1,s0
    li a2,0
    jal fopen
    # now a0->file id
    mv s3,a0
    li t0,-1
    beq s3,t0,fopen_error

    # fread nrows
    mv a1,a0
    mv a2,s1
    li a3,4
    jal fread
    mv s1,a2
    li t0,4
    bne a0,t0,fread_error

    # fread ncols
    mv a1,a0
    mv a2,s2
    li a3,4
    jal fread
    mv s2,a2
    li t0,4
    bne a0,t0,fread_error

    # malloc   
    lw s4,0(s1)
    lw s5,0(s2)
    mul t1,s4,s5
    mv a0,t1
    jal malloc
    # now a0->matrix
    mv s6,a0

    # fread the matrix
    mv s7,s6    
    li s8,0

loop_start:
    bge s8,t1,loop_end  #line 62,t1->size of matrix

    mv a1,s3
    mv a2,s7
    li a3,4
    jal fread

    addi s7,s7,4
    addi s8,s8,1
    jal x0,loop_start

loop_end:

    # fclose      
    mv a1,s3
    jal fclose
    # now a0-> 0 close success, -1 fail
    li t0,-1
    beq a0,t0,fclose_error

    # Epilogue
    mv a0,s6

recover_stack:
    lw s0,0(sp)
    lw s1,4(sp)
    lw s2,8(sp)
    lw s3,12(sp)
    lw s4,16(sp)
    lw s5,20(sp)
    lw s6,24(sp)
    lw s7,28(sp)
    lw s9,32(sp)
    lw ra,36(sp)
    addi sp,sp,40

    ret

fopen_error:
    li a0,50
    jal x0,recover_stack

fread_error:
    li a0,51
    jal x0,recover_stack

fclose_error:
    li a0,52
    jal x0,recover_stack