module AdderService.Adder.Console (
    consoleAdder
  , run
  ) where

import           AdderService.Adder     (AdderT, add, clear, total)
import           AdderService.CoAdder.Trans (mkCoAdder)

import Util.Pairing (pairEffect)

import           Control.Monad          (forever)
import           Control.Monad.IO.Class (MonadIO, liftIO)

consoleAdder' :: MonadIO m => AdderT m ()
consoleAdder' = do
    l <- liftIO getLine
    case words l of
      ["add", x] -> add (read x) >>= \b ->
        output $ "add result: " ++ show b
      ["clear"] -> clear
      ["total"] -> total >>= \t ->
        output $ "total result: " ++ show t
      _ -> output prompt
  where
   output = liftIO . putStrLn
   prompt = unlines [
            "Commands:"
          , "  add [int]"
          , "  clear"
          ,"  total"
          ]

consoleAdder :: MonadIO m => AdderT m ()
consoleAdder = forever consoleAdder'

run :: IO ()
run = pairEffect (\_ r -> r) (return () <$ mkCoAdder 10 0) consoleAdder
