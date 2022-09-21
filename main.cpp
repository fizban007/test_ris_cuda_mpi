#include <iostream>
#include <mpi.h>

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);
    MPI_Comm world = MPI_COMM_WORLD;

    int rank;
    MPI_Comm_rank(world, &rank);
    std::cout << "This is rank " << rank << std::endl;

    MPI_Finalize();
    return 0;
}
