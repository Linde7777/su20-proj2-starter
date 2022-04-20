  int max=arr[0];
  for(int i=0;i<len;i++){
     if(arr[i]>max){
            max=arr[i]
       }
   }

   for(int i=0;i<len;i++){
        if(arr[i]==max){
            return i;
       }
   }

s0->arr s1->len
s2->i   t0->the copy of original s0
s3->max s4->arr[i]