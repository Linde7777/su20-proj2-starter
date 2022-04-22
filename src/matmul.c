#include <stdio.h>
#include <stdlib.h>

int dot(int *arr0, int *arr1, int len, int s0, int s1);
void matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1,int* c);
int main() {
  int h0=2,w0=3,h1=3,w1=2;
  int *arr0 = (int *)malloc(sizeof(int) * 6);
  int *arr1 = (int *)malloc(sizeof(int) * 6);

  for(int i=0;i<6;i++){
    *(arr0+i)=i+1;
    *(arr1+i)=i+7;
  }

  int height_of_c = h0;//2
  int *c = (int *)malloc(sizeof(int) * 2 * height_of_c);//c.len=4
  matmul(arr0, h0, w0, arr1, h1, w1,c);
  
  printf("\nresult: \n");
  for(int i=0;i<4;i++){
    printf(" %d",*(c+i));
  }

  free(arr0);
  free(arr1);
  free(c);
}

void matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1,int* c) {
  //I have ignore the invalid input check

  /*
  arr0:   arr1:
  1 2 3   7  8
  4 5 6   9  10
          11 12
  */
  int height_of_c = h0;//2
  int *ptrc = c;
  
  //c00 = dot(arr0, arr1    , w0, 1, w1)
  //c01 = dot(arr0, arr1 + 1, w0, 1, w1)
  for (int i = 0; i < height_of_c; i++) {
    *ptrc = dot(arr0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }

  //c10 = dot(arr0 + w0, arr1    , w0, 1, w1)
  //c11 = dot(arr0 + w0, arr1 + 1, w0, 1, w1)
  for (int i = 0; i < height_of_c; i++) {
    *ptrc = dot(arr0 + w0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }
}
/*
s0->arr0  s1->h0  s2->w0
s3->arr1  s4->h1  s5->w1
s6->c     s7->height_of_c
s8->ptrc  s9->i
*/

int dot(int *arr0, int *arr1, int len, int s0, int s1) {
  int result = 0;
  for (int i = 0; i < len; i++) {
    result = result + (*(arr0 + i * s0)) * (*(arr1 + i * s1));
  }
  return result;
}