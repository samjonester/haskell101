module Syntax (
                lucky
              , nonExhaustive
              , evenGuard
              , firstAndSecond
              , firstAndSecondCase
              , initials
              , calcSums
              , cylinderSurface
              , calcBmis
              , evenIf
              ) where

import Text.Printf

lucky :: Int -> String
lucky 7 = "Lucky You!"
lucky _ = "Not So Lucky :("

nonExhaustive :: Bool -> String
nonExhaustive True = "Found it!"

firstAndSecond :: [Int] -> Maybe (Int, Int)
firstAndSecond [] = Nothing
firstAndSecond [_] = Nothing
firstAndSecond (f:s:_) = Just (f,s)

firstAndSecondCase :: [a] -> Maybe (a, a)
firstAndSecondCase vals = case vals of
        []        -> Nothing
        [_]       -> Nothing
        (f:s:_)   -> Just (f,s)

evenGuard :: Int -> String
evenGuard num 
    | num == 0    = "Zero"
    | even num    = "Yes"
    | otherwise   = "No"

initials :: String -> String -> String
initials firstName lastName = showInitials
  where
    showInitials = [firstInitial] ++ delimiter ++ [lastInitial]
    delimiter = " "
    (firstInitial:_) = firstName
    (lastInitial:_) = lastName


calcSums :: [(Int, Int)] -> [Int]
calcSums xs = [ sum a b | (a, b) <- xs]
  where
    sum a b = a + b


calcBmis :: [(Float, Float)] -> [Float]
calcBmis xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]  



cylinderSurface :: Float -> Float -> Float
cylinderSurface r h = 
    let sideArea = 2 * pi * r * h 
        sideAreas = 2 * sideArea
        topArea = pi * r ^2  
    in sideAreas + topArea


evenIf :: Int -> String
evenIf n = 
    if even n
    then "Yes"
    else "No"
