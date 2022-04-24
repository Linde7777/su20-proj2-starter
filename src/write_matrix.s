.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
#   TODO: exit2 a1->exit code
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
#
# If you receive an fopen error or eof, 
# this function exits with error code 53.
# If you receive an fwrite error or eof,
# this function exits with error code 54.
# If you receive an fclose error or eof,
# this function exits with error code 55.
# ==============================================================================
write_matrix:

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
    sw s8,32(sp)
    sw ra,36(sp)

    mv s0,a0
    mv s1,a1
    mv s2,a2
    mv s3,a3
    mv s7,s2
    mv s8,s3

    # fopen 
    mv a1,s0
    li a2,1
    jal fopen
    mv s4,a0
    li t0,-1
    beq a0,t0,fopen_error

    # fwrite the nrows
    mv a1,s4
    mv a2,s7
    li a3,1
    li a4,4
    jal fwrite
    bne a0,a3,fwrite_error

    # fwrite the ncols
    mv a1,s4
    mv a2,s8
    li a3,1
    li a4,4
    jal fwrite
    bne a0,a3,fwrite_error

    # fwrite 9 numbers
    mul s6,s2,s3
    mv s5,s1
    mv a1,s4
    mv a2,s5
    mv a3,s6
    li a4,4
    jal fwrite
    bne a0,a3,fwrite_error

    # fclose
    mv a1,s4
    jal fclose
    li t0,-1
    beq a0,t0,fclose_error

restore_stack:
    # Epilogue
    lw s0,0(sp)
    lw s1,4(sp)
    lw s2,8(sp)
    lw s3,12(sp)
    lw s4,16(sp)
    lw s5,20(sp)
    lw s6,24(sp)
    lw s7,28(sp)
    lw s8,32(sp)
    lw ra,36(sp)
    addi sp,sp,40

    ret

fopen_error:
    li a0,53
    jal x0,restore_stack

fwrite_error:
    li a0,54
    jal x0,restore_stack

fclose_error:
    li a0,55
    jal x0,restore_stack