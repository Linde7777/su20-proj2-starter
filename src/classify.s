.globl classify

.data
p0: .word 0
p1: .word 0
p2: .word 0
p3: .word 0
p4: .word 0
p5: .word 0

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # 
    # If there are an incorrect number of command line args,
    # this function returns with exit code 49.
    #
    # Usage:
    #   main.s -m -1 <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>


    #TODO: Check the number of argument


	# =====================================
    # LOAD MATRICES
    # =====================================

    # Prologue
    #lw t0,1(a1)
    #lw t1,2(a1)
    #lw t2,3(a1)
    #lw t3,4(a1)

    # the follwing 4 lines is
    # in convience of debug
    # delete these line when you run
    mv t0,s0
    mv t1,s1
    mv t2,s2
    mv t3,s3

    addi sp,sp,-92
    sw t0,0(sp)
    sw t1,16(sp)
    sw t2,32(sp)
    sw t3,72(sp)
    sw a0,80(sp)
    sw a2,84(sp)
    sw ra,88(sp)

    # Load pretrained m0
    lw a0,0(sp)
    la s0,p0
    la s1,p1
    mv a1,s0
    mv a2,s1
    jal read_matrix
    lw t0,0(s0)
    lw t1,0(s1)
    sw t0,4(sp)
    sw t1,8(sp)
    sw a0,12(sp)

    # Load pretrained m1
    lw a0,16(sp)
    la s0,p2
    la s1,p3
    mv a1,s0
    mv a2,s1
    jal read_matrix
    lw t0,0(s0)
    lw t1,0(s1)
    sw t0,20(sp)
    sw t1,24(sp)
    sw a0,28(sp)

    # Load input matrix
    lw a0,32(sp)
    la s0,p4
    la s1,p5
    mv a1,s0
    mv a2,s1
    jal read_matrix
    lw t0,0(s0)
    lw t1,0(s1)
    sw t0,36(sp)
    sw t1,40(sp)
    sw a0,44(sp)

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    
    # hidden_layer =matmul(m0,input)
    # calculate the size of hidden_layer
    # then malloc hidden_layer
    lw s0,4(sp)
    lw s1,40(sp)
    mul t0,s0,s1
    li t1,4
    mul t0,t0,t1
    mv a0,t0
    jal malloc
    mv s2,a0    # s2->hidden_layer
    sw s2,48(sp)
    sw s0,52(sp)
    sw s1,56(sp)

    # call matmul()
    lw a1,4(sp)
    lw a5,40(sp)
    lw a2,8(sp)
    lw a4,36(sp)
    lw a0,12(sp)
    lw a3,44(sp)
    lw a6,48(sp)
    jal matmul

    # relu(hidden_layer)
    lw a0,48(sp)
    lw t0,52(sp)
    lw t1,56(sp)
    mul t2,t0,t1
    mv a1,t2
    jal relu

    # scores=matmul(m1,hidden_layer)
    # calculate the size of score
    # then malloc score
    lw s0,20(sp)
    lw s1,52(sp)
    mul t0,s0,s1
    li t1,4
    mul t0,t0,t1
    mv a0,t0
    jal malloc
    mv s2,a0    # s2->score
    sw s2,60(sp)
    sw s0,64(sp)
    sw s1,68(sp)

    # call matmul()
    lw a1,20(sp)
    lw a2,24(sp)
    lw a4,52(sp)
    lw a5,56(sp)
    lw a0,28(sp)
    lw a3,48(sp)
    mv a6,s0
    jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0,72(sp)
    lw a1,60(sp)
    lw a2,64(sp)
    lw a3,68(sp)
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    lw a0,60(sp)
    lw t0,64(sp)
    lw t1,68(sp)
    mul t2,t0,t1
    mv a1,t2
    jal argmax

    # Print classification
    mv a1,a0
    jal print_int

    # Print newline afterwards for clarity
    li a1,'\n'
    jal print_char

end:
    lw a0,12(sp)
    jal free
    lw a0,28(sp)
    jal free
    lw a0,44(sp)
    jal free
    lw a0,48(sp)
    jal free
    lw a0,60(sp)
    jal free

    # TODO: epilogue
    lw a0,80(sp)
    lw a2,84(sp)
    lw ra,88(sp)
    addi sp,sp,92

    ret