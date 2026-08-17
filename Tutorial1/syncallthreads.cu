#include <stdio.h>
#include <cuda.h>

__device__ int barrier = 0;
__device__ int nthreads = 0;

 __global__ void syncc(int N,int t)
{
	if(threadIdx.x == 0)
	{
		atomicAdd(&barrier,1);
		//printf("A %d,%d\n",blockIdx.x,threadIdx.x);
	}
	__syncthreads();
	while(barrier < N)
	{
		//printf("barrier %d block %d thread %d\n",barrier,blockIdx.x,threadIdx.x);
	}
	printf("Blockidx %d Threadidx %d,hello\n",blockIdx.x,threadIdx.x);
	atomicAdd(&nthreads,1);
	if(nthreads < N*t)
	{
		printf("Waste code thread%d, block %d , threadno %d\n",nthreads,blockIdx.x,threadIdx.x);
	}
}

int main()
{
	int N  =0;
	scanf("%d",&N);
	syncc<<< N,10>>>(N,10);
	cudaDeviceSynchronize();
	return 0;

}
