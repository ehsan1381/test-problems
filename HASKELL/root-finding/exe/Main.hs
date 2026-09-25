module Main (main) where

import qualified RootFinding

f :: RootFinding.Func
f x = x^2 - 2.0

df :: RootFinding.Func
df x = 2*x

main :: IO ()
main = do
    let interval = RootFinding.Interval 0 3
    putStrLn $ show $ RootFinding.solve 1 f df interval
