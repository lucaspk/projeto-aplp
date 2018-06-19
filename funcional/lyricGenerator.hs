import System.Environment
import Txts
import Data.Char
import qualified Data.Map.Strict as Map

main :: IO ()
main = do
    --Txts.welcome
    --Txts.songGenre

    --genre <- getLine

    Txts.firstWord

    firstWord <- getLine

    --Txts.lastWord

    --lastWord <- getLine

    --Txts.wordsNumber

    --wordsNumber <- getLine

    popLyrics <- readFile "pop.txt"
    rapLyrics <- readFile "rap.txt"

    Txts.ready
    --Replace '\n' to ' \n'
    let part1 = replace rapLyrics
    --let linesOfFiles = lines rapLyrics

    --let lowerCaseLines = [(toLowerCase line) | line <- linesOfFiles]

    --Lower case every char
    let part2 = toLowerCase part1

    -- Split by ' '
    let part3 = split (==' ') part2
    
    -- Zip a list into 2 lists
    let part4 = myZip (tail part3) (init part3)
    

toLowerCase :: [Char] -> [Char]
toLowerCase str = [ toLower x | x <- str]

replace :: [Char] -> [Char]
replace [] = []
replace (x:xs) =
    if x == '\n'
      then " \n" ++ replace xs
      else x : replace xs


split :: (Char -> Bool) -> String -> [String]
split p s = case dropWhile p s of
            "" -> []
            s' -> w : split p s''
                where (w, s'') = break p s'


myZip [] [] = []
myZip _ [] = []
myZip [] _ = []
myZip (x:xs) (y:ys) = [(x,y)] ++ myZip xs ys
