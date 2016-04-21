module Recursion (
                    myMax
                  , myMap
                  ) where

import Data.Maybe

myMax :: (Ord a) => [a] -> Maybe a
myMax [] = Nothing
myMax [x] = Just x
myMax (x:xs)
    | x > fromJust maxTail = Just x
    | otherwise = maxTail
    where maxTail = myMax xs

myMap :: (a -> b) -> [a] -> [b]
myMap f [] = []
myMap f (x:xs) = f x : myMap f xs
