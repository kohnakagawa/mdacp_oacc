# MDACP_OACC (OpenACC implementation of Molecular Dynamics code for Avogadro Challenge Project)

## Summary
MDACP_OACC is a OpenACC implementation of MDACP (Molecular Dynamics code for Avogadro Challenge Project).

- step1 (simple naive implementation)
- step2 (CPU/GPU data transfer optimization)
- step3 (CPU/GPU concurrent execution)

## How to compile

``` sh
$ cd step3 (step2 or step1)
$ mkdir build
$ cd build
$ cmake ../ -DCMAKE_CXX_COMPILER=mpicxx # mpicxx should be pgi c++ compiler
$ make
```

## Requirements
PGI C++ compiler (C++11 features are also required.)
