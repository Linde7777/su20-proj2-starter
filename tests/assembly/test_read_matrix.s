.import ../../src/read_matrix.s
.import ../../src/utils.s

# the following file_path is different from 
# official path, since the venus on my machine 
# can not recognize it.
# I use the absolute path, please modify path if you
# want to run this program on you machine
.data
file_path: .asciiz "/root/su20-proj2-starter/tests/inputs/test_read_matrix/test_input.bin"

.text
main:
    # Read matrix into memory
    li s1,4     #s1->*nrows
    mv a0,s1
    jal malloc
    mv s1,a0    

    li s2,4     #s2->*ncols
    mv a0,s2
    jal malloc
    mv s2,a0    

    #a->filename
    la s0,file_path
    mv a0,s0
    mv a1,s1
    mv a2,s2
    jal read_matrix
    # now a0->matrix
    mv s3,a0    #s3->matrix


    # Print out elements of matrix
    lw t0,0(s1) #t0->number of rows
    lw t1,0(s2) #t1->number of cols
    mv a0,s3
    mv a1,t0
    mv a2,t1
    jal print_int_array

    # Terminate the program
    jal exit