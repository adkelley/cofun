{-# LANGUAGE TypeOperators        #-}
{-# LANGUAGE DataKinds        #-}
module AdderService.Adder (
    AdderT
  , AdderF
  , add
  , clear
  , total
  ) where

import           Components.Add.Add        (add)
import           Components.Add.Functors   (AddF)
import           Components.Clear.Clear    (clear)
import           Components.Clear.Functors (ClearF)
import           Components.Total.Functors (TotalF)
import           Components.Total.Total    (total)

import           Util.Coproduct            (Sum)

import           Control.Monad.Trans.Free  (FreeT)

type AdderF = Sum '[AddF, ClearF, TotalF]
type AdderT = FreeT AdderF

