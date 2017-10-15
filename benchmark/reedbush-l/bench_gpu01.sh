#!/bin/sh
#PBS -q l-small
#PBS -l select=1:mpiprocs=1:ompthreads=8
#PBS -W group_list=pi0047
#PBS -l walltime=00:30:00

cd $PBS_O_WORKDIR
. /etc/profile.d/modules.sh

module load cuda gnu

mpirun -np 1 ./mdacp -i input_gpu.cfg -g 1 -p 1
# mpirun -np 1 ./mdacp input_gpu.cfg 1

