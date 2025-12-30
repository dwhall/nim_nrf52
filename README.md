# Nim on nRF52

A Nim bare metal starting point for Nordic nRF52 devices

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

The `nim load` script assumes the nRF52 device has a UF2-compatible bootloader
installed.  If you connect your nRF52 device to your PC and a mass storage device
appears, you have a compatible bootloader.

## Board Support Package

The `bsp.nim` module contains abstractions for how to manipulate items that
are connected to the nRF52 and are unique to the hardware platform.
For example, the board I'm using is the RAK Wireless RAK19007 and I'm using
two LEDs as indicators.  Your board may be different, so you would need to
figure out how to blink an LED on your platform.
