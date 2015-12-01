{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

import Ivory.Language
import qualified Ivory.Compile.C.CmdlineFrontend as C (compile)

ivory_main :: Def ('[] :-> Sint16)
ivory_main = proc "main" $ body $ do
  ret 0

main_ivory_module :: Module
main_ivory_module = package "MainIvory" $ do
  incl ivory_main

main :: IO ()
main = C.compile [ main_ivory_module ] []
