module Main (main) where

import qualified Bisection

f :: Bisection.Func
f x = x^2 - 2.0

main :: IO ()
main = do
    let interval = Bisection.Interval 0 3
    putStrLn $ show $ Bisection.bisect 1 100 f interval 0.0000001
