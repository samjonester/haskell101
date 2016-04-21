module Types (
              flipBool
            , incrementByTwo
            , Color(..)
            , MyColor(..)
            , isColor
            , isMyColor
            ) where

type MyBool = Bool
type BoolToBool = MyBool -> MyBool

flipBool :: BoolToBool
flipBool = not


incrementByTwo :: (Num a) => [a] -> [a]
incrementByTwo = map (+ 2)


data Color = Red | Blue | Yellow
  deriving (Show)

isColor :: Color -> Bool
isColor _ = True

newtype MyColor = MyColor Color
  deriving (Show)

isMyColor :: MyColor -> Bool
isMyColor _ = True
