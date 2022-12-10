#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
__global__ void oddStep(int *in, int *out, int size){
    int temp;
    int idx = threadIdx.x + (blockDim.x *blockIdx.x) ;
    if(idx % 2 == 1 && idx < size -1){
        if(in[idx]>in[idx+1]){
            temp=in[idx];
            in[idx]=in[idx+1];
            in[idx+1]=temp;
        }
    }
    __syncthreads();
    if (idx < size)
        out[idx]=in[idx];
    
    
}
__global__ void evenStep(int *in, int *out, int size){
    int temp;
    int idx = threadIdx.x + (blockDim.x *blockIdx.x); 
    if(idx % 2 == 0 && idx < size -1){
        if(in[idx]>in[idx+1]){
            temp=in[idx];
            in[idx]=in[idx+1];
            in[idx+1]=temp;
        }
    }
    __syncthreads();
    if (idx < size)
        out[idx]=in[idx];
    
    
}
int main(void){
    int i;
    int *a,*a_sorted;
    int *d_a, *d_sorted;
    int blocks=1024;
    int threads = 1024;
    int n=blocks*threads;
    int size =sizeof(int)* n;
    cudaMalloc((void**) &d_a,size);
    cudaMalloc((void**) &d_sorted,size);
    a= (int*) malloc(size);
    a_sorted = (int*) malloc(size);
    printf("Enter the unsorted numbers:/n");
    for(i=0;i<n;i++){
        scanf("%d",&a[i]);
    }
    cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);
    for(i=1;i<=n/2;i++){
        oddStep<<<blocks,threads>>>(d_a,d_sorted,n);
        evenStep<<<blocks,threads>>>(d_sorted,d_a,n);
    }
    cudaMemcpy(a_sorted,d_a,size,cudaMemcpyDeviceToHost);
    for(i=0;i<n;i++){
        printf("%d\t",a_sorted[i]);
    }
    return 0;
}

