module Item (
    Sale(..)
  , Item(..)
  , sumItem
  ) where


data Sale = Sale {
  bundleQuantity :: Int,
  salePrice      :: Float
} deriving (Show)

data Item = Item {
  name     :: String,
  quantity :: Int,
  price    :: Float,
  sale     :: Maybe Sale
} deriving (Show)

sumItem :: Item -> Float
sumItem item = salePriceSum item + nonSalePriceSum item

salePriceSum :: Item -> Float
salePriceSum item =
  case sale item of
    Nothing -> 0
    Just sale1 -> fromIntegral numSaleBundles * salePrice sale1
      where
        numSaleBundles = (quantity item) `div` bundleQuantity sale1

nonSalePriceSum :: Item -> Float
nonSalePriceSum item =
  case sale item of
    Nothing -> (price item) * fromIntegral (quantity item)
    Just sale1 -> fromIntegral numNonSaleUnits * price item
      where
        numNonSaleUnits = (quantity item) `mod` bundleQuantity sale1

