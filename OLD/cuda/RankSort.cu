#include <stdio.h>
void random_ints(int* a, int N)
{
   int i;
   for (i = 0; i < N; ++i)
    a[i] = rand();
}
__global__ void rankSort(int * array, int * result, int k) {
	int a = k / gridDim.x; 
	int b = k / blockDim.x; 
	__shared__ int tamBlocks; 
	__shared__ int tamThreads; 
	__shared__ int miNumero; 
	__shared__ int rank; 
	int localRank;
	int comparador;
	int range2 = threadIdx.x * b; 
	if(threadIdx.x == 0) {
		tamBlocks = k - (a * gridDim.x);
		tamThreads = k - (b * blockDim.x);
	}
	int range1 = blockIdx.x * a; 
	for(int i = range1; i < range1 + a; i++) {	
		if(threadIdx.x == 0) {
			miNumero = array[i]; 
			rank = 0; 
		}
		__syncthreads();
		localRank = 0; 
		for(int j = range2; j < range2 + b; j++) {
			comparador = array[j];
			if(comparador < miNumero || (comparador == miNumero && (j < i)))
				localRank += 1; 
		}
		if(threadIdx.x < tamThreads) { 
			comparador = array[(blockDim.x * b) + threadIdx.x];
			if(comparador < miNumero || (comparador == miNumero && (((blockDim.x * b) + threadIdx.x) < i)))
				localRank += 1;
		}
		atomicAdd(&rank, localRank); 
		__syncthreads();
		if(threadIdx.x == 0) {
			result[rank] = miNumero; 
		}
		__syncthreads();
	}
	if(blockIdx.x < tamBlocks) {
		if(threadIdx.x == 0) {
			miNumero = array[gridDim.x * a  + blockIdx.x];
			rank = 0;
		}
		__syncthreads();
		localRank = 0;
		for(int j = range2; j < range2 + b; j++) {
			comparador = array[j];
			if(comparador < miNumero || (comparador == miNumero && (j < (gridDim.x * a + blockIdx.x))))
				localRank += 1; 
		}
		if(threadIdx.x < tamThreads) {
			comparador = array[(blockDim.x * b) + threadIdx.x];
			if(comparador < miNumero || (comparador == miNumero && (((blockDim.x * b) + threadIdx.x) < gridDim.x * a  + blockIdx.x)))
				localRank += 1; 
		}
		atomicAdd(&rank, localRank); 
		__syncthreads();
		if(threadIdx.x == 0) {
			result[rank] = miNumero; 
		}
	}
}int main(void){
    int i;
    int *a,*a_sorted;
    int *d_a,*d_sorted;
    int blocks=128;
    int threads = 1024;
    int n=blocks*threads;
    int size =sizeof(int) * n;
    cudaMalloc((void**) &d_a,size);
    cudaMalloc((void**) &d_sorted,size);
    a = (int*) malloc(size); random_ints(a,n);
    a_sorted = (int*) malloc(size);
    cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);  
    rankSort<<<blocks,threads>>>(d_a,d_sorted,n);  
    cudaMemcpy(a_sorted,d_sorted,size,cudaMemcpyDeviceToHost);
    for(i=0;i<n;i++){
        printf("%d\t",a_sorted[i]);
    }
    return 0;
}