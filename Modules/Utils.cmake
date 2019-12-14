# Similar to CMake find_program function but tries to find the program inside
# the value of the given "search_path_var" first. If it's not found there nor
# in the system, report an error and stop the configuration.
function(find_program_harder out_var program_name search_path_var)
    # Search in ${search_path_var} first
    find_program(result
        NAMES "${program_name}"
        PATHS "${${search_path_var}}"
        PATH_SUFFIXES "bin"
        NO_DEFAULT_PATH
    )

    # If it wasn't found, just check on the system
    if("${result}" STREQUAL "result-NOTFOUND")
        find_program(result
            NAMES ${program_name}
        )
    endif()

    if("${result}" STREQUAL "result-NOTFOUND")
        message(FATAL_ERROR "The program \"${program_name}\" was not found on "
                            "on your system. You can specify search path with "
                            "the CMake variable \"${search_path_var}\".")
    endif()

    # Store the output variable
    set(${out_var} "${result}" PARENT_SCOPE)
endfunction()
