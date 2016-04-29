module TypeSpec (spec) where

import Test.Hspec

import Types (
              flipBool
            , incrementByTwo
            , Color(Blue)
            , MyColor(..)
            , isColor
            , isMyColor
            , Person(..)
            , mkNonEmptyString
            , Range(..)
            , inclusiveRange
            )

spec :: Spec
spec = do
  describe "A type" $ do
    it "should flip a bool" $ do
      flipBool False `shouldBe` True

  describe "A type class" $ do
    it "should increment ints by 2" $ do
      incrementByTwo ([1, 2] :: [Int]) `shouldBe` [3, 4]
    it "should increment floats by 2" $ do
      incrementByTwo ([1.5, 2.7] :: [Float]) `shouldBe` [3.5, 4.7]

  describe "A simple data type" $ do
    it "should be type Blue" $ do
      show Blue `shouldBe` "Blue"
    it "should accept a color" $ do
      isColor Blue `shouldBe` True 
  {- 
   -- Won't compile. Example of what the type system restricts
    it "should not accept a non color" $ do
      isColor True `shouldBe` False 
  -}

  describe "A simple newtype" $ do
    it "should be type MyColor Blue" $ do
      show (MyColor Blue) `shouldBe` "MyColor Blue"

    it "should accept a MyColor" $ do
      isMyColor (MyColor Blue) `shouldBe` True

  {- 
   -- Won't compile. Example of what the type system restricts
    it "should not accept a Color" $ do
      isMyColor Blue `shouldBe` True
  -}

  describe "A record" $ do
    it "should show" $ do
      show (Person {name="Tom", age=21, favoriteColor=Blue}) `shouldBe` "Tom is 21 years old, and his favorite color is Blue"

    it "should give me a value" $ do
      favoriteColor (Person {name="foo", age=42, favoriteColor=Blue}) `shouldBe` Blue

  describe "A non empty string" $ do
    it "should be nothing if empty" $ do
      mkNonEmptyString "" `shouldBe` Nothing
    it "should have a value if not empty" $ do
      mkNonEmptyString "Sam" `shouldBe` Just "Sam"
    
  {- 
   -- Won't compile. Example of what the type system restricts
    it "should not accept a number" $ do
      mkNonEmptyString 42 `shouldBe` Nothing
  -}

  describe "A paramaterized data type" $ do
    it "should make an inclusive range" $ do
      inclusiveRange (Range (10 :: Int) (13 :: Int)) `shouldBe` [10,11,12,13]

    it "should fmap" $ do
      inclusiveRange (fmap (+1) (Range (10 :: Int) (13 :: Int))) `shouldBe` [11,12,13,14]
