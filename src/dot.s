.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
#
# If the length of the vector is less than 1, 
# this function exits with error code 5.
# If the stride of either vector is less than 1,
# this function exits with error code 6.
# =======================================================

# To make to code more readable,
# please go to view the register table in dot.c

dot:

    # Prologue
    addi sp,sp,-36
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw s3,12(sp)
    sw s4,16(sp)
    sw s5,20(sp)
    sw s6,24(sp)
    sw s7,28(sp)
    sw s8,32(sp)

    add s0,a0,x0
    add s1,a1,x0
    add s2,a2,x0
    add s3,a3,x0
    add s4,a4,x0
    
    add s5,x0,x0
    add s6,x0,x0
    
    li t0,1
    blt s2,t0,length_error
    blt s3,t0,length_error
    blt s4,t0,stride_error

loop_start:
    bge s6,s2,loop_end
    lw s7,0(s0)
    lw s8,0(s1)
    mul t0,s7,s8
    add s5,s5,t0

    addi s6,s6,1
    
    li t0,4
    mul t1,t0,s3
    add s0,s0,t1

    li t0,4
    mul t1,t0,s4
    add s1,s1,t1

    jal x0,loop_start

loop_end:
    add a0,s5,x0
    
recover_stack:
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
    addi sp,sp,36
    
    ret

length_error:
    addi a0,x0,5
    jal x0,recover_stack

stride_error:
    addi a0,x0,6
    jal x0,recover_stack