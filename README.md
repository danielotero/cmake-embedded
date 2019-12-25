# cmake-embedded
A set of CMake scripts to improve the development on some embedded platforms.

It is just a personal project to get a decent IDE integration: code completion, live diagnostics, build and upload targets.

## Usage

Usually, you must set the [`CMAKE_TOOLCHAIN_FILE`](https://cmake.org/cmake/help/v3.12/variable/CMAKE_TOOLCHAIN_FILE.html) variable before the `project` command execution.

Check out the [CMake documentation on Toolchain](https://cmake.org/cmake/help/v3.12/manual/cmake-toolchains.7.html) for more information.

The [cmake-embedded-examples repo](https://github.com/danielotero/cmake-embedded-examples) contains some examples.

### AVR GNU Toolchain (avr-gcc)

The toolchain file is at path: [`Toolchains/avr-gcc.cmake`](Toolchains/avr-gcc.cmake)

Relevant CMake variables:

- `CMAKEMBED_AVR_SYSROOT`:
Path to a valid AVR sysroot. It shouldn't be needed if there is a toolchain installed in the system.

The main CMake functions:

- `add_avr_firmware(name [MCU <mcu name>] [PRINT_SIZE])`:
Declare a new AVR firmware.

- `add_avr_upload_target(target [<avrdude options>] [EPPROM])`:
Declare a new target to upload the given target with the specified options.

## Contributing

Feel free to open an issue or a Pull Request to reach out!
