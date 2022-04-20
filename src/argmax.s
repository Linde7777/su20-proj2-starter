.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
#
# If the length of the vector is less than 1, 
# this function exits with error code 7.
# =================================================================


argmax:
    # Prologue
    addi sp,sp,-20
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw s3,12(sp)
    sw s4,16(sp)

    add s0,a0,x0    #s0->arr
    add s1,a1,x0    #s1->length of arr
    add s2,x0,x0    #s2->i
    add t0,s0,x0    #store the s0 before it is used

    lw t1,0(s0)     #t0->arr[0]
    add s3,t0,x0    #s3->max, max=arr[0]

loop_start:
    bge s2,s1,loop_end
    
    lw s4,0(s0) #s4->arr[i]
    blt s4,s3,loop_continue
    add s3,s4,x0    #max=arr[i]

loop_continue:
    addi s2,s2,1
    addi s0,s0,4
    jal x0,loop_start

loop_end:
    add s2,x0,x0    #s2->i
    add s0,t0,x0    #recover the address of arr
    jal x0,loop2_start


loop2_start:
    bge s2,s1,loop2_end
    lw s4,0(s0) #arr[i]
    bne s3,s4,loop2_continue    #s3->max
    
    add a0,s2,x0    #now we find the index, index==i

loop2_continue:
    addi s2,s2,1
    addi s0,s0,4
    jal x0,loop2_start


loop2_end:
    # Epilogue
    lw s0,0(sp)
    lw s1,4(sp)
    lw s2,8(sp)
    lw s3,12(sp)
    lw s4,16(sp)
    addi sp,sp,20


    ret