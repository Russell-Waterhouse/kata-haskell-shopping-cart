{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Run (run) where

import Import
import Item

run :: RIO App ()
run = 
  let i = createItems
  in 
  logInfo "Items: \n" 
-- ++ (show createItems)

-- In a real application, this would be from a DB call
-- but this is just a kata, so I'll just generate it statically here
createItems :: [Item]
createItems = 
  let cSale = Just (Sale 3 12.00)
  in
    [ Item  "A" 1 13.00 Nothing
    , Item  "B" 1 2.99 Nothing
    , Item  "C" 1 10.00 cSale ]
