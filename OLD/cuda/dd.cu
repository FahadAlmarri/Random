#include <stdio.h>
#include <cuda.h>
#include <ctype.h>

#include <stdlib.h>
#include <string.h>
__global__ void
rank_sort(int N, int input[], int output[]) {

    int index = blockIdx.x * blockDim.x + threadIdx.x;
    

    if (index < N)
    {
        
         for (int i = 0; i <N ; i++) {

        int k=0;
        for (int j=0;j<N;j++)
        {
            if (input[index]>input[j])
            {
                k++;
            }
            
        }
        
        {
        if(output[k]==input[index]){
             output[k+1]=input[index];
             }
        else{
            
            output[k]=input[index];
        }

            
        }
        
         }  
    }
    

}


int main(void) {
 int * a, * a_sorted;
 int * d_a, * d_sorted;
 int n = 8;
 int size = sizeof(int) * n;
 int blocks = 10;
 int threads = 10;
 cudaMalloc((void ** ) & d_a, size);
 cudaMalloc((void ** ) & d_sorted, size);
 a = (int * ) malloc(size);
 a_sorted = (int * ) malloc(size);
printf("Enter the unsorted numbers:\n");
    for(int i=0; i<n; i++){
        scanf("%d", &a[i]);
    }



 printf(" unsorted numbers: \t");1
 for (int i = 0; i < n; i++) {
 printf("%d\t", a[i]);
 }
 cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
 rank_sort << < blocks, threads >>> (n, d_a,d_sorted);

 
 cudaMemcpy(a_sorted, d_sorted, size, cudaMemcpyDeviceToHost);
 printf(" Sorted numbers :\t");
 for (int i = 0; i < n; i++) {
 printf("%d\t", a_sorted[i]);
 }
 free(a);
 free(a_sorted);
 cudaFree(d_a);
 cudaFree(d_sorted);
 return 0;
}
