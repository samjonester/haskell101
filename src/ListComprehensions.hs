module ListComprehensions (
                          basicComprehension 
                        , evenPositions
                        , evensIn
                        , evensThroughTen
                        , poorMansIntersect) where

import Data.Tuple (
                  swap)

basicComprehension :: [Int]
basicComprehension = [x | x <- [1..10]]

evensThroughTen :: [Int]
evensThroughTen = [x | x <- [1..10], mod x 2 == 0]


rangeWhere :: (Int -> Bool) -> [Int] -> [Int]
rangeWhere predicate range = [x | x <- range, predicate x]

evensIn :: [Int] -> [Int]
evensIn = rangeWhere $ even


poorMansIntersect :: [Int] -> [Int] -> [Int]
poorMansIntersect range1 range2 = [x | x <- range1, y <- range2, x == y]


positions = map swap . zip [0..]

evenPositions :: [Int] -> [(Int, Int)]
evenPositions range = [(x,i) | (x,i) <- positions range, even x]
--evenPositions = (filter $ even.fst) . positions
--evenPositions = filter (even.fst) . positions

