module Test.Main

import Test.Lib
import System

%default total

export
test : IO ()
test = do
  result <- test
  case result of
    TestSuccess => exitSuccess
    TestFailure => exitFailure
