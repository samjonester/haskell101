module Types (
              flipBool
            , incrementByTwo
            , Color(..)
            , MyColor(..)
            , isColor
            , isMyColor
            , Person(..)
            , mkNonEmptyString
            , Range(..)
            , inclusiveRange
            ) where

type MyBool = Bool
type BoolToBool = MyBool -> MyBool

flipBool :: BoolToBool
flipBool = not


incrementByTwo :: (Num a) => [a] -> [a]
incrementByTwo = map (+ 2)


data Color = Red | Blue | Yellow
  deriving (Show, Eq)

isColor :: Color -> Bool
isColor _ = True

newtype MyColor = MyColor Color
  deriving (Show)

isMyColor :: MyColor -> Bool
isMyColor _ = True

data Person = Person { name :: String
                     , age :: Int
                     , favoriteColor :: Color
                     }

instance Show Person where
  show (Person {name = n, age = a, favoriteColor = c}) = n ++ " is " ++ (show a) ++ " years old, and his favorite color is " ++ (show c)

data NonEmptyString = Maybe String

mkNonEmptyString :: String -> Maybe String
mkNonEmptyString str
    | null str   = Nothing
    | otherwise  = Just str

data Range a = Range a a

instance Functor Range where
  fmap f (Range s e) = Range (f s) (f e)

inclusiveRange :: (Num a, Enum a) => Range a -> [a]
inclusiveRange (Range s e) = [s..e]
