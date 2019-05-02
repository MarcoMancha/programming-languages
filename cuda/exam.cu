// Marco Mancha A01206194
// template provided for cuda quizz 3.
// remember to write your own comments in the code below.

#include <stdio.h>
#define N 9		//size of original matrix
#define K N/3		//size of compressed matrrix

__global__ void compress(float *mat, int n, float *comp, int k){

  // row and col from grid
  int row = threadIdx.y + blockIdx.y * blockDim.y;
  int col = threadIdx.x + blockIdx.x * blockDim.x;

  if(row < k && col < k){
    //initialize value of comp
    comp[col * k + row] = 0;
    for(int i = 0 ; i < k ; i++){
      for(int j = 0 ; j < k ; j++){
        // Sum of the elements
        comp[col + row * k] += mat[(col + j) + (row + i) * n];
        printf("val %i: %f\n", col * k + row, mat[(col + j) + (row + i) * n]);
      }
    }
    printf("ELEMENTO %i: %f\n", col * k + row, comp[col * k + row]);
    // Average of each section
    comp[col * k + row] = comp[col * k + row] / n;
  }
}

void print_mat(float *mat, int n){
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			printf("%.1f\t", mat[i*n+j]);
		}
		printf("\n");
	}
	printf("\n");
}


void fill_mat(float *mat, int n){
	int c = 0;
	for (int i = 0; i < n; i++){
		for (int j = 0; j < n; j++){
			mat[i*n+j] = c++;
		}
	}
}

int main(){
	float *h_compress, *h_matrix;
	float *d_compress, *d_matrix;

  //Reserve space on host
	h_compress = (float *)malloc(sizeof(float)*K*K);
	h_matrix = (float *)malloc(sizeof(float)*N*N);

	fill_mat(h_matrix, N);

  printf("\n input mat \n");
	print_mat(h_matrix, N);

  // Reserve space in cuda
  cudaMalloc((void**)&d_matrix,sizeof(float)*N*N);
	cudaMalloc((void**)&d_compress,sizeof(float)*K*K);

  // Copy from host to device
	cudaMemcpy(d_matrix, h_matrix,sizeof(float)*N*N, cudaMemcpyHostToDevice);
	cudaMemcpy(d_compress, h_compress,sizeof(float)*K*K, cudaMemcpyHostToDevice);

  int ThreadsPerBlock = 1;	 // choose wisely
  int NumBlocks = K;

  // Define grid
	dim3 Blocks(NumBlocks,NumBlocks);
	dim3 Threads(ThreadsPerBlock,ThreadsPerBlock);

  // Call cuda function
  compress<<<Blocks, Threads>>>(d_matrix, N, d_compress, K);

  // COpy from device to host
  cudaMemcpy(h_compress, d_compress,sizeof(float)*K*K, cudaMemcpyDeviceToHost);

  printf("\n compress mat \n");
	print_mat(h_compress, K);

  // Free elements from host and device
	free(h_matrix);
	free(h_compress);

	cudaFree(d_matrix);
	cudaFree(d_compress);

}
