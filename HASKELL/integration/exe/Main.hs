module Main (main) where

import  Integration as Integ

f :: Integ.Func
f x = 1/x

main :: IO ()
main = do
    let interval = Integ.Interval {Integ.lo = 1, Integ.hi = 2}
    putStrLn $ show (Integ.integral f interval 0.1)
