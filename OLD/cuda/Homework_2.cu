#include <stdio.h>
#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
void random_ints(int* a, int N)
{
   int i;
   for (i = 0; i < N; ++i)
    a[i] = rand();
}
__global__ void loop_inside(int *in, int *out, int size){
    __shared__ bool swapedodd;
    __shared__ bool swapedeven;
    bool odd = true;
    int temp;
    int idx = threadIdx.x ;
    while(true){
        __syncthreads();
        if(odd == true){
            swapedodd = false;
            __syncthreads();
            if(idx % 2 == 1 && idx < size -1){
                if(in[idx]>in[idx+1]){
                    temp=in[idx];
                    in[idx]=in[idx+1];
                    in[idx+1]=temp;
                    swapedodd = true;
                }
            }
        }
        else{
            swapedeven = false;
            __syncthreads();
             if(idx % 2 == 0 && idx < size -1){
                if(in[idx]>in[idx+1]){
                    temp=in[idx];
                    in[idx]=in[idx+1];
                    in[idx+1]=temp;
                    swapedeven = true;
                }
            }
        }
        __syncthreads();
        if (!(swapedeven||swapedodd))
        break;
        odd=!odd;
    }
    __syncthreads();
    
    if (idx < size)
        out[idx]=in[idx];
}

int main(void){
    int i;
    int *a,*a_sorted;
    int *d_a,*d_sorted;
    int blocks=1;
    int threads = 1024;
    int n=blocks*threads;
    int size =sizeof(int) * n;
    cudaMalloc((void**) &d_a,size);
    cudaMalloc((void**) &d_sorted,size);
    a = (int*) malloc(size); random_ints(a,n);
    a_sorted = (int*) malloc(size);
   
    cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);  

    loop_inside<<<blocks,threads>>>(d_a,d_sorted,n);
    
    cudaMemcpy(a_sorted,d_sorted,size,cudaMemcpyDeviceToHost);
    for(i=0;i<n;i++){
        printf("%d\t",a_sorted[i]);
    }
    return 0;
}