{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

import Ivory.Language
import qualified Ivory.Compile.C.CmdlineFrontend as C (compile)

arduino_header :: String
arduino_header = "Arduino.h"

c_init :: Def ('[] :-> ())
c_init = importProc "init" arduino_header

c_delay :: Def ('[Uint32] :-> ())
c_delay = importProc "delay" arduino_header

ivory_main :: Def ('[] :-> Sint16)
ivory_main = proc "main" $ body $ do
  call_ c_init
  call_ c_delay 500
  ret 0

main_ivory_module :: Module
main_ivory_module = package "MainIvory" $ do
  incl c_init
  incl c_delay
  incl ivory_main

main :: IO ()
main = C.compile [ main_ivory_module ] []
