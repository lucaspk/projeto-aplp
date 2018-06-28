module Txts (
    welcome,
    songGenre,
    firstWord,
    lastWord,
    wordsNumber,
    ready,
    save
) where

welcome = do
    putStrLn("\t###############################################################")
    putStrLn("\t##                                                           ##")
    putStrLn("\t##   ##   ##    ## #######  ##  ######    ######             ##")
    putStrLn("\t##   ##    ##  ##  ##   ##  ##  ##  ##    ##                 ##")
    putStrLn("\t##   ##     ####   ######   ##  ##        ## ####            ##")
    putStrLn("\t##   ##      ##    ##   ##  ##  ##  ##    ##  ##             ##")
    putStrLn("\t##   ######  ##    ##    ## ##  ######    ###### ENERATOR    ##")
    putStrLn("\t##                                                           ##")
    putStrLn("\t###############################################################")
    putStrLn("\n")
    return()

songGenre = do
    putStrLn("\nWhat music genre do you want? Type 'rap', 'pop' or 'mixed'?")

firstWord = do
    putStrLn("\nWhich word to start your lyrics with?")
    
lastWord = do
    putStrLn("\nWhich word to end your lyrics with?")

wordsNumber = do
    putStrLn("\nHow many words in the lyrics do you want?")
    
ready = do
    putStrLn("\nAlright, here's your lyrics:")

save = do
    putStrLn("\nDo you want to save the lyric? (yes/no)")