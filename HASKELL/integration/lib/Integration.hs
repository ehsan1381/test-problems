module Integration
 ( Func
 , Interval(..)
 , integral
 ) where

import Data.List (foldl')

type Func = Double -> Double
data Interval = Interval {lo :: !Double, hi :: !Double}
-- data Point = Point {xCoordinate :: Double, yCoordinate :: Double}

-- subtraction for type Func
subFunc :: Func -> Func -> Func
subFunc f g = \x -> f x - g x

-- return the line passing through
-- the points given slope and height
line :: Double -> Double -> Func
line m y0 = (\x -> m*x + y0)

-- norm2
norm2 :: [Double] -> Double
norm2 xs = sqrt $ foldl' (\acc x -> acc + x*x) 0 xs

-- given two points calculate slope
-- and height, call line function
calcLine :: Func -> Interval -> Func
calcLine f interval = line m y0
    where
        m = (y1 - y0) / (x1 - x0)
        y1 = f x1
        x1 = hi interval
        y0 = f x0
        x0 = lo interval

-- return a list of equidistant points
-- given an interval, and number of points
linspace :: Interval -> Double -> [Double]
linspace interval n = map linFunc [0..(n-1)]
    where
        linFunc = line stepsize x0
        stepsize = (x1 - x0) / (n-1)
        x0 = lo interval
        x1 = hi interval

-- given a difference function check if the
-- norm2 of a list of function values
-- is less than tolerance
inTolerance :: Func -> Double -> Interval -> Bool
inTolerance f tolerance interval
    | norm2diff <= tolerance = True
    | otherwise = False
    where
        norm2diff = norm2 $ map f xvals
-- n parameter of linspace can be varied
-- effects accuracy of the final result and
-- the runtime
        xvals = linspace interval 100

trapezoid :: Func -> Interval -> Double
trapezoid f interval = 0.5 * width * (x0 + x1)
    where
        width = x1 - x0
        x1 = hi interval
        x0 = lo interval


-- recursive function, if inTolerance then return
-- if not inTolerance divide into three sections
-- recurse on the all
integral :: Func -> Interval -> Double -> Double
integral f interval tolerance
    | inTolerance diffFunc tolerance interval = trapezoid f interval
    | otherwise = integral0 + integral1 + integral2
    where
        diffFunc = f `subFunc` (calcLine f interval)
        integral0 = integral f interval0 tolerance
        integral1 = integral f interval1 tolerance
        integral2 = integral f interval2 tolerance
        interval0 = Interval {lo = x0, hi = x1}
        interval1 = Interval {lo = x1, hi = x2}
        interval2 = Interval {lo = x2, hi = x3}
        x0 = lo interval
        x1 = (2 * lo interval + hi interval)/3
        x2 = (lo interval + 2 * hi interval)/3
        x3 = hi interval
