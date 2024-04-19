{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE PatternSynonyms #-}

module Main where

import Data.Bits
import Data.Char (digitToInt)

import System.Environment

-- Cloak with 64 bit integers
-- Newline represents 1 
-- Space represents 0

pattern BitTrue :: Char 
pattern BitTrue = '\n'

pattern BitFalse :: Char 
pattern BitFalse = ' '

chunks :: Int -> [a] -> [[a]]
chunks _ [] = [] 
chunks n xs = first : chunks n rest
    where (first, rest) = splitAt n xs

cloakInt :: Int -> Int -> [Char]
cloakInt 0 _ = []
cloakInt n x  
    | testBit x 0 = BitTrue  : next
    | otherwise   = BitFalse : next 
    where next = cloakInt (n - 1) (x `shiftR` 1)

toBit :: Char -> Char
toBit BitTrue = '1'
toBit _       = '0'

uncloakInt64 :: [Char] -> Int
uncloakInt64 xs = foldl (\acc x -> acc * 2 + digitToInt (toBit x)) 0 (reverse xs)

cloakInt64 :: Int -> [Char]
cloakInt64 = cloakInt 64

cloakString :: String -> String
cloakString = concatMap (cloakInt64 . fromEnum)

uncloakString :: String -> String
uncloakString = map (toEnum . uncloakInt64) . chunks 64

cloakFile :: FilePath -> FilePath -> IO ()
cloakFile input output = do 
    contents <- readFile input
    writeFile output (cloakString contents)

uncloakFile :: FilePath -> FilePath -> IO ()
uncloakFile input output = do 
    contents <- readFile input
    writeFile output (uncloakString contents)

main :: IO ()
main = getArgs >>= \case 
    [input, output]           -> cloakFile input output
    ["reveal", input, output] -> uncloakFile input output
    _ -> putStrLn "Usage: cloak <input> <output> | cloak reveal <input> <output>"
