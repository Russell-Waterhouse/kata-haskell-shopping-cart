module Item (
    Sale(..)
  , Item(..)
  , sumItem
  , addItemNameAndPriceToString
  , prettyPrintItems
  , sumItems
  , aggregate
  ) where

data Sale = Sale {
  bundleQuantity :: Int,
  salePrice      :: Float
} deriving (Show, Eq, Ord)

data Item = Item {
  name     :: String,
  quantity :: Int,
  price    :: Float,
  sale     :: Maybe Sale
} deriving (Show, Eq, Ord)

sumItems :: Item -> Float -> Float
sumItems item accumulator = accumulator + sumItem item

sumItem :: Item -> Float
sumItem item = salePriceSum item + nonSalePriceSum item

salePriceSum :: Item -> Float
salePriceSum item =
  case sale item of
    Nothing -> 0
    Just sale1 -> fromIntegral numSaleBundles * salePrice sale1
      where
        numSaleBundles = quantity item `div` bundleQuantity sale1

nonSalePriceSum :: Item -> Float
nonSalePriceSum item =
  case sale item of
    Nothing -> price item * fromIntegral (quantity item)
    Just sale1 -> fromIntegral numNonSaleUnits * price item
      where
        numNonSaleUnits = quantity item `mod` bundleQuantity sale1

prettyPrintItems :: [Item] -> String
prettyPrintItems = foldr addItemNameAndPriceToString ""

addItemNameAndPriceToString :: Item -> String -> String
addItemNameAndPriceToString item s1 = s1 ++
  case sale item of
    Nothing -> name item ++ ": " ++ show (price item) ++ "\n"
    Just sale1 -> name item ++ ": " ++ show (price item) ++ "\n  SALE PRICE: "
      ++ show (bundleQuantity sale1) ++ " FOR " ++ show (salePrice sale1) ++ "\n"

aggregate :: [Item] -> [Item]
aggregate [] = []
aggregate [x] = [x]
aggregate (x: xs) | x `elem` xs =
  let redundantItems = filter (\item -> name x == name item) xs
      otherItems = filter (\item -> name x /= name item) xs
      aggregatedItem = foldr accumulate [x] redundantItems
  in
    aggregatedItem ++ aggregate otherItems
aggregate (x: xs) = x : aggregate xs

accumulate :: Item -> [Item] -> [Item]
accumulate templateItem (nextItem: xs) =
  let (Item n1 q1 p1 s1) = templateItem
      (Item n2 q2 _ _) = nextItem
  in if  n1 == n2 then
    let accumulatedItem = Item n1 (q1 + q2) p1 s1
    in accumulate accumulatedItem xs
  else
    [templateItem]
accumulate templateItem [] = [templateItem]
