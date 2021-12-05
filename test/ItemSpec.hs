module ItemSpec (spec) where

import           Item
import           Test.Hspec

spec :: Spec
spec = let
    s1 = Nothing
    i1 = Item "I1" 1 5.00 s1
    s2 = Just $ Sale 3 3.99
    i2 = Item "I2" 1 5.00 s2
    i3 = Item "I3" 3 5.00 s2
    i4 = Item "I4" 4 5.00 s2
    i5 = Item "I5" 6 5.00 s2
  in do
    describe "sumItem" $ do
      it "basic check" $ sumItem i1 `shouldBe` 5.00
      it "sale quantity not met" $ sumItem i2 `shouldBe` 5.00
      it "sale quantity met" $ sumItem i3 `shouldBe` 3.99
      it "sale quantity exceeded remainder" $ sumItem i4 `shouldBe` 8.99
      it "sale quantity exceeded evenly" $ sumItem i5 `shouldBe` 7.98
    describe "addItemNameAndPriceToString" $ do 
      it "basic check" $ addItemNameAndPriceToString i1 "" `shouldBe` "I1: 5.0\n"
      it "sale check" $ addItemNameAndPriceToString i2 "" `shouldBe` 
        "I2: 5.0\n  SALE PRICE: 3 FOR 3.99\n"
    describe "prettyPrintItems" $ do 
      it "basic check" $ prettyPrintItems [i1] `shouldBe` "I1: 5.0\n"
      it "basic check" $ prettyPrintItems [i1, i1, i1] `shouldBe` "I1: 5.0\nI1: 5.0\nI1: 5.0\n"
      it "basic check" $ prettyPrintItems [i1, i2, i3] `shouldBe` 
        "I3: 5.0\n  SALE PRICE: 3 FOR 3.99\nI2: 5.0\n  SALE PRICE: 3 FOR 3.99\nI1: 5.0\n"


