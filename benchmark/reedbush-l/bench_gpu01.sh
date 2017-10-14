#!/bin/sh
#PBS -q l-small
#PBS -l select=1:mpiprocs=1:ompthreads=8
#PBS -W group_list=pi0047
#PBS -l walltime=00:30:00

cd $PBS_O_WORKDIR
. /etc/profile.d/modules.sh
# source ../../env/reedbush-l.sh

mpijob ./mdacp -i input_gpu.cfg -g 1 -p 1
# mpijob ./mdacp input_gpu.cfg 1

