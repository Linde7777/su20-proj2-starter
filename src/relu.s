.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
#
# If the length of the vector is less than 1, 
# this function exits with error code 8.
# ==============================================================================

#void relu(int* arr, int elem){
#   
#   for(int i=0;i<elem;i++){
#       //addr+i
#       if(arr[i]<0){ 
#           arr[i]=0;
#       }
#   }
#
#   }

relu:
    # Prologue
    addi sp,sp,-16
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw ra,12(sp)

    mv s0,a0    #s0->ptr to arr
    mv s1,a1    #s1->number of element
    li s2,0     #s2->i

    li t0,1
    blt s1,t0,error

loop_start:
    beq s1,s2,loop_end
    
    lw t0,0(s0)

    bge t0,x0,loop_continue
    
    li t0,0
    sw t0,0(s0)

loop_continue:
    addi s2,s2,1
    addi s0,s0,4
    jal x0,loop_start

loop_end:
    # Epilogue
    lw s0,0(sp)
    lw s1,4(sp)   
    lw s2,8(sp)
    lw ra,12(sp)
    addi sp,sp,16
 
	ret

error:
    addi a0,x0,8
    jal x0,loop_end