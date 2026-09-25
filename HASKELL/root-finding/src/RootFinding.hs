module RootFinding
 ( Interval (..)
 , Func
 , solve
 ) where

data Interval = Interval {lo :: Double, hi :: Double} deriving (Show)
type Func = Double -> Double

tolerance = 1e-8
maxIterations = 200

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
bisect :: Int -> Func -> Interval -> Double
bisect iter f interval
 | iter == maxIterations = midp
 | f midp == 0 = midp
 | intervalWidth interval < tolerance = midp
 | signum (f a) == signum (f b) = error "function does not change sign in this interval"
 | otherwise = bisect (iter+1) f (narrow f interval)
 where
    midp = midpoint interval
    a = lo interval
    b = hi interval

newton :: Int -> Func -> Func -> Double -> Double
newton iter f df rootApprox
 | iter >= maxIterations = root
 | rootError <= tolerance = root
 | otherwise = newton (iter+1) f df root
 where
    root = rootApprox - fRootApprox / df(rootApprox)
    fRootApprox = f(rootApprox)
    rootError = abs ( f rootApprox )


solve :: Int -> Func -> Func -> Interval -> Double
solve iter f df interval
 | bisectError < tolerance = bisectApprox
 | otherwise =  newton 1 f df bisectApprox
 where
    bisectApprox = bisect iter f interval
    bisectError = abs ( f bisectApprox )
