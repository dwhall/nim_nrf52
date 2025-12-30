# Nim on nRF52

Bare metal Nim on a Nordic nRF52 microcontroller

## Requirements

* git 2.51 or later
* [Nim 2.2.0](https://nim-lang.org/install.html) or later
* an `arm-none-eabi-gcc` toolchain such as [ARM GNU Toolchain Version 14.3.Rel1](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
* Python3: to convert .bin to .uf2

## Building

_BE SURE TO INIT AND UPDATE SUBMODULES_

`git submodule update --init --recursive`

* Build: `nim build`
* Load: `nim load`
