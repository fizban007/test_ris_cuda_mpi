cmake_minimum_required(VERSION 3.6)

project(test_ris_mpi)
enable_language(CXX CUDA)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

find_package(MPI REQUIRED)

include_directories(${MPI_INCLUDE_PATH})

add_executable(test_cuda "main.cu")
target_link_libraries(test_cuda ${MPI_LIBRARIES})

add_executable(test_host "main.cpp")
target_link_libraries(test_host ${MPI_LIBRARIES})