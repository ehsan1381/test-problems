relError :: Double -> Double -> Double
relError a b = abs(a - b) / b

midpoint :: (Double, Double) -> Double 
midpoint (a, b) = (a + b) / 2

rootIn :: (Double -> Double) -> (Double, Double) -> (Double, Double) 
rootIn f (a, b)
 | f(a) * (f (midpoint (a, b))) < 0 = (a, midpoint (a, b)) 
 | otherwise = (midpoint (a, b), b)

bisect :: (Double -> Double) -> (Double, Double) -> Double -> Double 
bisect f (a, b)  eps 
 | (relError a b) < eps  = midpoint (a, b) 
 | otherwise             = bisect f (rootIn f (a, b)) eps

