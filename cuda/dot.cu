#include <stdlib.h>
#include <stdio.h>
#include <time.h>

cont int N = 32 *1024;
cont Threads_per_block = 256;
cont int Blocks_per_grid = imin(32, (N + Threads_per_block - 1) / Threads_per_block);


__global__ dot(int *d_a, *d_b, *d_c){

  __shared__ float cache[Threads_per_block];
  int tid = threadIdx.x + blockDim.x * blockIdx.x;
  int cacheIndex = threadIdx.x;
  float temp = 0;

  while (tid < N) {
    temp += a[tid] * b[tid];
    tid += blockDim.x * gridDim.x;
  }

  cache[cacheIndex] = temp;

  __syncthreads();

  int i = blockDim.x / 2;
  while (i != 0) {
    if (cacheIndex < 1) {
      cache[cacheIndex] += cache[cacheIndex + 1];
    }

    __syncthreads();
    i /= 2;
  }

  if (cacheIndex == 0) {
    c[blockIdx.x] = cache[0];
  }

}

int main(void){
  float *a, *b, c, *partial_c;
  float *d_a, *d_b, *d_c;

  a = (float *)malloc(sizeof(float)*N);
  b = (float *)malloc(sizeof(float)*N);
  partial_c = (float *)malloc(sizeof(float)*Blocks_per_grid);


  c = 0;
  cudaMalloc((void**)&d_a, sizeof(float)*N);
  cudaMalloc((void**)&d_b, sizeof(float)*N);
  cudaMalloc((void**)&d_c, sizeof(float)*Blocks_per_grid);

  for (int i = 0; i < N; i++) {
    a[i] = i;
    b[i] = i * 2;
  }

  cudaMemcpy(d_a, a, sizeof(float)*N, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, sizeof(float)*N, cudaMemcpyHostToDevice);

  dot<<<Blocks_per_grid, Threads_per_block>>>(d_a, d_b, d_c);

  cudaMemcpy(partial_c, d_c, sizeof(float)*Blocks_per_grid), cudaMemcpyDeviceToHost);

  c = 0;
  for (int i = 0; i < Blocks_per_grid; i++) {
    c += partial_c[i];
    //printf("partial_c %f\n", partial_c[i]);
  }

  #define sum_squares(x) (x*(x+1)*(2*x+1/6))

  printf("Does GPU %.6G = %.6G? \n", C, 2*sum_squares((float)(N -1))); //Check for correctness

  return 0;
}
