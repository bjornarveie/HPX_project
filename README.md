# Evaluate Parallelism/Concurrency Concepts for C++ offered by HPX for Scientific Computing

## TODO list:

- [ ] Understand concepts in 1D_Stencil example (https://github.com/STEllAR-GROUP/hpx/tree/master/examples/1d_stencil)
- [ ] Run 1D_Stencil example, and benchmark.
- [ ] Understand concepts used in 2D_Stencil example (https://github.com/STEllAR-GROUP/tutorials/tree/master/examples/02_stencil)
- [ ] Run 2D_Stencil example, and benchmark.
- [ ] 2D_Stencil example is not partitioned "wisely" but "for educational purposes" -> think of how to improve this example in that respect
- [ ] Implement and Benchmark improved 2D_Stencil

## Important concepts

- Asynchronous Many-Task (AMT)
  - Programming model which sets out to cope with and overcome these challenges:
    - Increases in concurrency
    - Deep memory hierarchies
    - Increased fail-stop errors
    - Performance heterogenety
      - Accelerators
      - Thermal throttling
      - General system noise
      - Responses to transient failures
      
  - Every program has a (DAG) task graph (either explicit or implicit), where the nodes are tasks and the edges are precedence constraints.
  - The DAG runtime can:
    - Detect parallelism
    - Maximize concurrency
    - Pipeline communication
    - Load balance/work-steal
    - Move work to data
    - Do transparent fault-tolerance
  - Task graph encodes provenance (origin) information for applications
  - Logical identifications of tasks and data faciliates data and task
    migration, enabling transparent load-balancing and fault-recovery via
    runtime when nodes degrade or fail.
  - Information found here: https://www.osti.gov/servlets/purl/1261059
    
- co-routines

- Futures (part of C++ library since C++11)
  - An object which can retrieve a value from a provider object or function, and therefore synchronizing this access if in different threads.
  - These objects are only useful if they are valid, that is, they are currently associated with a shared state. 
  - If you call future::get() on a (valid) future, the future blocks the thread until the provider has made the shared-state ready (giving it a value or an exception). In this way, two threads are synchronized.
  
  
- Partitioned Global Address Space (PGAS)
  - HPX uses Active Global Address Space (AGAS).

- AGAS
  - Any executing thread may access any object in the domain of the parallel application if it has the access rights.
  - Does not assume cache coherence. 
  - All global addresses within a Synchronous Domain are assumed to be cache coherent for those processor cores that incorporate transparent cache
  - Differs from PGAS in that the PGAS is passive in terms of address translation.

- Parcel
  - Communicates data, invokes action at a distance, and distributes control flow through the migration of continuities.
  - Bridges the gap of asynchrony between synchronous domains while maintaining symmetry of semantics between local and global execution. 
  - Enable message-driven computation. May be seen as a form of "active messages".
  - Enables work to be moved to data (and vice versa).
  - Can cause actions to be invoked remotely and aynchronously (e.g. creation of threads at different system nodes or synchronous domains).
  
- MPI
  - Standardized and portable message passing standard.
  - Communication protocol for programming parallel computers.
- OpenMP
  - OpenMP is a API that supports multi-platform shared memory multiprocessing programming in C, C++ and Fortran.
  - Provides a portable, scalable model that gives programmers a simple and flexible interface for developing parallel applications. 

- Task (lightweight) vs. threads
  - Threading is a small set of threads each doing a specific task that benefit from running synchronously. 
  - Tasking is more a specific strategy used in software engineering, where you dynamically create "tasks" to be accomplished. A task manager picks up these tasks and assign the tasks to threads that can accomplish them. This makes a program structure , where a program is just a succession of tasks being relayed (Task A finished -> trigger task B, when both task B and task C are done -> trigger task D. This is structured like a DAG as in AMT).
  
  
- Context switching (Hardware-CS (heavy + full) software-CS (more lightweight))
  - A mechanism to store and restore the state of a CPU assigned to a process or task. A context is the contents of the CPU registers and the program counter.
  - Software approach:
    - Save and reload only the state that needs to be changed.
    - Provide a function that saves the current stack pointer and reloads the new stack pointer. When this function is called, the current instruction pointer pointing to the current stack pointer is stored in the old stack and the new instruction pointer pointing to the new stack pointer is popped of the new stack when the function returns.
    - GP registers, flags and data must also be pushed to the old stack and popped of the new one.
  - Hardware approach:
    - Saves almost the whole register state and is therefore much slower.
    - Suspends current process and stores the CPU's state somewhere in memory and retrieves the context of the new process and restores the CPU's registers with the new register values. Then returns to the location indicated by the PC to continue execution.
  - Info: https://shobhitsharda.wordpress.com/2011/05/31/context-switch-software-vs-hardware-approach/
  
- Closure: what you pass as context to the "lambda"
- "Charm++"
- HPX uses BOOST::?
  - Boost provides free peer-reviewed (and well working) portable libraries to C++.
  
  
- SIMD "Vectorization", HPX uses "Vc" library for SIMD
  - SIMD:
    - Single instruction, multiple data. Does the same operation on multiple data points at the same time. 
    - By doing the same operation multiple places, CPUs thus can reduce the necessary HW for instruction decoding and scheduling. 
    - Current C++ compilers can automatically transform scalar codes to SIMD instructions (auto-vectorization), but the compiler cannot vectorize any given code to its most data-parallel variant. 
    - The Vc library provides the missing link. Its types enable explicitly stating data-parallel operations on multiple values.
  - Info: https://github.com/VcDevel/Vc

- Channel? Parcelport? MPI
- HPX: cmake build options (several backends for the same thing)
- Intra-node, inter-node, NUMA


- Latency hiding, "load balancing" -> partitioning -> futures -> solves this?
  - Latency hiding:
    - Improves machine utilization by enabling executions of useful operations while it is waiting for a communication operation of memory operation to complete.
  - Load balancing:
    - Improves the distribution of workloads over multiple processors or other computing resources.
    - Aims to optimize resource use and maximize throughput.
  - Futures and fine-grained parallelism helps to obtain this.
  
  
- "Over-subscription": number of cores/ number of tasks

- "Grain-size", "problem-sized", "how much work per item"
  - Granularity is a measure of the amount of work which is performed by a task.
  - Fine-grained parallelism:
    - Program broken down to a large number of small tasks. These tasks are assigned individually to different processors.
    - Work is evenly distributed among processors, hence, fine-grained parallelism facilitates load balancing.
    - Shared memory architectures has a low communication overhead, which means they are well suited for fine-grained parallelism.
  - Coarse-grained parallelism:
    - Larger tasks.
    - Might lead to load imbalance.
    - Fails to exploit parallelism since a lot of the program is executed sequentially on one processor.

## Work log

#### 29.03.19

- Started finding information about and understanding the most important concepts related to HPX and parallelism.

#### 01.04.19
- Tried installing newest (stable) version of Boost (1.67.0), but met some problems. Libraries 'context' and 'thread' were not found by CMake (although they are not noted as necessary for running HPX I got an error when trying to cmake HPX). HWLOC and CMake seems to be correctly installed. Used the Macports alternative in the HPX documentation.

#### 03.04.19
Worked with the Boost problem. Tried different versions of Boost. The problem was resolved installing version 1.62.0 instead. For some reason, CMake was not able to find the two libraries stated in the last post. According to the Boost libraries documentation they should be present also for the 1.67.0 version, but somehow it did not work(maybe they are saved in another location or something).
