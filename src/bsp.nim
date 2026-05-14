# Copyright 2025 Dean Hall, see LICENSE for details
#
# BSP (Board Support Package) for the RAK19007 board (nRF52840)

import nrf52840/p

# P1.04/LED2/RAK19007 Blue
# P1.03/LED1/RAK19007 Green

proc initSysLed*() =
  P1.DIRSET.PIN3(1'u32)

proc initUserLed*() =
  P1.DIRSET.PIN4(1'u32)

proc setSysLed*(on: bool) =
  if on:
    P1.OUTSET.PIN3(1'u32)
  else:
    P1.OUTCLR.PIN3(1'u32)

proc setUserLed*(on: bool) =
  if on:
    P1.OUTSET.PIN4(1'u32)
  else:
    P1.OUTCLR.PIN4(1'u32)
