# Evaluate Parallelism/Concurrency Concepts for C++ offered by HPX for Scientific Computing

## TODO list:

- [ ] Understand concepts in 1D_Stencil example (https://github.com/STEllAR-GROUP/hpx/tree/master/examples/1d_stencil)
- [ ] Run 1D_Stencil example, and benchmark.
- [ ] Understand concepts used in 2D_Stencil example (https://github.com/STEllAR-GROUP/tutorials/tree/master/examples/02_stencil)
- [ ] Run 2D_Stencil example, and benchmark.
- [ ] 2D_Stencil example is not partitioned "wisely" but "for educational purposes" -> think of how to improve this example in that respect
- [ ] Implement and Benchmark improved 2D_Stencil

## Important concepts

The important concepts needed to understand in this project are found in a separate [concepts](docs/concepts.md) file.



## Work log

#### 29.03.19

- Started finding information about and understanding the most important concepts related to HPX and parallelism.

#### 01.04.19
- Tried installing newest (stable) version of Boost (1.67.0), but met some problems. Libraries 'context' and 'thread' were not found by CMake (although they are not noted as necessary for running HPX I got an error when trying to cmake HPX). HWLOC and CMake seems to be correctly installed. Used the Macports alternative in the HPX documentation.

#### 03.04.19
Worked with the Boost problem. Tried different versions of Boost. The problem was resolved installing version 1.62.0 instead. For some reason, CMake was not able to find the two libraries stated in the last post. According to the Boost libraries documentation they should be present also for the 1.67.0 version, but somehow it did not work(maybe they are saved in another location or something).

The CMake ran perfectly. However, when making HPX, a new error occured. I used C++17, and some functions used in HPX are deprecated in C++17. EDIT: Found out that HPX appearently have some kind of fix for this, however, it is not working for me. They are also trying to enforce you to use C++17 if it is available (https://github.com/STEllAR-GROUP/hpx/blob/master/cmake/HPX_DetectCppDialect.cmake), so I do not think this is the problem, but I was able to compile using C++14 by using the command 'set (CMAKE_CXX_STANDARD 14)' in the CMakelists.txt in the HPX folder.

ALSO, I initially set the wrong DYLD_LIBRARY_PATH for Boost. Resolved it by setting it to '$HOME/boost_1_62_0/stage/lib'.

Was finally able to build HPX using C++14 (and run Hello World!), hopefully this will not make any problems in the future.
Also, the 1d_stencil example was run, but I need to look into how it actually is running to maybe simulate for a longer time.

NEXT UP; learn how to make my own projects/cmake etc. 
