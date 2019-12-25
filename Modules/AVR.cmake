# Include the private functions
include(AVRPrivate)

#
# Add a new AVR firmware for the given MCU. This creates a new CMake executable
# with the same name and some other targets needed for building the firmware.
# The PRINT_SIZE option will print the avr-size output.
#
function(add_avr_firmware name)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        "PRINT_SIZE"                               # Options
        "MCU"                                      # Single-value options
        ""                                         # Multi-value options
        ${ARGN}
    )

    add_executable(${name} ${ARG_UNPARSED_ARGUMENTS})

    if (ARG_MCU)
        _avr_set_target_compile_options(${name} ${ARG_MCU})
        _avr_set_target_compile_definitions(${name} ${ARG_MCU})
    endif()

    _avr_build_firmware(${name} ${ARG_PRINT_SIZE})
endfunction()

#
# Add a new custom target to upload (with avrdude) the given executable with
# the given options (PROGRAMMER, BAUDRATE, PORT and OTHER_ARGS). By default
# uploads the program flash memory. Use EEPROM to upload the EEPROM data.
#
function(add_avr_upload_target target_name)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        "EEPROM"                                   # Options
        "PROGRAMMER;BAUDRATE;PORT;TARGET"          # Single-value options
        "OTHER_ARGS"                               # Multi-value options
        ${ARGN}
    )

    set(target "${ARG_TARGET}")

    # It only makes sense to continue if we have the upload tool
    if (NOT CMAKEMBED_AVR_AVRDUDE)
        message(WARNING
            "Not upload targets for '${target}' were generated as no avrdude "
            "was found."
        )
        return()
    endif()

    _avr_get_target_mcu(${target} mcu ${AVR_PRINT_SIZE})
    if (NOT mcu)
        message(FATAL_ERROR "Can not find the target MCU for '${target}'")
    endif()

    # Build the avrdude set of arguments from the function inputs
    set(AVRDUDE_ARGS -p ${mcu})
    if (ARG_PROGRAMMER)
        list(APPEND AVRDUDE_ARGS -c ${ARG_PROGRAMMER})
    endif()
    if (ARG_PORT)
        list(APPEND AVRDUDE_ARGS -P ${ARG_PORT})
    endif()
    if (ARG_BAUDRATE)
        list(APPEND AVRDUDE_ARGS -b ${ARG_BAUDRATE})
    endif()
    if (ARG_OTHER_ARGS)
        list(APPEND AVRDUDE_ARGS ${ARG_OTHER_ARGS})
    endif()

    if (ARG_EEPROM)
        # Also try to recovert the EEPROM file
        get_property(eeprom_file
            TARGET ${target}
            PROPERTY "CMAKEMBED_AVR_EEPROM_FILE"
        )
        if (NOT eeprom_file)
            message(FATAL_ERROR
                "Can not find the EEPROM segment for '${target}'"
            )
        endif()

        # This is the command to upload the EEPROM data to the MCU
        add_custom_target(${target_name}
            ${CMAKEMBED_AVR_AVRDUDE}
                -U eeprom:w:"${eeprom_file}":i
                ${AVRDUDE_ARGS}
            DEPENDS ${eeprom_file}
            COMMENT "Uploading '${eeprom_file}' to '${mcu}' EEPROM"
            USES_TERMINAL
        )
    else()
        # Recover the code file for the given target
        get_property(code_file
            TARGET ${target}
            PROPERTY "CMAKEMBED_AVR_CODE_FILE"
        )
        if (NOT code_file)
            message(FATAL_ERROR
                "Can not find the code segment for '${target}'"
            )
        endif()

        # This is the command to upload the code to the MCU
        add_custom_target(${target_name}
            ${CMAKEMBED_AVR_AVRDUDE}
                -U flash:w:"${code_file}":i
                ${AVRDUDE_ARGS}
            DEPENDS ${code_file}
            COMMENT "Uploading '${code_file}' to '${mcu}' flash memory"
            USES_TERMINAL
        )
    endif()
endfunction()