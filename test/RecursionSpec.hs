module RecursionSpec (spec) where

import Test.Hspec

import Recursion (
                    myMax
                  , myMap
                  )

spec :: Spec
spec = do
  describe "Max" $ do
    it "finds the max of a list of numbers" $ do
      myMax ([1,4,3,6,2]::[Int]) `shouldBe` Just 6

    it "finds the max of a one item list" $ do
      myMax [True] `shouldBe` Just True

    it "doesn't find the max of a no item list" $ do
      myMax ([]::[Bool]) `shouldBe` Nothing

  describe "Map" $ do
    it "maps Int to String" $ do
      myMap show ([1, 2, 3]::[Int]) `shouldBe` ["1", "2", "3"]

    it "maps empty list to empty list" $ do
      myMap show ([]::[Int]) `shouldBe` []
