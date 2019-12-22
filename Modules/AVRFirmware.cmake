cmakembed_find_program(CMAKEMBED_AVR_OBJCOPY
    "avr-objcopy"
    CMAKEMBED_AVR_SYS
    REQUIRED
)

cmakembed_find_program(CMAKEMBED_AVR_SIZE
    "avr-size"
    CMAKEMBED_AVR_SYS
)

cmakembed_find_program(CMAKEMBED_AVR_AVRDUDE
    "avrdude"
    CMAKEMBED_AVR_SYS
)

###############################################################################
#                              Private functions                              #
###############################################################################
# Recover the MCU the given target was compiled for
function(_avr_get_target_mcu target result)
    get_target_property(mcu ${target} "CMAKEMBED_AVR_MCU")
    if (mcu)
        set("${result}" ${mcu} PARENT_SCOPE)
        return()
    endif()

    get_property(mcu GLOBAL PROPERTY "CMAKEMBED_AVR_MCU")
    if (mcu)
        set("${result}" ${mcu} PARENT_SCOPE)
        return()
    endif()
endfunction()

# Add new outputs to extract the code and the eeprom segments from the target
# executable. Additionally, the function accepts a PRINT_SIZE flag to print the
# binary size after each compilation.
function(_avr_build_firmware target)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        "PRINT_SIZE"      # Options
        ""                # Single-value options
        ""                # Multi-value options
        ${ARGN}
    )

    set(code_file "${target}.hex")
    set(eeprom_file "${target}.eeprom.hex")

    _avr_get_target_mcu(${target} mcu)
    if (${ARG_PRINT_SIZE} AND CMAKEMBED_AVR_SIZE AND mcu)
        # Print the size for the given MCU after the executable is built
        add_custom_command(TARGET ${target} POST_BUILD
            COMMAND "${CMAKEMBED_AVR_SIZE}"
                --format=avr
                --mcu=${mcu}
                ${target}
            COMMENT "Computing the size of '${target}' for '${mcu}'"
        )
    endif()

    # Extract the EEPROM data from the executable
    add_custom_command(OUTPUT ${code_file}
        COMMAND "${CMAKEMBED_AVR_OBJCOPY}"
            --only-section=.text
            --only-section=.data
            --output-target=ihex
            ${target}
            ${code_file}
        DEPENDS ${target}
        COMMENT "Extracting .text and .data segments of '${target}'"
    )
    # Store the code file as a target property
    set_property(TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_CODE_FILE" "${code_file}"
    )

    # Extract the EEPROM data from the executable
    add_custom_command(OUTPUT ${eeprom_file}
        COMMAND "${CMAKEMBED_AVR_OBJCOPY}"
            --only-section=.eeprom
            --set-section-flags=.eeprom=alloc,load
            --change-section-lma .eeprom=0
            --no-change-warnings
            --output-target=ihex
            ${target}
            ${eeprom_file}
        DEPENDS ${target}
        COMMENT "Extracting .eeprom segment of '${target}'"
    )
    # Store the eeprom file as a target property
    set_property(TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_EEPROM_FILE" "${eeprom_file}"
    )
endfunction()

# Add a new custom target to upload (with avrdude) the given executable with
# the given options (PROGRAMMER, BAUDRATE, PORT and OTHER_ARGS). Also, an
# EEPROM_TARGET option can be suplied to create another custom target to upload
# the target EEPROM data.
function(_avr_add_upload_target target_name target)
    # Parse the implicit CMake arguments
    cmake_parse_arguments(ARG
        ""                                         # Options
        "PROGRAMMER;BAUDRATE;PORT;EEPROM_TARGET"   # Single-value options
        "OTHER_ARGS"                               # Multi-value options
        ${ARGN}
    )

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

    # Recover the code file for the given target
    get_property(code_file
        TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_CODE_FILE"
    )
    if (NOT code_file)
       message(FATAL_ERROR "Can not find the code segment for '${target}'")
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

    # This is the command to upload the code to the MCU
    add_custom_target(${target_name}
        ${CMAKEMBED_AVR_AVRDUDE}
            -U flash:w:"${code_file}":i
            ${AVRDUDE_ARGS}
        DEPENDS ${code_file}
        COMMENT "Uploading '${code_file}' to '${mcu}' flash memory"
        USES_TERMINAL
    )

    # Also try to recovert the EEPROM file
    get_property(eeprom_file
        TARGET ${target}
        PROPERTY "CMAKEMBED_AVR_EEPROM_FILE"
    )

    if (eeprom_file AND ARG_EEPROM_TARGET)
        # This is the command to upload the EEPROM data to the MCU
        add_custom_target(${ARG_EEPROM_TARGET}
            ${CMAKEMBED_AVR_AVRDUDE}
                -U eeprom:w:"${eeprom_file}"
                ${AVRDUDE_ARGS}
            DEPENDS ${eeprom_file}
            COMMENT "Uploading '${eeprom_file}' to '${mcu}' EEPROM"
            USES_TERMINAL
        )
    endif()
endfunction()
