# Evaluate Parallelism/Concurrency Concepts for C++ offered by HPX for Scientific Computing

## TODO list:

### Solved:

- [x] Understand concepts in 1D_Stencil example (https://github.com/STEllAR-GROUP/hpx/tree/master/examples/1d_stencil)
- [x] Run 1D_Stencil example.
- [x] Understand concepts used in 2D_Stencil example (https://github.com/STEllAR-GROUP/tutorials/tree/master/examples/02_stencil)
- [x] 2D_Stencil example is not partitioned "wisely" but "for educational purposes" -> think of how to improve this example in that respect.
- [x] Implement new partition scheme, with multiple rows as a partition at size n.
- [x] Run 2D_Stencil example.
- [x] Try parameters Nx, Ny (1-to-1), threads (1-8), oversubscription, steps. Runtime (1 sec per step). Measure setup time.
- [x] Reference implementation with Open MP (write serial code, then add OPEN MP (pragma omp parallel for)).
- [x] Build release version of both programs.
- [x] Connect to cluster and see if it works.
- [x] Install HPX and hwloc on cluster.

### Unsolved:

- [ ] Benchmark 2D_Stencil example.
- [ ] See if it converges. Loop over and find max distance to one and also normalized (ab value from 1 and add all up, then divide by number of cells).
- [ ] Redo the benchmarking under optimal conditions.
- [ ] Use malloc if it is not to difficult to install.
 

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

#### 07.04.19
Made a new project and was able to compile it. A lot of compile rules to remember, so I just post them here.

cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DCMAKE_PREFIX_PATH=$HPX_ROOT -S ../

This was the cmake line to compile the small Hello World program. Also, I was not able to make a empty main.cpp, so there must be some code there or else I get a linker error.

#### 08.04.19
Worked my way through both 1D_Stencil and 2D_Stencil.

##### 1D_STENCIL

###### Example 5

Things starts to get quite messy in example 5, but here I will try to explain.

- The struct parition server inherits from the component base. This struct has data of type partition data as a private variable. Every member function of this struct that may be invoked remotely must have a "action" attached to it. Here, the function get_data() may be invoked remotely and gets the action "get_data_action" attached to it by calling HPX_DEFINE_COMPONENT_DIRECT_ACTION(partition_server, get_data, get_data_action);.
- Also (outside the struct), some calls needs to be done to expose the partition type remotely. "typedef hpx::components::component<partition_server> partition_server_type;
HPX_REGISTER_COMPONENT(partition_server_type, partition_server);" and "typedef partition_server::get_data_action get_data_action;
HPX_REGISTER_ACTION(get_data_action);" needs to be run to expose the component creation through hpx::new_(), and to expose the member function get_data().
- In the struct "partition", which inherits from the client base, the creation of the partition server structs appear. A new type base_type is made through "typedef hpx::components::client_base<partition, partition_server> base_type;". In this struct, hpx::new_ is used to create a new partition server on a specified locality. Also, the member function get_data() (here, a furture) may get invoked within this struct.
- In the struct "stepper" a lot of the usual stuff goes on. In heat_part something new happens. The function takes in a partition for left, middle and right. It uses dataflow and unwrapping to manage the DAG and unwrap the result. The dataflow uses get_data() to get the data for all three partitions before it passes this info to the unwrapping, and thus, synchronizing, since heat_part_data should not run before it has all three partitions ready. In the computation (in the unwrap) it uses heat_part_data (which uses heat to calculate the heat on every data unit in the given partition_data struct) and get_id() to place the partition data on the same locality as the middle partition, and in the end returns this new partition. 
- An action is also exposed: "HPX_PLAIN_ACTION(stepper::heat_part, heat_part_action);". heat_part is wrapped as an action and is now available to be invoked remotely.
- In the stepper function do_work(), U gets initilized with partitions (with a locality and values). The timesteps gets realized with a dataflow, and it uses heat_part_action() to find the next[i]. In the end the result after nt timesteps is returned.
- This is only running on one locality, since the work is not distributed (only used find_here() to find localities).

###### Example 6
Here, with the function locidx, the work is distributed among all localities when initialzing U, in the line " U[0][i] = partition(localities[locidx(i, np, nl)], nx, double(i));". Now, data needs to be moved to the locality of the middle partition in the "heat_part()" function. A switch is added in the get_data() function to accomplish this. If the data needs to be sent to another locality, only the minimum needed is sent, that is, for the left partition the end element and for the right partition the first element.

###### Example 7
Here, the optimization starts. Since the middle always is contained locally, the heat_part function may be divided in two. In one place (in a dataflow function), all the local work with middle is done, while the remote calls of get_data() is done in another instance of dataflow (calculating the boundary elements when they are available).

###### Example 8
Here, the hpx_main is run on each locality (every locality has an instance of stepper, which now is a component with server and client base, and every locality runs do_work()).


##### 2D_Stencil
To run the example, I needed to change the Cmake minimum required version to 3.3.2 in CMakeLists.txt. I was able to run the 2D_stencil example.

#### 09.04.19
### First progress meeting was done today.

#### 17.04.19
Started doing some research in how to implement the new partition scheme.

#### 08.05.19
Continued research, ready for several days of coding...

#### 11.05.19
After using parts of the last days to examine and verify my thoughts about the potential of an already made partition scheme by HPX, I altered the code a little bit to make the scheme more like the scheme we discussed in the first meeting. 

NB: needed to set the boost_root and boost library path again, and used "cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -S ../" to be able to run the code. 

#### 15.05.19
### Second progress meeting was done today.


#### 19.05.19
Started working with benchmarking on my laptop. The first day or two will consist of research and find the different ways to save the console output in a file and use the best method for me, and also write a script to parse the output data to make it user friendly for analysis in for example Python. I will also need to write the serial code with OpenMP for loop (and read up on OpenMP). The next days, from 21th of May I will start benchmarking and saving the results and hopefully I will meet my goal by the end of the week.

Results: to save the console output: run the code as normal, but add "> outputfile.txt" at the end, however, there is a problem, it overwrites the file every time it runs. There is also a way to save the stencil, but need to find a better way to deal with this as every partition writes a file, and it is better to write it in one file.

#### 21.05.19
Started experimenting with the parameters. Found nice parameters and I am ready to start saving the results. 

#### 23.05.19
Started looking into OpenMP and wrote the serial code. 

#### 24.05.19 - 27.05.19
Continued working and finalized the benchmarking on this computer.


#### 10.06.19
Redid the benchmarking.

#### 13.06.19
Installed HWLOC on the cluster. Was able to run make on cluster for HPX, but the compilation failed. Need to get gcc version >= 4.9 for it to work.

#### 17.06.19
Fixed the make error on HPX. I linked to the wrong folder for the new gcc compiler... Got another make error, but fixed it by using this command in CMakelists.txt:
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBOOST_MATH_DISABLE_FLOAT128"). So I was able to compile HPX.

#### 19.06.19
Made a separate cluster directory and compiled my code inside there. Tomorrow I will start the benchmarking on the cluster.

