.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   The order of error codes (checked from top to bottom):
#   If the dimensions of m0 do not make sense, 
#   this function exits with exit code 2.
#   If the dimensions of m1 do not make sense, 
#   this function exits with exit code 3.
#   If the dimensions don't match, 
#   this function exits with exit code 4.
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error checks
    li t0,1
    blt a1,t0,m0_dimen_error
    blt a2,t0,m0_dimen_error
    blt a4,t0,m1_dimen_error
    blt a5,t0,m1_dimen_error
    bne a2,a4,dimen_match_error


    # Prologue


outer_loop_start:




inner_loop_start:












inner_loop_end:




outer_loop_end:


    # Epilogue
    
    
    ret

m0_dimen_error:
    addi a0,x0,2
    jal x0,outer_loop_end

m1_dimen_error:
    addi a0,x0,3
    jal x0,outer_loop_end

dimen_match_error:
    addi a0,x0,4
    jal x0,outer_loop_end