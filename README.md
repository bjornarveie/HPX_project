# HPX
### Evaluate Parallelism/Concurrency Concepts for C++ offered by HPX for Scientific Computing


1. Understand concepts in 1D_Stencil example (https://github.com/STEllAR-GROUP/hpx/tree/master/examples/1d_stencil)
2. Run 1D_Stencil example, and benchmark.
3. Understand concepts used in 2D_Stencil example (https://github.com/STEllAR-GROUP/tutorials/tree/master/examples/02_stencil)
4. Run 2D_Stencil example, and benchmark.
5. 2D_Stencil example is not partitioned "wisely" but "for educational purposes" -> think of how to improve this example in that respect
6. Implement and Benchmark improved 2D_Stencil

Keywords:

- Asynchronous Many-Task (AMP)
- co-routines
- futures
- Partitioned Global Address Space (PGAS)
- Parcel
- MPI
- OpenMP
- Task (lightweight) vs. threads
- context switching (Hardware-CS (heavy + full) software-CS (more lightweight))
- closure: what you pass as context to the "lambda"
- "Charm++"
- HPX uses BOOST::?
- SIMD "Vectorization", HPX uses "Vc" library for SIMD
- channel? parcelport? MPI
- HPX: cmake build options (several backends for the same thing)
- intra-node, inter-node, NUMA
- latency hiding, "load balancing" -> partitioning -> futures -> solves this?
- "over-subscription": number of cores/ number of tasks
- "grain-size", "problem-sized", "how much work per item"
