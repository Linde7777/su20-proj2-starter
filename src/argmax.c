#include <stdio.h>
int argmax(int arr[],int len);

int main(){
    int arr[]={3,-42,432,7,-5,6,5,-144,2};
    int res=argmax(arr,9);
    printf("%d",res);
}

int argmax(int arr[],int len){
    int max=arr[0];
    int index=0;
    for(int i=0;i<len;i++){
        if(arr[i]>max){
            max=arr[i];
            index=i;
        }
    }
    return index;

}
  
/*
s0->arr s1->len
s2->i   s3->max 
s4->arr[i]
3 -42 432 7 -5 6 5 -114 2 
*/