# MDACP_OACC

## Summary
MDACP_OACC is a GPGPU implementation of MDACP (Molecular Dynamics code for Avogadro Challenge Project) using OpenACC.

The latest information of original MDACP is available at http://mdacp.sourceforge.net/ .

- step1 (a simple naive implementation)
- step2 (CPU/GPU data transfer optimization)
- step3 (CPU/GPU concurrent execution)
- step4 (use transposed list)
- step5 (flat-MPI implementation)

## How to compile

``` sh
$ source env/sekirei.sh # (or env/reedbush-l.sh)
$ cd step5 # (step4, step3, step2, or step1)
$ mkdir build
$ cd build
$ cmake ../ -DCMAKE_CXX_COMPILER=mpicxx # mpicxx should be pgi c++ compiler
$ make
```

## Requirements
- PGI C++ compiler (C++11 features are also required.)

## Benchmark results
on-going...
