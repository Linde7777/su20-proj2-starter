#include <stdio.h>
#include <stdlib.h>

int dot(int *arr0, int *arr1, int len, int s0, int s1);
void matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1, int *c);

int main() {
  int h0 = 3, w0 = 3, h1 = 3, w1 = 3;
  int *arr0 = (int *)malloc(sizeof(int) * h0 * w0);
  int *arr1 = (int *)malloc(sizeof(int) * h1 * w1);

  for (int i = 0; i < h0 * w0; i++) {
    *(arr0 + i) = i + 1;
    *(arr1 + i) = i + 1;
  }

  int height_of_c = h0;                                           // 2
  int width_of_c = h0;                                            // 2
  int *c = (int *)malloc(sizeof(int) * width_of_c * height_of_c); // c.length=4
  matmul(arr0, h0, w0, arr1, h1, w1, c);

  printf("\nresult:");
  for (int i = 0; i < h0*h0; i++) {
    if (i % width_of_c == 0) {
      printf("\n");
    }
    printf(" %d", *(c + i));
  }

  free(arr0);
  free(arr1);
  free(c);
}

void matmul(int *arr0, int h0, int w0, int *arr1, int h1, int w1, int *c) {
  // I have ignore the invalid input check
 
  int height_of_c = h0; 
  int width_of_c = w1;  
  int *ptrc = c;

  /*
  the following two for-loop can be simplify 
  into a double rested for-loop

  // c00 = dot(arr0, arr1    , w0, 1, w1)
  // c01 = dot(arr0, arr1 + 1, w0, 1, w1)
  for (int i = 0; i < width_of_c; i++) {
    *ptrc = dot(arr0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }

  // c10 = dot(arr0 + w0, arr1    , w0, 1, w1)
  // c11 = dot(arr0 + w0, arr1 + 1, w0, 1, w1)
  for (int i = 0; i < height_of_c; i++) {
    *ptrc = dot(arr0 + w0, arr1 + i, w0, 1, w1);
    ptrc += 1;
  }
  */

  for (int i = 0; i < height_of_c; i++) {
    for (int j = 0; j < width_of_c; j++) {
    *ptrc = dot(arr0 + w0*i, arr1 + j, w0, 1, w1);
    ptrc += 1;
    }
  }

}
/*
s0->arr0  s1->h0  s2->w0
s3->arr1  s4->h1  s5->w1
s6->c     s7->height_of_c
s8->width_of_c
s9->ptrc  s10->i
s11->j    
*/

/*
a0 (int*) is the pointer to the start of v0
a1 (int*) is the pointer to the start of v1
a2 (int)  is the length of the vectors
a3 (int)  is the stride of v0
a4 (int)  is the stride of v1
*/
int dot(int *arr0, int *arr1, int len, int s0, int s1) {
  int result = 0;
  for (int i = 0; i < len; i++) {
    result = result + (*(arr0 + i * s0)) * (*(arr1 + i * s1));
  }
  return result;
}