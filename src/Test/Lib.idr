module Test.Lib

import Lib

%default total

public export
data TestResult = TestSuccess | TestFailure

export
test : IO TestResult
test = case helloWorld == expected of
   True => do
     putStrLn "The string is correct!"
     pure TestSuccess
   False => do
     putStrLn "The string is not correct!"
     putStrLn ("Expected: " ++ expected)
     putStrLn ("Actual  : " ++ helloWorld)
     pure TestFailure
  where
    expected : String
    expected = "Hello from an Idris package!"
