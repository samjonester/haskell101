module ListComprehensionsSpec (
                              spec) where

import Test.Hspec

import ListComprehensions (
                          basicComprehension
                        , evenPositions
                        , evensIn
                        , evensThroughTen
                        , poorMansIntersect)
                          

spec :: Spec
spec = do
  describe "basic comprehension" $ do
    it "should return 1-10" $ do
      basicComprehension `shouldBe` [1..10]
    it "should return evens in 1-10" $ do
      evensThroughTen `shouldBe` [2,4,6,8,10]

  describe "provided range" $ do
    it "should return evens within range" $ do
      evensIn [2..6] `shouldBe` [2,4,6]

  describe "complex comprehension" $ do
    it "should find the intersection" $ do
      poorMansIntersect [1..10] [5..15] `shouldBe` [5..10]

    it  "should give me positions of even numbers" $ do
      evenPositions [2,3,4,6] `shouldBe` [(2,0), (4,2), (6,3)]
