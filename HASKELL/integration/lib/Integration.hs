{-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -O2 #-}

module Integration
 ( Func
 , Interval(..)
 , integral
 ) where

type Func = Double -> Double

-- Strict fields: both bounds are always needed downstream,
-- so laziness here only buys thunk buildup across recursive calls.
data Interval = Interval {lo :: !Double, hi :: !Double}
-- data Point = Point {xCoordinate :: Double, yCoordinate :: Double}

-- subtraction for type Func
{-# INLINE subFunc #-}
subFunc :: Func -> Func -> Func
subFunc f g = \x -> f x - g x

-- return the line passing through
-- the points given slope and height
{-# INLINE line #-}
line :: Double -> Double -> Func
line m y0 = (\x -> m*x + y0)

-- given two points calculate slope
-- and height, call line function
{-# INLINE calcLine #-}
calcLine :: Func -> Interval -> Func
calcLine f interval = line m y0
    where
        m = (y1 - y0) / (x1 - x0)
        y1 = f x1
        x1 = hi interval
        y0 = f x0
        x0 = lo interval

-- given a difference function, check whether the
-- norm2 of its values over N equidistant points in the
-- interval is within tolerance. Implemented as a single
-- strict tail-recursive loop instead of building two
-- 100-element lists (linspace, then map f) and folding
-- them lazily -- same math, zero list allocation.
{-# INLINE inTolerance #-}
inTolerance :: Func -> Double -> Interval -> Bool
inTolerance diffFunc tolerance interval = sqrt (go 0 0) <= tolerance
    where
        n :: Int
        n = 100
-- n parameter can be varied; effects accuracy of the
-- final result and the runtime
        x0       = lo interval
        stepsize = (hi interval - x0) / fromIntegral (n - 1)

        go :: Int -> Double -> Double
        go !i !acc
            | i == n    = acc
            | otherwise = go (i + 1) (acc + d * d)
            where
                d = diffFunc (x0 + fromIntegral i * stepsize)

{-# INLINE trapezoid #-}
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
