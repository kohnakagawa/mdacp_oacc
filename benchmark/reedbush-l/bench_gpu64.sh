#!/bin/sh
#PBS -q l-large
#PBS -l select=16:mpiprocs=4:ompthreads=8
#PBS -W group_list=pi0047
#PBS -l walltime=00:30:00

cd $PBS_O_WORKDIR
. /etc/profile.d/modules.sh

module load cuda gnu

mpirun -np 64 ./mdacp -i input_gpu.cfg -g 4 -p 1
# mpirun -np 64 ./mdacp input_gpu.cfg 4
