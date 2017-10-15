#!/bin/sh
#PBS -q l-small
#PBS -l select=2:mpiprocs=4:ompthreads=8
#PBS -W group_list=pi0047
#PBS -l walltime=00:30:00

cd $PBS_O_WORKDIR
. /etc/profile.d/modules.sh
source ../../../env/reedbush-l.sh

mpirun -np 8 ./mdacp -i input_gpu.cfg -g 4 -p 1
# mpirun -np 8 ./mdacp input_gpu.cfg 4
