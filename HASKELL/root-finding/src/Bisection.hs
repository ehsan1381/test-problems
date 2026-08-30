module Bisection
 ( Interval (..)
 , Func
 , bisect
 ) where

data Interval = Interval {lo :: Double, hi :: Double} deriving (Show)
type Func = Double -> Double

intervalWidth :: Interval -> Double
intervalWidth interval = abs $ lo interval - hi interval

midpoint :: Interval -> Double
midpoint interval = (lo interval + hi interval) / 2

-- `narrow` assumes function changes
-- sign in the given interval
narrow :: Func -> Interval -> Interval
narrow f interval
 | signum fa /= signum fmidp = Interval {lo = a, hi = midp}
 | otherwise = Interval {lo = midp, hi = b}
 where
    fa = f a
    fmidp = f midp
    a = lo interval
    b = hi interval
    midp = midpoint interval

-- `bisect` assumes that only one root
-- exists within the given interval
-- also that a or b are not roots
bisect :: Int -> Int -> Func -> Interval -> Double -> Double
bisect iter maxIter f interval tolerance
 | iter == maxIter = midp
 | f midp == 0 = midp
 | intervalWidth interval < tolerance = midp
 | signum (f a) == signum (f b) = error "function does not change sign in this interval"
 | otherwise = bisect (iter+1) maxIter f (narrow f interval) tolerance
 where
    midp = midpoint interval
    a = lo interval
    b = hi interval

