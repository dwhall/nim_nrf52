# Copyright 2025 Dean Hall, see LICENSE for details
#
# BSP (Board Support Package) for the RAK19007 board (nRF52840)

import nrf52840/p

const
  bluePinBit = 1'u32 shl 4 # P1.04/LED2/RAK19007 Blue
  greenPinBit = 1'u32 shl 3 # P1.03/LED1/RAK19007 Green

proc initSysLed* =
  P1.DIRSET = greenPinBit

proc initUserLed* =
  P1.DIRSET = bluePinBit

proc setSysLed*(on: bool) =
  if on:
    P1.OUTSET = greenPinBit
  else:
    P1.OUTCLR = greenPinBit

proc setUserLed*(on: bool) =
  if on:
    P1.OUTSET = bluePinBit
  else:
    P1.OUTCLR = bluePinBit
