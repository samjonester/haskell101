# Learn Me A Haskell

I'm reading through [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/chapters), and I'd like to test some of ideas out in code. I'd also like to do haskell katas, so I need an environment to TDD haskell.

##Setup Steps
1. Install [Haskell Platform](https://www.haskell.org/platform/)
2. Init a new project `cabal init`. The important settings I chose are a `library` with the source directory `src`.
3. Init a new sandbox `cabal sandbox init`.
4. Add a test suite to your cabal file
```
test-suite tests
  ghc-options: -Wall
  default-extensions:  OverloadedStrings
  type: exitcode-stdio-1.0
  hs-source-dirs: test
  main-is: Spec.hs
  build-depends:    base,
                    hspec                >= 1.8
  default-language:    Haskell2010
 ```
5. Install your dependencies with the test dependencies `cabal install --enable-tests`
6. Add your test discovery file (notice that it is the main-is line above and under the hs-source-dirs path)
`test/Spec.hs`
```
{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
```
7. Create your first test.
`FirstSpec.hs`
```
module FirstSpec where

import Test.Hspec

spec :: Spec
spec = do
  describe "Happy!" $ do
    it "is true" $ do
      True `shouldBe` True
```
6. Run your tests! `cabal test`

