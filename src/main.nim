# Copyright 2025 Dean Hall, see LICENSE for details

import armv7m/core
import bsp, timer, reset, hard_fault, debug_rtt

const timerInterval = 3277'u32 # ~100 ms

proc timerCallback() =
  # Toggle the BSP's user LED
  var ledState {.global.} = false
  ledState = not ledState
  setUserLed(ledState)

proc main() =
  debugPrint("Hello from Nim!\n")
  debugPrint("Timer interval: " & $timerInterval)
  initUserLed()
  configureTimer(timerInterval, timerCallback)
  while true:
    WFI()

when isMainModule:
  main()
