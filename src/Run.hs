{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Run (run, parseInput, itemFromName, getFormatString) where

import           Data.Maybe (fromJust)
import           Import
import           Item

run :: RIO App ()
run = do
  basket <- liftIO $ getBasket createItems []
  let aggregatedItems = aggregate basket
      total = foldr sumItems 0.0 aggregatedItems
  liftIO $ print total


-- In a real application, this would be from a DB call
-- but this is just a kata, so I'll just generate it statically here
createItems :: [Item]
createItems =
  let cSale = Just (Sale 3 12.00)
  in
    [ Item  "C" 1 13.00 Nothing
    , Item  "B" 1 2.99 Nothing
    , Item  "A" 1 10.00 cSale ]


getFormatString :: String
getFormatString = "Please enter in the format \"<Name> <quantity>\"\n" ++
  "Or just press <ENTER> to total your cart\n\n"


getBasket :: [Item] -> [Item] -> IO ([Item])
getBasket options itemsInCart = do
  putStrLn "Please select from the followng items: "
  putStrLn $ prettyPrintItems createItems
  putStrLn getFormatString
  userInput :: String <- getLine
  let
      numInputWords = length $ words userInput
      parsedItem = parseInput userInput options
      isError = isLeft parsedItem
      nullItem = Item "" 0 0.0 Nothing
  if numInputWords == 0 then
    return itemsInCart
  else
    if isError then do
      let errorMessage :: String = fromLeft "UNKNOWN ERROR" parsedItem
      putStrLn errorMessage
      getBasket options itemsInCart
    else
      getBasket options ((fromRight nullItem parsedItem): itemsInCart )

parseInput :: String -> [Item] -> Either String Item
parseInput input options =
  let
    inputWords = words input
    numInputWords = length inputWords
    selectedName = inputWords !! 0
    selectedQuantity = read (inputWords !! 1)
    correspondingItem = itemFromName selectedName options
    selectedItem = fromJust correspondingItem
  in
    if numInputWords == 2 && isJust correspondingItem then
      Right (Item selectedName selectedQuantity (price selectedItem) (sale selectedItem))
    else
      Left ("ERROR: " ++ getFormatString ++ "\n\n")

itemFromName :: String -> [Item] -> Maybe Item
itemFromName "" _ = Nothing
itemFromName _ [] = Nothing
itemFromName searchStr (x: xs) =
  if name x == searchStr then
    Just x
  else
    itemFromName searchStr xs

