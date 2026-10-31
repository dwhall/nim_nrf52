# Copyright 2025 Dean Hall, see LICENSE for details

{.compile: "vector_table.c".}
{.compile: "stubs.c".}
{.compile: "std.c".}

import armv7m/[core, scb]
import debug_rtt

proc NimMain() {.importc: "NimMain".}

type
  ExnHandler = proc() {.noconv.}
  IrqHandler = proc() {.noconv.}
  VectorTable = object
    stackPointer {.align(128).}: uint32
    exnHandler: array[1 .. 15, ExnHandler]
    irqHandler: array[48, IrqHandler]

let # from linker script
  c_etext {.importc: "__etext".}: char
  c_data_start {.importc: "__data_start__".}: char
  c_data_end {.importc: "__data_end__".}: char
  c_bss_start {.importc: "__bss_start__".}: char
  c_bss_end {.importc: "__bss_end__".}: char
  # The nonvol one from vector_table.c
  c_vectorTable {.importc: "c_vectorTable".}: VectorTable

proc copyDataSection() {.inline.} =
  let
    data_start = cast[ptr UncheckedArray[cuint]](addr c_data_start)
    etext = cast[ptr UncheckedArray[cuint]](addr c_etext)
  var i = 0
  while addr(data_start[i]) < addr c_data_end:
    data_start[i] = etext[i]
    inc i

proc zeroBssSection() {.inline.} =
  let bss_start = cast[ptr UncheckedArray[cuint]](addr c_bss_start)
  var i = 0
  while addr(bss_start[i]) < addr c_bss_end:
    bss_start[i] = 0
    inc i

proc Reset_Handler() {.exportc, noconv.} =
  SCB.VTOR.write(cast[uint32](addr c_vectorTable))
  copyDataSection()
  zeroBssSection()
  rttInit()
  NimMain() # this will call the nim module given to the nim compiler

proc default_Handler() {.exportc, noconv.} =
  debugRTTprintf(0, "default_Handler: ISR Number: %d\n", IPSR.read().EXN_NUMBER)
