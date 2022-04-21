#include <stdio.h>
#include <stdlib.h>

int dot(int *arr0, int *arr1, int len, int s0, int s1);

int main() {
  printf("%s\n", "test");
  int s0 = 1;
  int s1 = 1;
  int len = 9;
  int *arr0 = (int *)malloc(sizeof(int) * len);
  int *arr1 = (int *)malloc(sizeof(int) * len);

  /*
  arr0: 1 2 3 4 5 6 7 8 9
  arr1: 1 2 3 4 5 6 7 8 9
  */
  for (int i = 0; i < len; i += 1) {
    *(arr0 + i) = i + 1;
    *(arr1 + i) = i + 1;
  }

  int result1=dot(arr0,arr1,len,s0,s1);
  printf("\nresult1: %d",result1);

  len=3;
  s0=1;
  s1=2;
  int result2=dot(arr0,arr1,len,s0,s1);
  printf("\nresult2: %d",result2);

  free(arr0);
  free(arr1);
}

int dot(int *arr0, int *arr1, int len, int s0, int s1) {
  int result = 0;
  for (int i = 0; i < len; i++) {
    result = result + (*(arr0 + i * s0)) * (*(arr1 + i * s1));
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