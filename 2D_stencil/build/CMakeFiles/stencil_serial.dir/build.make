# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/local/bin/cmake

# The command to remove a file.
RM = /opt/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/bjornarveie/HPX_project/2D_stencil

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/bjornarveie/HPX_project/2D_stencil/build

# Include any dependencies generated for this target.
include CMakeFiles/stencil_serial.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/stencil_serial.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/stencil_serial.dir/flags.make

CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o: CMakeFiles/stencil_serial.dir/flags.make
CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o: ../stencil_serial.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/bjornarveie/HPX_project/2D_stencil/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o -c /Users/bjornarveie/HPX_project/2D_stencil/stencil_serial.cpp

CMakeFiles/stencil_serial.dir/stencil_serial.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/stencil_serial.dir/stencil_serial.cpp.i"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/bjornarveie/HPX_project/2D_stencil/stencil_serial.cpp > CMakeFiles/stencil_serial.dir/stencil_serial.cpp.i

CMakeFiles/stencil_serial.dir/stencil_serial.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/stencil_serial.dir/stencil_serial.cpp.s"
	/usr/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/bjornarveie/HPX_project/2D_stencil/stencil_serial.cpp -o CMakeFiles/stencil_serial.dir/stencil_serial.cpp.s

# Object files for target stencil_serial
stencil_serial_OBJECTS = \
"CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o"

# External object files for target stencil_serial
stencil_serial_EXTERNAL_OBJECTS =

stencil_serial: CMakeFiles/stencil_serial.dir/stencil_serial.cpp.o
stencil_serial: CMakeFiles/stencil_serial.dir/build.make
stencil_serial: /Users/bjornarveie/hpx/lib/libhpx_init.a
stencil_serial: /Users/bjornarveie/hpx/lib/libhpx_wrap.a
stencil_serial: /Users/bjornarveie/hpx/lib/libhpx_init.a
stencil_serial: /Users/bjornarveie/hpx/lib/libhpx.1.3.0.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_context.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_thread.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_chrono.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_filesystem.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_program_options.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_system.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_date_time.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_atomic.dylib
stencil_serial: /usr/lib/libpthread.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_context.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_thread.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_chrono.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_filesystem.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_program_options.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_system.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_date_time.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_atomic.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_regex.dylib
stencil_serial: /opt/local/lib/libhwloc.dylib
stencil_serial: /usr/lib/libpthread.dylib
stencil_serial: /Users/bjornarveie/boost_1_62_0/stage/lib/libboost_regex.dylib
stencil_serial: /opt/local/lib/libhwloc.dylib
stencil_serial: CMakeFiles/stencil_serial.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/bjornarveie/HPX_project/2D_stencil/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable stencil_serial"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/stencil_serial.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/stencil_serial.dir/build: stencil_serial

.PHONY : CMakeFiles/stencil_serial.dir/build

CMakeFiles/stencil_serial.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/stencil_serial.dir/cmake_clean.cmake
.PHONY : CMakeFiles/stencil_serial.dir/clean

CMakeFiles/stencil_serial.dir/depend:
	cd /Users/bjornarveie/HPX_project/2D_stencil/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/bjornarveie/HPX_project/2D_stencil /Users/bjornarveie/HPX_project/2D_stencil /Users/bjornarveie/HPX_project/2D_stencil/build /Users/bjornarveie/HPX_project/2D_stencil/build /Users/bjornarveie/HPX_project/2D_stencil/build/CMakeFiles/stencil_serial.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/stencil_serial.dir/depend

