{-# LANGUAGE NoImplicitPrelude, OverloadedStrings, ScopedTypeVariables #-}

module Run (run) where

import           Import
import           Item
import           Prelude (putStrLn)

run :: RIO App ()
run = do
  let l = "Items: "
  logInfo "Displaying Info to User"
  liftIO $ putStrLn l
  liftIO $ putStrLn $ prettyPrintItems createItems

-- In a real application, this would be from a DB call
-- but this is just a kata, so I'll just generate it statically here
createItems :: [Item]
createItems =
  let cSale = Just (Sale 3 12.00)
  in
    [ Item  "C" 1 13.00 Nothing
    , Item  "B" 1 2.99 Nothing
    , Item  "A" 1 10.00 cSale ]
