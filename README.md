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
- `avr_configure_target(target mcu_name)`:
Configure the target to build for the given MCU.

- `avr_configure(mcu_name)`:
Configure the build system globally for the given MCU.

Other functions:

- `avr_set_target_compile_options(target mcu_name)`:
Configure the CMake target to compile for the given AVR MCU. It's called by `avr_configure_target`.

- `avr_set_compile_options(mcu_name)`:
Configure CMake to globally compile for the given AVR MCU. It's called by `avr_configure`.

- `avr_set_target_compile_definitions(target mcu_name)`:
Add the default "avr-gcc" compile definitions of a given MCU to the desired target. It's called by `avr_configure_target`.

- `avr_set_compile_definitions(mcu_name)`:
Add the default "avr-gcc" compile definitions of a given MCU globally. It's called by `avr_configure`.

## Contributing

Feel free to open an issue or a Pull Request to reach out!
