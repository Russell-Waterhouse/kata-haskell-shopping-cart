module RunSpec (spec) where

import           Item
import           Run
import           Test.Hspec


spec:: Spec
spec = do
  describe "parseInput" $ do
    let
        i1 = (Item "A" 1 1.0 Nothing)
        input = [i1]
        expectedOutput = Right i1
        expectedErrorOutput = Left ("ERROR: " ++ getFormatString ++ "\n\n")
    it "Null Input check" $ (parseInput "" input) `shouldBe` expectedErrorOutput
    it "malformed Input check" $ (parseInput "A" input) `shouldBe` expectedErrorOutput
    it "malformed Input check 2" $ (parseInput "A 1 B" input) `shouldBe` expectedErrorOutput
    it "Happy path check" $ (parseInput "A 1" input) `shouldBe` expectedOutput
    it "Happy path check 200 quantity" $ (parseInput "A 200" input) `shouldBe`
      Right (Item "A" 200 1.0 Nothing)
  describe "itemFromName" $ do
    let
        i1 = (Item "A" 1 1.0 Nothing)
        i2 = (Item "B" 1 1.0 Nothing)
        input = [i1]
        input2 = [i2, i1]
    it "No Items" $ (itemFromName "NAME" []) `shouldBe` Nothing
    it "No Name"  $ (itemFromName "" input) `shouldBe` Nothing
    it "No Name AND no items"  $ (itemFromName "" []) `shouldBe` Nothing
    it "Not found" $ (itemFromName "B" input) `shouldBe` Nothing
    it "Found at head" $ (itemFromName "A" input) `shouldBe` Just i1
    it "Found in second place" $ (itemFromName "A" input2) `shouldBe` Just i1

