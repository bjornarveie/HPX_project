// Copyright (c) 2016 Thomas Heller
//
// Distributed under the Boost Software License, Version 1.0. (See accompanying
// file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

#include "stencil.hpp"
#include "output.hpp"

#include <hpx/hpx_init.hpp>
#include <hpx/include/compute.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/async.hpp>
#include <hpx/include/components.hpp>
#include <hpx/include/parallel_algorithm.hpp>
#include <hpx/util/high_resolution_timer.hpp>

#include <boost/program_options.hpp>

#include <array>
#include <vector>
#include <iostream>

int hpx_main(boost::program_options::variables_map& vm)
{
    std::size_t Nx = vm["Nx"].as<std::size_t>();
    std::size_t Ny = vm["Ny"].as<std::size_t>();
    std::size_t steps = vm["steps"].as<std::size_t>();

    typedef std::vector<double> data_type;
    typedef row_iterator<std::vector<double>::iterator> iterator;

    std::array<data_type, 2> U;

    U[0] = data_type(Nx * Ny, 0.0);
    U[1] = data_type(Nx * Ny, 0.0);

    init(U, Nx, Ny);

    hpx::util::high_resolution_timer t;

    // Construct our column iterators. We want to begin with the second
    // row to avoid out of bound accesses.
    iterator curr(Nx, U[0].begin());
    iterator next(Nx, U[1].begin());
    
    for (std::size_t t = 0; t < steps; ++t)
    {
        // We store the result of our update in the next middle line.
        // We need to skip the first row.
        auto result = next.middle + Nx;

        // Iterate over the interior: skip the first and last column
        #pragma omp parallel for
        for(auto it = curr + 1; it != curr + Ny - 1; ++it)
        {
            result = line_update(*it, *it + Nx, result);
        }

        
//       	std::cout << "----------------------" << std::endl;     

        std::swap(curr, next);

//      for (std::size_t x = 0; x < Nx; x++)
//		{
//		    for (std::size_t y = 0; y < Ny; y++)
//		    {
//		        std::cout << U[0][y*Nx+x] << " ";
//		    }
//		    std::cout << std::endl;
//		} 
    }
    double elapsed = t.elapsed();

    double mlups = (((Nx - 2.) * (Ny - 2.) * steps) / 1e6)/ elapsed;
    std::ofstream results_openmp;
    results_openmp.open("results_openmp_cluster.txt", std::fstream::app);
    results_openmp << mlups << "\t" << elapsed << std::endl;
    results_openmp.close();

    std::ofstream run_data_openmp;
    run_data_openmp.open("run_data_openmp_cluster.txt", std::fstream::app);
    run_data_openmp << Nx << "\t" << Ny << "\t" << hpx::get_os_thread_count() << "\t" << steps << "\t" << hpx::get_num_localities(hpx::launch::sync)  << std::endl;
    run_data_openmp.close();

    if (vm.count("output"))
        output(vm["output"].as<std::string>(), U[0], Nx, Ny);



    return hpx::finalize();
}

int main(int argc, char* argv[])
{
    using namespace boost::program_options;

    options_description desc_commandline;
    desc_commandline.add_options()
        ("Nx", value<std::size_t>()->default_value(1024),
         "Elements in the x direction")
        ("Ny", value<std::size_t>()->default_value(1024),
         "Elements in the y direction")
        ("steps", value<std::size_t>()->default_value(100),
         "Number of steps to apply the stencil")
        ("output", value<std::string>(),
         "Save output to file")
    ;

    return hpx::init(desc_commandline, argc, argv);
}
