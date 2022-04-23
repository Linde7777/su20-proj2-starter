#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
#
*/
int* read_martix(char* filename, int* nrows, int* ncols);

int main(){
    printf("start ");
    char filename[]="./test.bin";
    int* nrows=(int*)malloc(sizeof(int));
    int* ncols=(int*)malloc(sizeof(int));
    int* matrix=read_martix(filename, nrows, ncols);
    int* ptrm=matrix;
    for(int i=0;i<9;i++){
        printf(" %s",*ptrm);
        ptrm+=1;
    }
}

int* read_martix(char* filename, int* nrows, int* ncols){
    FILE* fp;
    fp=fopen(filename,"r");
    fread(nrows,sizeof(int),1,fp);
    fread(ncols,sizeof(int),1,fp);
    int rows=*nrows;
    int cols=*ncols;
    
    int* matrix=(int*)malloc(sizeof(int)*rows*cols);
    int* ptrm=matrix;

    // remind that to set j=0 after the 
    // outer loop have excuted one time
    for(int i=0;i<rows*cols;i++){
        fread(ptrm,sizeof(int),1,fp);
        ptrm+=1;// ptrm+4 indeedly
    }
    
    return matrix;
}