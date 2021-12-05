{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Run (run) where

import Import
import Item

run :: RIO App ()
run = 
  let i = createItems
      j = show createItems
      k :: Utf8Builder = "Items: \n"  
  in 
  logInfo k
  


-- In a real application, this would be from a DB call
-- but this is just a kata, so I'll just generate it statically here
createItems :: [Item]
createItems = 
  let cSale = Just (Sale 3 12.00)
  in
    [ Item  "A" 1 13.00 Nothing
    , Item  "B" 1 2.99 Nothing
    , Item  "C" 1 10.00 cSale ]
