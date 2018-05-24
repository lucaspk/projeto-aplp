import System.Environment
import Txts

main :: IO ()
main = do
    Txts.welcome
    Txts.songGenre

    genre <- getLine

    Txts.firstWord

    firstWord <- getLine

    Txts.lastWord

    lastWord <- getLine

    Txts.wordsNumber

    wordsNumber <- getLine

    dictionary <- readFile (selectGenre genre)
    
    putStrLn("\nPronto")



selectGenre "rap" = "rap.txt"
selectGenre "pop" = "pop.txt"

 

{-

    Print on screen

-}


