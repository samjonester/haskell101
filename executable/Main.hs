module Main (main) where

import Hello (hello)

main :: IO ()
main = (print . hello) "world"
