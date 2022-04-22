#include <stdio.h>
#include <stdlib.h>

int dot(int *arr0, int *arr1, int len, int s0, int s1);
int *matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1);
int main() {
  int h0=2,w0=3,h1=3,w1=2;
  int *arr0 = (int *)malloc(sizeof(int) * 6);
  int *arr1 = (int *)malloc(sizeof(int) * 6);

  for(int i=0;i<6;i++){
    *(arr0+i)=i+1;
    *(arr1+i)=i+7;
  }

  int* c=matmul(arr0, h0, w0, arr1, h1, w1);
  int* ptrc=c;
  
  printf("\nresult: \n");
  for(int i=0;i<4;i++){
    printf(" %d",*(c+i));
  }

  free(arr0);
  free(arr1);
  free(c);
}

int *matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1) {
  /*
  1 2 3   7  8
  4 5 6   9  10
          11 12
  */

  /*
  int c00 = dot(arr0, arr1    , w0, 1, w1);
  int c01 = dot(arr0, arr1 + 1, w0, 1, w1);

  int c10 = dot(arr0 + w0, arr1    , w0, 1, w1);
  int c11 = dot(arr0 + w0, arr1 + 1, w0, 1, w1);
  */

  int height_of_c = h0;//2
  int *c = (int *)malloc(sizeof(int) * 2 * height_of_c);//c.len=4
  int *ptrc = c;

  //(1,2,3)*(7,9,11) are stored in c00
  //(1,2,3)*(8,10,12) are stored in c01
  for (int i = 0; i < height_of_c; i++) {
    *ptrc = dot(arr0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }

  //(4,5,6)*(7,8,9) are stored in c10
  //(4,5,6)*(8,10,12) are stored in c11
  for (int i = 0; i < height_of_c; i++) {
    *ptrc = dot(arr0 + w0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }

  return c;
}

int dot(int *arr0, int *arr1, int len, int s0, int s1) {
  int result = 0;
  for (int i = 0; i < len; i++) {
    result = result + (*(arr0 + i * s0)) * (*(arr1 + i * s1));
  }
  return result;
}


/*
s0->arr0  s1->h0
s2->w0

s3->arr1  s4->h1
s5->w1

s6->c
*/