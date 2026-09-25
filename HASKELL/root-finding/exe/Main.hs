module Main (main) where

import qualified Bisection

f :: Bisection.Func
f x = x^2 - 2.0

df :: Bisection.Func
df x = 2*x

main :: IO ()
main = do
    let interval = Bisection.Interval 0 3
    putStrLn $ show $ Bisection.solve 1 100 f df interval 0.0000001
