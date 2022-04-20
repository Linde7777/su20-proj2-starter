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

    addi s0,a0,0    #arr
    addi s1,a1,0    #number of element
    addi s2,x0,0    #i

loop_start:
    beq s1,s2,loop_end
    
    addi s0,s0,4
    lw t0,0(s0)

    bge t0,x0,loop_continue
    
    addi s2,s2,1
    jal x0,loop_start

loop_continue:
    addi s2,s2,1
    jal x0,loop_start

loop_end:
    # Epilogue
    
	ret