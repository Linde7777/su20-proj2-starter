/*
classify.s
a0->argc    a1->(char**) argv
a2-> if 0, print classification
return a0->classification

0(sp)->m0_path   
4->height of m0
8->width of m0
12->ptr to m0 

16(sp)->m1_path
20->height of m1
24->width of m1
28->ptr to m1 

32(sp)->input_path
36->height of input
40->width of input
44->ptr to input 

48->ptr to hidden_layer
52->height of hidd
56->width of hidd

60->ptr to scores
64->height of scores
68->width of scores

72(sp)->output_path

76->classfication of input

80->the a0 passed in classify()
84->the a2 passed in classify()

read_matrix
a0 (char*) pointer to filename
a1 (int*)  pointer to an integer, we will set it to the number of rows
a2 (int*)  pointer to an integer, we will set it to the number of columns
Returns: a0 (int*)  pointer to matrix in memory

matmul
a0 (int*)  pointer to m0 
a1 (int)   height of m0
a2 (int)   width of m0
a3 (int*)  pointer to m1
a4 (int)   height of m1
a5 (int)   width of m1
a6 (int*)  pointer d
sets d = matmul(m0, m1)

relu
a0 (int*) pointer to the array
a1 (int) # of elements in the array
Returns: None

write_matrix
a0 (char*) pointer to filename
a1 (int*)  pointer to matrix in memory
a2 (int)   height of  matrix
a3 (int)   width of matrix
# Returns:
#   None

argmax
a0 (int*) pointer to vector
a1 (int)  # of elements in the vector
return a0 (int)  is the first index of the largest element


*/