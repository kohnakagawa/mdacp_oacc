#!/bin/sh

cmake_build () {
    if [ ! -d build ]; then
        mkdir build
    fi
    cd build
    cmake ../ -DCMAKE_CXX_COMPILER=mpicxx -DGPU_ARCH=$1
    make
}

gpu_arch=KEPLER # default is kepler
if [ $# -eq 1 ]; then
    gpu_arch=$1
fi
echo "GPU_ARCH is set to ${gpu_arch}"

root_dir=$(pwd)
for dir in $(ls -d step*)
do
    cd $dir
    cmake_build ${gpu_arch}
    cd $root_dir
done
