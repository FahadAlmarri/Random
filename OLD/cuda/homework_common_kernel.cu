#include <stdio.h>
#include <cuda.h>
void random_ints(int* a, int N)
{
   int i;
   for (i = 0; i < N; ++i)
    a[i] = rand();
}
__global__ void anyStep(int *in, int *out, int size, int step){
    int temp;
    int idx = threadIdx.x + (blockDim.x * blockIdx.x) ;
    if(idx % 2 == step && idx < size -1){
        if(in[idx]>in[idx+1]){
            temp=in[idx];
            in[idx]=in[idx+1];
            in[idx+1]=temp;
        }
    }f

    __syncthreads();
    if (idx < size)
        out[idx]=in[idx];
}
int main(void){
    int i;
    int *a,*a_sorted;
    int *d_a,*d_sorted;
    int blocks=6;
    int threads = 1024;
    int n=blocks*threads;
    int size =sizeof(int) * n;
    cudaMalloc((void**) &d_a,size);
    cudaMalloc((void**) &d_sorted,size);
    a   = (int*) malloc(size); random_ints(a,n);
    a_sorted = (int*) malloc(size);

    cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);
    for(i=1;i<=n/2;i++){
        anyStep<<<blocks,threads>>>(d_a,d_sorted,n,1);
        
        anyStep<<<blocks,threads>>>(d_sorted,d_a,n,0);
        
    }
    cudaMemcpy(a_sorted,d_a,size,cudaMemcpyDeviceToHost);
    for(i=0;i<n;i++){
        printf("%d\t",a_sorted[i]);
    }
    return 0;
}