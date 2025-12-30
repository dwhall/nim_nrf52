# Copyright 2025 Dean Hall, see LICENSE for details

import cm4f/core
import bsp, timer, reset, hard_fault, debug_rtt

const
  timerInterval = 3277'u32 # ~100 ms

proc timerCallback =
  # Toggle the BSP's user LED
  var ledState {.global.} = false
  ledState = not ledState
  setUserLed(ledState)

proc main() =
  discard debugRTTwriteStr(0, "Hello from Nim!\n")
  debugRTTprintf(0, "Counter: %d\n", 42)
  initUserLed()
  configureTimer(timerInterval, timerCallback)
  while true:
    WFI()

when isMainModule:
  main()
