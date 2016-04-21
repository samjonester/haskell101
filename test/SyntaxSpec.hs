module SyntaxSpec (spec) where

import Test.Hspec

import Syntax (
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
              )

spec :: Spec
spec = do
  describe "Pattern matching" $ do

    it "should match 7" $ do
      lucky 7 `shouldBe` "Lucky You!"

    it "should not match not 7" $ do
      lucky 5 `shouldBe` "Not So Lucky :("

    it "should work when non exhaustive pattern is matched" $ do
      nonExhaustive True `shouldBe` "Found it!"

    {-
     -- Will error at run time when non exhaustive pattern is hit
    it "should not work when non exhaustive pattern is not matched" $ do
      nonExhaustive False`shouldBe` "Nice Try!"
    -}




  describe "finding first two elements with pattern matching" $ do
    it "should give me the first two elements in an array" $ do
      firstAndSecond [0..5] `shouldBe`Just (0,1)

    it "should match guard pattern when array has one element" $ do
      firstAndSecond [0] `shouldBe` Nothing

    it "should match guard pattern when array has no element" $ do
      firstAndSecond [] `shouldBe` Nothing




  describe "finding first two elements with case matching" $ do
    it "should give me the first two elements in an array" $ do
      firstAndSecondCase ([0..5] :: [Int]) `shouldBe`Just (0,1)

    it "should match case pattern when array has one element" $ do
      firstAndSecondCase ([0] :: [Int]) `shouldBe` Nothing

    it "should match case pattern when array has no element" $ do
      firstAndSecondCase ([] :: [Int]) `shouldBe` Nothing





  describe "Guards" $ do
    it "should match first guard" $ do
      evenGuard 0 `shouldBe` "Zero"

    it "should match second guard" $ do
      evenGuard 8 `shouldBe` "Yes"

    it "should fall through to otherwise" $ do
      evenGuard 7 `shouldBe` "No"





  describe "Where" $ do
    it "should give me my initials" $ do
      initials "Sam" "Jones" `shouldBe` "S J"

    it "should list sums" $ do
      calcSums [(1,2), (3,4)] `shouldBe` [3,7]




  describe "Let" $ do
    describe "top level let" $ do
      it "should calculate cylinder surface area" $ do
        cylinderSurface 2 4 `shouldBe` 113.097336

    describe "nested let" $ do
      it "should calculate bmi" $ do
        calcBmis [(85,1.9)] `shouldBe` [23.545708]



  describe "An if" $ do
    it "should be even" $ do
      evenIf 10 `shouldBe` "Yes"

    it "should not be even" $ do
      evenIf 11 `shouldBe` "No"
