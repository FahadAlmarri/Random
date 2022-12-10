__global__ void count3(int *a,int* result,int *count,int w){
int id=(blockdim.x*blockidx.x+threadIdx)*w
for(int i=id;i<id+w;i++){
    if(a[i]==3){
        result[id]++;
    }
}
count=+result[id];
}
__global__ void count3(int *a,int *count,int w){
int id=(blockdim.x*blockidx.x+threadIdx)*w
for(int i=id;i<id+w;i++){
    if(a[i]==3){
        count++;

    }
}
}

