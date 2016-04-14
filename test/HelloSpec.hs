module HelloSpec where

import Test.Hspec
import Hello (hello)

spec :: Spec
spec = do
  describe "Hello" $ do
    it "should say hello to you!" $ do
      hello "Sam" `shouldBe` "Hello Sam"
