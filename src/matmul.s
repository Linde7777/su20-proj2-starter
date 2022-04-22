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
    addi sp,sp,-52
    sw ra,0(sp)
    sw s0,4(sp)
    sw s1,8(sp)
    sw s2,12(sp)
    sw s3,16(sp)
    sw s4,20(sp)
    sw s5,24(sp)
    sw s6,28(sp)
    sw s7,32(sp)
    sw s8,36(sp)
    sw s9,40(sp)
    sw s10,44(sp)
    sw s11,48(sp)
    
    # TODO 
    # mv s0, a0
    
    add s7,s1,x0
    add s8,s1,x0
    add s9,s6,x0
    add s10,x0,x0
    add s11,x0,x0

outer_loop_start:
    bge s10,s7,outer_loop_end

    # la ra,outer_loop_start
    jal ra,inner_loop_start
    addi s10,s10,1
    
    jal x0,outer_loop_start



inner_loop_start:
    bge s11,s8,inner_loop_end
    
    mv a0,s0
    mv a1,s3
    mv a2,s2
    li a3,1
    mv a4,s5
    jal ra,dot

    sw a0,0(s9)
    addi s9,s9,1
    addi s11,s11,1

    jal x0,inner_loop_start


inner_loop_end:
    ret


outer_loop_end:
    
    # Epilogue
    lw ra,0(sp)
    lw s0,4(sp)
    lw s1,8(sp)
    lw s2,12(sp)
    lw s3,16(sp)
    lw s4,20(sp)
    lw s5,24(sp)
    lw s6,28(sp)
    lw s7,32(sp)
    lw s8,36(sp)
    lw s9,40(sp)
    lw s10,44(sp)
    lw s11,48(sp)
    
    addi sp,sp,52

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