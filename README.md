# Recreating MPI Problem on RIS

This repo is a minimum setup to recreate a problem I recently ran into on the RIS cluster. To build the code, I used the following command to get an interactive prompt on a compute node:
````bash
export LSF_DOCKER_VOLUMES='/scratch1/fs1/cyuran:/scratch1/fs1/cyuran'
bsub -Is -G compute-cyuran -q general-interactive -a 'docker(fizban007/cuda_hpc)' bash
````
where `fizban007/cuda_hpc` is a Docker image I prepared before. Once in the prompt, create the repo and build the code using:
````bash
cd /scratch1/fs1/cyuran/
git clone https://github.com/fizban007/test_ris_cuda_mpi.git
cd test_ris_cuda_mpi
mkdir build && cd build
PATH=$PATH:/opt/cuda/bin CXX=g++-11 cmake ..
make
````
This creates two executables in the `test_ris_cuda_mpi/bin` directory, `test_host` and `test_cuda`. I can get neither of them to work properly. A few variants of launching the executables:

1. Getting an interactive session through `bash` and do `mpirun` there:
````bash
export LSF_DOCKER_NETWORK=host
export LSF_DOCKER_IPC=host
export LSF_DOCKER_VOLUMES='/scratch1/fs1/cyuran:/scratch1/fs1/cyuran'
cd /scratch1/fs1/cyuran/test_ris_cuda_mpi/bin
bsub -Is -G compute-cyuran -q general-interactive -n 4 -a 'docker(fizban007/cuda_hpc)' bash
````
then do `mpirun ./test_host` there gives the error `All nodes which are allocated for this job are already filled.`. One can execute `./test_host` directly but it seems to run on only one process.

2. Running with a submit script. I prepared a submit script in the `bin` directory, included in the repo. After compiling the code as detailed above, I simply submitted the script using
````bash
export LSF_DOCKER_NETWORK=host
export LSF_DOCKER_IPC=host
export LSF_DOCKER_VOLUMES='/scratch1/fs1/cyuran:/scratch1/fs1/cyuran'
cd /scratch1/fs1/cyuran/test_ris_cuda_mpi/bin
bsub < submit.bsub
````
Unfortunately I encountered the same problem, all nodes are already filled. Originally I was only testing `test_cuda` which links to some cuda libraries but it turned out that the host verion suffers from the same problem. Please feel free to check through the source code. I would be very extremely surprised if there is a problem with the code, simple as it is.
