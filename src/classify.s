.globl classify

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

    #TODO: Prologue
    /*
    sw s0,0(sp)
    sw s1,4(sp)
    sw s2,8(sp)
    sw s3,12(sp)
    sw s4,16(sp)
    sw s5,20(sp)
    sw s6,24(sp)
    sw s7,28(sp)
    sw s8,32(sp)
    sw s9,36(sp)
    sw s10,40(sp)
    sw s11,44(sp)
    */
    

    lw t0,1(a1)
    lw t1,2(a1)
    lw t2,3(a1)
    lw t3,4(a1)
    TODO:stack
    addi sp,sp,
    sw t0,0(sp)
    sw t1,16(sp)
    sw t2,32(sp)
    sw t3,72(sp)

    # Load pretrained m0
    lw t0,0(sp)
    mv a0,t0
    mv a1,s0
    mv a2,s1
    jal read_matrix
    sw s0,4(sp)
    sw s1,8(sp)
    sw a0,12(sp)

    # Load pretrained m1
    lw t0,16(sp)
    mv a0,t0
    mv a1,s0
    mv a2,s1
    jal read_matrix
    sw s0,20(sp)
    sw s1,24(sp)
    sw a0,28(sp)

    # Load input matrix
    lw t0,32(sp)
    mv a0,t0
    mv a1,s0
    mv a2,s1
    jal read_matrix
    sw s0,36(sp)
    sw s1,40(sp)
    sw a0,44(sp)

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    
    # hidden_layer(s12) =matmul(m0,input)

    
    # calculate the height 
    # and width of hidden_layer

    # relu(hidden_layer)

    # scores=matmul(m1,hidden_layer)

    # calculate the height and
    # width of scores


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax

    # Print classification
    mv a1,
    jal print_int
    

    # Print newline afterwards for clarity
    li a1,'\n'
    jal print_char

    # TODO:free
    
    # TODO: epilogue
    ret