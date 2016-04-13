module WorldExistsSpec where

import Test.Hspec

spec :: Spec
spec = do
  describe "True" $ do
    it "is True" $ do
      True `shouldBe` True

