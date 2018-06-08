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

    popLyrics <- readFile "pop.txt"
    rapLyrics <- readFile "rap.txt"

    Txts.ready

    print (take 50 popLyrics)



