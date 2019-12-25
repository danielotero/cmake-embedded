# Include the private functions
include(AVRPrivate)

#
# Configure the CMake target to compile for the given AVR MCU
#
function(avr_set_target_compile_options target mcu_name)
    _avr_get_arch_for_mcu(${mcu_name} mcu_definition)
    if ("${mcu_definition}" STREQUAL "")
        message(WARNING "Unrecognized AVR MCU: '${mcu_name}'")
    endif()

    string(TOLOWER "${mcu_name}" mcu_name)
    target_compile_options(${target} PRIVATE "-mmcu=${mcu_name}")
    target_include_directories(${CMAKEMBED_AVR_INCLUDE_DIR})
    set_property(TARGET ${target} PROPERTY "CMAKEMBED_AVR_MCU" "${mcu_name}")
endfunction()

#
# Configure CMake to globally compile for the given AVR MCU
#
function(avr_set_compile_options mcu_name)
    _avr_get_arch_for_mcu(${mcu_name} mcu_definition)
    if ("${mcu_definition}" STREQUAL "")
        message(WARNING "Unrecognized AVR MCU: '${mcu_name}'")
    endif()

    string(TOLOWER "${mcu_name}" mcu_name)
    add_compile_options("-mmcu=${mcu_name}")
    include_directories(${CMAKEMBED_AVR_INCLUDE_DIR})
    set_property(GLOBAL PROPERTY "CMAKEMBED_AVR_MCU" "${mcu_name}")
endfunction()

#
# Add the default "avr-gcc" compile definitions of a given MCU to the desired
# target
#
function(avr_set_target_compile_definitions target mcu)
    _avr_get_gcc_default_definitions("${mcu}" definitions)
    target_compile_definitions(${target} PRIVATE ${definitions})
endfunction()

#
# Add the default "avr-gcc" compile definitions of a given MCU globally
#
function(avr_set_compile_definitions mcu)
    _avr_get_gcc_default_definitions("${mcu}" definitions)
    add_compile_definitions(${definitions})
endfunction()

#
# Configure the given target to build for the given MCU
#
function(avr_configure_target target mcu)
    avr_set_target_compile_options(${target} ${mcu})
    avr_set_target_compile_definitions(${target} ${mcu})
endfunction()

# Configure the build system globally for the give MCU
function(avr_configure mcu)
    avr_set_compile_options(${mcu})
    avr_set_compile_definitions(${mcu})
endfunction()
