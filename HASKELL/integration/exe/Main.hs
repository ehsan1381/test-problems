module Main (main) where

import  Integration as Integ

f :: Integ.Func
f x = x

main :: IO ()
main = do
    let interval = Integ.Interval {Integ.lo = 0, Integ.hi = 2}
    putStrLn $ show (Integ.integral f interval 0.1)
