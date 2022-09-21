#include <iostream>
#include <mpi.h>
#include <cuda_runtime.h>

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);
    MPI_Comm world = MPI_COMM_WORLD;

    int n_devices;
    cudaGetDeviceCount(&n_devices);

    // int rank;


    MPI_Finalize();
    return 0;
}