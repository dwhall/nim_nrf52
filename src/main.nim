# Copyright 2025 Dean Hall, see LICENSE for details

import armv7m/core
import bsp, timer, reset, hard_fault, debug_rtt

const
  timerInterval = 32768'u32 # ~1s
  ledToBlink = Led1Green

proc timerCallback() =
  # Toggle the BSP's blue LED
  var ledState {.global.} = false
  ledState = not ledState
  setLed(ledToBlink, ledState)

proc main() =
  debugPrint("Hello from Nim!\n")
  debugPrint("Timer interval: " & $timerInterval)
  initLed(ledToBlink)
  configureTimer(timerInterval, timerCallback)
  while true:
    WFI()

when isMainModule:
  main()
