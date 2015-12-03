{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

import Ivory.Language
import qualified Ivory.Compile.C.CmdlineFrontend as C (compile)

arduino_header :: String
arduino_header = "Arduino.h"

led :: Uint8
led = 13

pinmode_input, pinmode_output, pinmode_input_pullup :: Uint8
pinmode_input        = 0
pinmode_output       = 1
pinmode_input_pullup = 2

low, high :: Uint8
low  = 0
high = 1

blink_delay_ms :: Uint32
blink_delay_ms = 500

c_init :: Def ('[] :-> ())
c_init = importProc "init" arduino_header

c_pinmode :: Def ('[Uint8, Uint8] :-> ())
c_pinmode = importProc "pinMode" arduino_header

c_digitalwrite :: Def ('[Uint8, Uint8] :-> ())
c_digitalwrite = importProc "digitalWrite" arduino_header

c_delay :: Def ('[Uint32] :-> ())
c_delay = importProc "delay" arduino_header

ivory_main :: Def ('[] :-> Sint16)
ivory_main = proc "main" $ body $ do
  call_ c_init
  call_ c_pinmode led pinmode_output
  forever $ do
    call_ c_digitalwrite led high
    call_ c_delay blink_delay_ms
    call_ c_digitalwrite led low
    call_ c_delay blink_delay_ms
  ret 0

main_ivory_module :: Module
main_ivory_module = package "MainIvory" $ do
  incl c_init
  incl c_pinmode
  incl c_digitalwrite
  incl c_delay
  incl ivory_main

main :: IO ()
main = C.compile [ main_ivory_module ] []
