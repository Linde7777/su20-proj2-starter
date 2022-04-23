#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
read_matrix
a0->filename    a1->nrows   a2->ncols
return a0, a0->pointer to matrix

fopen
a1->filename    a2->mode, 0 read, 1 write
return a0->file id

fread
a1->file id     a2->buffer
a3->the number of bytes read from file

fclose
a1->file id
a0->mode, 0 success, -1 fail

s0->filename, s1->nrows, s2->ncols
s3->file id, s4->number of rows
s5->number of cols, s6->matrix
s7->ptrm, s8->i
*/

for(int i=0;i<9;i++){
    fread(file id,ptrm,4)
    ptrm+=1// ptrm+=4
}

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