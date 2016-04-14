# Learn Me A Haskell

I'm reading through [Learn You a Haskell for Great Good!](http://learnyouahaskell.com/chapters), and I'd like to test some of ideas out in code. I'd also like to do haskell katas, so I need an environment to TDD haskell. I learn best when I have the quick feedback loop provided by TDDing while doing a fun kata, so I need to learn the tooling!

Unfortunately, the documentation around tooling in haskell isn't as impressive as the posts and videos about haskell's awesome language features like monads, functional composition, currying, lazy evaluation... you get my point. Here are all the things I stumbled on while setting up my first haskell environment with tests.

##Prerequisites
Install the [Haskell Platform](https://www.haskell.org/platform/).

##Create a new haskell project
`cabal init`
This will create a few files in your project. The most important being your `*.cabal` file. Cabal acts as a package manager, build tool, test runner, and publishing tool for your project. Check out https://www.haskell.org/cabal/ and https://www.haskell.org/cabal/users-guide/developing-packages.html#modules-included-in-the-package for a lot more information!

You'll be prompted for information about your project. Here are the important pieces, and what I've found out about them.

`Package name?` - This will be the name of your package. If you're publishing it to [hackage](https://hackage.haskell.org/), this will be its name. We will use this as the name of our local package for testing our source modules, and it'll be a dependency for building our tests.
`Project homepage URL?` - I linked to the github url for my project, letting the readme serve as a homepage.
`Project category` - This is the category in [hackage](https://hackage.haskell.org/packages/) used to help people find your project.
```
What does the package build:
   1) Library
   2) Executable
```
Are you building a library or executable tool? You will need a library which exports your modules for testing, so go ahead and choose `library`. If you decide to wrap your library code in one or more executables, you'll just need to add them to your cabal file later. We'll be creating an example executable later.
`Source directory` - This will be the root directory used to discover any modules that you're exporting. It'll also serve as the root directory for private modules that you are not exporting but using in your local source code. I chose `src` to follow [conventions](https://wiki.haskell.org/Structure_of_a_Haskell_project).

We've created the following files:
```
.
├── Setup.hs
├── haskell101.cabal
└── src
```
- **Setup.hs** - Trivial file used to install dependencies of the cabal environment. You probably won't need to touch it
- **haskell.cabal** - This `*.cabal` file will be named for your project. This contains: 
  - **package definition**
  - **library definition** with source dependencies, source directory, exposed modules, and language extensions.
  - **executables** We'll define one of these later. It will contain dependencies isolated to your executable (including our source library), its own source directory, and a file containing a main method for execution.
  - **test-suite We'll define this later. It will contain dependencies isolated to your test code (including our source library), its own source directory, and the entry point which will be a file to scan for our tests.

##Create a project sandbox
Cabal sandbox provides a way to isolate dependencies that are local to your project. This allows you to have different versions of the same dependency used in different projects.
`cabal sandbox init`

Now that our sandbox is initialized, we can install our dependencies into the sandbox. We'll need to do this whenever we change our cabal file.
`cabal install --only-dependencies`
--only-dependencies is needed to install only into the sandbox that we've intialized.

##Adding a test suite
We'll add a test suite to our cabal file before we start coding. I like to do this to ensure that the plumbing is functioning properly before I add the complexity of my code. Our test will be simple, but prove that we can build and test with cabal.

Add the following block to our `*.cabal` file:
```
test-suite tests
  ghc-options: -Wall
  default-extensions:  OverloadedStrings
  type: exitcode-stdio-1.0
  hs-source-dirs: test
  main-is: Spec.hs
  build-depends:    base
                  , hspec                >= 2.3
  default-language:    Haskell2010
 ```
 The important pieces are:
 - **hs-source-dirs** Just like the library section, we need to define the root location of our test files.
 - **main-is** This will be the file that locates test files to run.
 - **build-depends** We will have a new dependency here on hspec. The latest version at the time of writing is 2.3, so I've locked into that version or newer.
 
Next we'll add our main entry point into our test suite. This will find spec files and run their tests
`test/Spec.hs`
```
{-# OPTIONS_GHC -F -pgmF hspec-discover #-}
```

Now let's add our first test. It will ensure that our world exists and we can start TDDing our own code!
`test/WorldExistsSpec.hs`
```
module WorldExistsSpec where

import Test.Hspec

spec :: Spec
spec = do
  describe "True" $ do
    it "is True" $ do
      True `shouldBe` True
```

Finaly let's make sure that everything works and our world exists.
`cabal install --only-dependencies --enable-tests` - I've added --enable-tests to install test dependencies
`cabal test --show-details=streaming --test-option=--color` - This will build and run our test suite. --show-details=streaming will list the specs as they're executing, and I bet you can guess what --test-option=--color does!

##Write some code and a real test
Now that we're comfortable with our tooling, lets write some trivial code and ensure we can test it. First we'll create the test file. You'll see that we are importing a new module that we haven't defined yet.
`test/HelloSpec.hs`
```
module HelloSpec where

import Test.Hspec
import Hello (hello)

spec :: Spec
spec = do
  describe "Hello" $ do
    it "should say hello to you!" $ do
      hello "Sam" `shouldBe` "Hello Sam"
```
 
If we run this test, ghci will alert us that the module doesn't exist, so let's create it.
`src/Hello.hs`
```
module Hello (hello) where

hello :: String -> String
hello = ("Hello " ++)
```
This function defines a partial application of string concatenation. We will provide the object we're saying hello to as the input to our function.

The last step is to export this new module and make it available in our test suite. We'll do this in our `*.cabal` file.
1. In the library section, expose our module for exporting.
`exposed-modules:    Hello`
2. In the test-suite section, add a dependency on our package. This will be the name at the top of the `*.cabal` file.

 
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

7. Write a real test now!
