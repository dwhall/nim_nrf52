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

## Exception Handlers (a.k.a. ISRs)

As a Cortex-M4 device, the nRF52 has two kinds of exceptions:
core exceptions (1..15) and external interrupts (16..63).
The linker script, `nrf52.ld`, establishes weak aliases from all exceptions
and interrupts to either `default_Handler` or `fault_Handler`.
You may rewrite any of these exception handlers to your preference.
This project defines `Reset_Handler` to perform necessary power-up procedures
and `RTC1_IRQHandler` as an example for how to create an application timer.

To implement a handler in Nim for any exception, all you have to do is
name the procedure the same name as the entry in the vectorTable in
`vector_table.c` AND apply two pragmas as seen in this example:

```nim
proc PWM0_IRQHandler() {.exportc, noconv.} =
  # your code here
```

The handler must take no arguments and return nothing.
