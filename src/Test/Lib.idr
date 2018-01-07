module Test.Lib

import Lib

%access export
%default total

test1 : IO ()
test1 = putStrLn helloWorld
