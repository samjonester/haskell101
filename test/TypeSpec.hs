module TypeSpec (spec) where

import Test.Hspec

import Types (
              flipBool
            , incrementByTwo
            , Color(Blue)
            , MyColor(..)
            , isColor
            , isMyColor
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

  describe "A simply newtype" $ do
    it "should be type MyColor Blue" $ do
      show (MyColor Blue) `shouldBe` "MyColor Blue"

    it "should accept a MyColor" $ do
      isMyColor (MyColor Blue) `shouldBe` True

  {- 
   -- Won't compile. Example of what the type system restricts
    it "should not accept a Color" $ do
      isMyColor Blue `shouldBe` True
  -}
