# Similar to CMake find_program function but tries to find the program inside
# the value of the given "search_path_var" first. If it's not found there nor
# in the system, report an error and stop the configuration.
function(cmakembed_find_program out_var program_name search_path_var)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        "REQUIRED"          # Options
        ""                  # Single-value options
        ""                  # Multi-value options
        ${ARGN}
    )

    # Search in ${search_path_var} first
    find_program(${out_var}
        NAMES "${program_name}"
        PATHS "${${search_path_var}}"
        PATH_SUFFIXES "bin"
        NO_DEFAULT_PATH
    )

    # If it wasn't found, just check on the system
    if("${${out_var}}" STREQUAL "${out_var}-NOTFOUND")
        find_program(${out_var}
            NAMES ${program_name}
        )
    endif()

    if("${${out_var}}" STREQUAL "${out_var}-NOTFOUND")
        if (ARG_REQUIRED)
            message(FATAL_ERROR
                "The program \"${program_name}\" was required but not found "
                "on your system. You can specify search path with the CMake "
                "variable \"${search_path_var}\"."
            )
        else()
            message(WARNING
                "The program \"${program_name}\" was not found on your "
                "system. Some functionalities may not work correctly. You "
                "can specify search path with the CMake variable "
                "\"${search_path_var}\"."
            )
        endif()
    endif()
endfunction()
