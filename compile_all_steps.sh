#!/bin/sh

cmake_build () {
    rm -rf build
    mkdir build
    cmake ../ -DCMAKE_CXX_COMPILER=mpicxx -DGPU_ARCH=$1
    make
}

if [ $# -ne 2]; then
    echo "Usage:"
    echo "./compile_all_steps.sh gpu_arch cutoff"
    exit 1
fi

gpu_arch=$1
cutoff=$2

echo "GPU_ARCH is set to ${gpu_arch}"
echo "LJ cutoff is set to ${cutoff}"

root_dir=$(pwd)
for dir in step1 step2 step3 step4 step5
do
    cd $dir
    sed -i -e "s/CUTOFF_LENGTH = [0-9]\+.\?[0-9]*/CUTOFF_LENGTH = ${cutoff}/g" ./include/mdconfig.h
    cmake_build ${gpu_arch}
    cd $root_dir
done
