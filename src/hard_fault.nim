import armv7m/core
import bsp

# The fault_Handler overrides the weak symbol in the vector table.
# Any hard fault will trigger this handler, despite no reference
# from the main module.  So we mark it as used to silence a compiler warning.
{.used.}

const
  standardDelay = 1000
  longDelay = 5000

func waitBlocking(ticks: int) =
  var outerTicks = ticks
  while outerTicks > 0:
    dec outerTicks
    var innerTicks {.volatile.} = standardDelay
    while innerTicks > 0:
      dec innerTicks

proc fault_Handler() {.exportc, noconv, noreturn.} =
  ## Blinks the BSP's system LED ISR_NUMBER number of times.
  ## Repeats the count after a noticeable pause.
  # Fault handler exceptions are higher priority than most interrupts
  # which prevents most interrupts from interrupting this handler;
  # so we use blocking waits to flash the LED
  let blinkCount = IPSR.read().EXN_NUMBER.uint32
  initSysLed()
  while true:
    for i in 0'u32 ..< blinkCount:
      setSysLed(true)
      waitBlocking(standardDelay)
      setSysLed(false)
      waitBlocking(standardDelay)
    waitBlocking(longDelay)
