# This toolchain file is included multiple times by CMake and I don't like
# repeated flags. Let's use an include blocker.
if(__CMAKEMBED_AVR_TOOLCHAIN)
  return()
endif()
set(__CMAKEMBED_AVR_TOOLCHAIN 1)

# The toolchains are the entry points to the CMake code. Always incldue the
# common functionality!
include("${CMAKE_CURRENT_LIST_DIR}/../Modules/Common.cmake")

# Set the CMake system name to the processor family. This variable is mandatory
# for cross-compiling builds. See more at:
# - https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/CrossCompiling
# - https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR avr)
set(CMAKE_SYSTEM_VERSION 1)

# Try to find the compilers. We will need their path later.
include(Utils)

find_program_harder(CMAKEMBED_AVR_C_COMPILER "avr-gcc" CMAKEMBED_AVR_SYSROOT)
find_program_harder(CMAKEMBED_AVR_CXX_COMPILER "avr-g++" CMAKEMBED_AVR_SYSROOT)

set(CMAKE_C_COMPILER "${CMAKEMBED_AVR_C_COMPILER}" CACHE FILEPATH "C compiler")
set(CMAKE_CXX_COMPILER "${CMAKEMBED_AVR_CXX_COMPILER}" CACHE FILEPATH "C++ compiler")

# Enable the AVR utility functions
include(AVRCompilerOptions)

# Find the AVR system include path
find_path(AVR_SYSTEM_INCLUDE_DIR
    NAMES
        "avr/builtins.h"           # Random file to locate
    PATHS
        "${CMAKEMBED_AVR_SYSROOT}" # User provided sysroot first
        "/usr/avr"                 # Some Linux distributions (Arch, Fedora...)
        "/usr/lib/avr"             # Other Linux distributions (Debian derivatives)
    PATH_SUFFIXES
        "include"                  # Sane suffix inside the sysroot
        "avr/include"              # Arduino structure
)
if (AVR_SYSTEM_INCLUDE_DIR)
    include_directories(SYSTEM "${AVR_SYSTEM_INCLUDE_DIR}")
endif()

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# Search for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)