#include <stdio.h>

int dot(int *arr0, int *arr1, int len, int s0, int s1);

int main() {
    int len=4;
    int s0=sizeof(int);
    int s1=sizeof(int);
    int *arr0=(int*)malloc(s0*len);
    int *arr1=(int*)malloc(s1*len);

    for(int i=0;i<len;i++){
        *(arr0+s0*i)=i;
        *(arr1+s1*i)=i;
    }
    /*
    arr0: 0 1 2 3
    arr1: 0 1 2 3
    0+1+4+9=14
    */

    int result=dot(arr0,arr1,len,s0,s1);
    printf("%d",result);
}

int dot(int *arr0, int *arr1, int len, int s0, int s1) {
    int result=0;
    for(int i=0;i<len;i++){
        result=result+ (*(arr0+i*s0)) * (*(arr1+i*s1));
    }
    return result;
}
/*
s0->arr0    s1->arr1
s2->len     
s3->stride of arr0
s4->stride of arr1

s5->result
s6->i
s7->arr0[i] aka *(s0+s6*s3)
s8->arr1[i] aka *(s1+s6*s4)
*/