module ItemSpec (spec) where

import           Item
import           Test.Hspec

spec :: Spec
spec = let
    s1 = Nothing
    i1 = Item "I1" 1 5.00 s1
    s2 = Just $ Sale 3 3.99
    i2 = Item "I1" 1 5.00 s2
    i3 = Item "I1" 3 5.00 s2
    i4 = Item "I1" 4 5.00 s2
    i5 = Item "I1" 6 5.00 s2
  in do
    describe "sumItem" $ do
      it "basic check" $ sumItem i1 `shouldBe` 5.00
      it "sale quantity not met" $ sumItem i2 `shouldBe` 5.00
      it "sale quantity met" $ sumItem i3 `shouldBe` 3.99
      it "sale quantity exceeded remainder" $ sumItem i4 `shouldBe` 8.99
      it "sale quantity exceeded evenly" $ sumItem i5 `shouldBe` 7.98



