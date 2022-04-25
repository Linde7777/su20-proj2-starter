/*
write_matrix
s0->filename
s1->matrix in memory
s2->number of rows 
s3->number of columns 
s4->file id     
s6->size of matrix

fopen
a1->filename    a2->mode, 0 read, 1 write
return a0->file id, a0==-1 -> fail

fwrite
a1->file id     a2->buffer
a3->the number of elements to write out of the buffer
a4->size of each buffer element in bytes
return error if a0!=a3


fclose
a1->file id
a0->mode, 0 success, -1 fail


*/

