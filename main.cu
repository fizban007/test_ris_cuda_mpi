#include <iostream>
#include <mpi.h>
#include <cuda_runtime.h>

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);
    MPI_Comm world = MPI_COMM_WORLD;

    int n_devices;
    cudaGetDeviceCount(&n_devices);

    int rank;
    MPI_Comm_rank(world, &rank);
    int dev_id = rank % n_devices;

    std::cout << "Rank " << rank << " is using device "
    << dev_id << std::endl;

    MPI_Finalize();
    return 0;
}