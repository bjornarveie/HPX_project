#include "stencil.hpp"

#include <array>
#include <vector>
#include <iostream>
#include <fstream>
#include <chrono>


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

    boost::program_options::variables_map vm;

    std::size_t Nx = vm["Nx"].as<std::size_t>();
    std::size_t Ny = vm["Ny"].as<std::size_t>();
    std::size_t steps = vm["steps"].as<std::size_t>();


    typedef std::vector<double> data_type;
    typedef row_iterator<std::vector<double>::iterator> iterator;

    std::array<data_type, 2> U;

    U[0] = data_type(Nx * Ny, 0.0);
    U[1] = data_type(Nx * Ny, 0.0);

    init(U, Nx, Ny);

    typedef std::chrono::high_resolution_clock Clock;

    auto t1 = Clock::now();

    iterator curr(Nx, U[0].begin());
    iterator next(Nx, U[1].begin());

    #pragma omp parallel for
    for (std::size_t t = 0; t < steps; ++t)
    {
        // We store the result of our update in the next middle line.
        // We need to skip the first row.
        auto result = next.middle + Nx;

        // Iterate over the interior: skip the first and last column
        for(auto it = curr + 1; it != curr + Ny - 1; ++it)
        {
            result = line_update(*it, *it + Nx, result);
        }

        std::swap(curr, next);
    }

    auto t2 = Clock::now();

    double elapsed = std::chrono::duration_cast<std::chrono::microseconds>(t2 - t1).count();

    double mlups = (((Nx - 2.) * (Ny - 2.) * steps) / 1e6)/ elapsed;

    std::ofstream results_openmp;

    results_openmp.open("results_openmp.txt");
    results_openmp << "MLUPS: " << mlups << "\n";
    results_openmp << "Time: " << elapsed << "\n";
    results_openmp.close();





}