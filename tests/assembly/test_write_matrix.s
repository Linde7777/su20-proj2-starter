.import ../../src/write_matrix.s
.import ../../src/utils.s

# the following file_path is different from 
# official path, since the venus on my machine 
# can not recognize it.
# I use the absolute path, please modify path if you
# want to run this program on you machine
.data
m0: .word 1, 2, 3, 4, 5, 6, 7, 8, 9 # MAKE CHANGES HERE TO TEST DIFFERENT MATRICES
file_path: .asciiz "/root/su20-proj2-starter/tests/outputs/test_write_matrix/student_write_matrix_outputs.bin"

.text
main:
    # Write the matrix to a file
    la s0,file_path    # s0->filename
    la s1,m0     # s1->matrix
    li s2,3      # s2->pointer to number of rows
    li s3,3      # s3->pointer to number of cols

    #a0->filename
    #a1->matrix in memory
    #a2->number of rows 
    #a3->number of columns 

    mv a0,s0
    mv a1,s1
    mv a2,s2
    mv a3,s3

    jal write_matrix


    # Exit the program
    jal exit
