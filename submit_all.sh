#!/bin/sh

submit_all() {
    root_d=$(pwd)
    for f in $(ls ../../benchmark/$1)
    do
        dir=$(echo $f | sed -e "s/.sh//g" | sed -e "s/bench_//g")
        mkdir $dir
        cd $dir
        cp ../../../$2/build/mdacp .
        cp ../../../benchmark/$1/$f .
        cp ../../../run_cfg/input_gpu.cfg .
        # qsub $f
        cd $root_d
    done
}

if [ $# -ne 2 ]; then
    echo "Usage:"
    echo "./submit_all.sh [sekirei/reedbush-l] project_dir"
    exit 1
fi


mkdir -p ./work/$2
cd work/$2

submit_all $1 $2
echo "done."
