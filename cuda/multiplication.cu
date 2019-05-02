/*
	Marco Mancha A01206194
	Lab 2 CUDA
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

__global__ void valid_multiplication(int *res, int *mat2, int r2, int c2, int *mat1, int r1, int c1){
	// Obtain row and col of the grid
	int row = threadIdx.y + blockIdx.y * blockDim.y;
	int col = threadIdx.x + blockIdx.x * blockDim.x;

	//Obtain position of actual thread
	int id = row * r1 + col;
	int sum = 0;

	//Check if we are inside the grid
	if (row < r1 && col < c2) {
		//Make the sum of the multiplications of the rows * columns
		for(int i = 0; i < r1; i++) {
			sum = sum + mat1[row * r1 + i] * mat2[i * r1 + col];
		}
		//Assign value to new matrix
	 	res[id] = sum;
	}
}


void print_mat(int *mat, int n, int m){
	for (int i = 0; i < n; i++){
		for (int j = 0; j < m; j++){
			printf("%d\t", mat[i*n+j]);
		}
		printf("\n");
	}
	printf("\n");
}

void fill_mat(int *mat, int n, int m){
	int acum;
	for (int i = 0; i < n; i++){
		acum = 0;
		for (int j = 0; j < m; j++){
			acum++;
			mat[i * n + j] = acum;
		}
	}
}

int main(){
	int *h_matrix3, *h_matrix1, *h_matrix2;
	int *d_matrix3, *d_matrix1, *d_matrix2;
	int r1, c1 = 0, r2 = 1, c2;

	// Read matrix size (I couldn't use scanf)
	int flag;
  while(c1 != r2){
    printf("Size matrix 1 \n");
    scanf("rows: %d%*c", &r1);
    scanf("columns: %d%*c", &c1);

    printf("Size matrix 2 \n");
    scanf("rows: %d%*c", &r2);
    scanf("columns: %d%*c", &c2);
    flag++;
  }

	// Space on host for matrices
	h_matrix3 = (int *)malloc(sizeof(int)*r1*c2);
	h_matrix1 = (int *)malloc(sizeof(int)*r1*c1);
	h_matrix2 = (int *)malloc(sizeof(int)*r2*c2);

	// Fill first 2 matrix
	fill_mat(h_matrix1, r1, c1);
	fill_mat(h_matrix2, r2, c2);

  print_mat(h_matrix1, r1, c1);
	print_mat(h_matrix2, r2, c2);

	// Space on device for 3 matrices
	cudaMalloc((void**)&d_matrix3,sizeof(int)*r1*c2);
	cudaMalloc((void**)&d_matrix1,sizeof(int)*r1*c1);
	cudaMalloc((void**)&d_matrix2,sizeof(int)*r2*c2);

	// Copy values from host to device matrix
	cudaMemcpy(d_matrix1, h_matrix1,sizeof(int)*r1*c1, cudaMemcpyHostToDevice);
	cudaMemcpy(d_matrix2, h_matrix2,sizeof(int)*r2*c2, cudaMemcpyHostToDevice);

	int ThreadsPerBlock = r1;
	int NumBlocks = (ThreadsPerBlock + (r1*c2))/ThreadsPerBlock;

	// Create the grid
	dim3 Blocks(NumBlocks,NumBlocks);
	dim3 Threads(ThreadsPerBlock,ThreadsPerBlock);

	// Call cuda function
	valid_multiplication<<<Blocks, Threads>>>(d_matrix3, d_matrix2, r2, c2, d_matrix1, r1, c1);

	// Copy results
	cudaMemcpy(h_matrix3, d_matrix3,sizeof(int)*r1*c2, cudaMemcpyDeviceToHost);

	// Print and free matrices
	print_mat(h_matrix3, r1, c2);

	free(h_matrix3);
	free(h_matrix2);
	free(h_matrix1);

	cudaFree(d_matrix3);
	cudaFree(d_matrix2);
	cudaFree(d_matrix1);

}
