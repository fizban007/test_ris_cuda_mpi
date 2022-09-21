cmake_minimum_required(VERSION 3.6)

project(test_ris_mpi)
enable_language(CXX CUDA)

find_package(MPI REQUIRED)

include_directories(${MPI_INCLUDE_PATH})

add_executable(test "main.cu")
target_link_libraries(test ${MPI_LIBRARIES})
