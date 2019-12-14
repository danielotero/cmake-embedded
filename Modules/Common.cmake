# This module includes the code that all platforms share

# Currently we have a hard requirement on modern CMake due to the use of:
# - add_compile_definitions (3.12)
cmake_minimum_required(VERSION 3.12)

# Let us set this folder as a place to find modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
