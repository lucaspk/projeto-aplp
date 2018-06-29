module Txts (
    welcome,
    songGenre,
    firstWord,
    wordsNumber,
    ready,
    save,
    edit
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
    
wordsNumber = do
    putStrLn("\nHow many words in the lyrics do you want?")
    
ready = do
    putStrLn("\nAlright, here's your lyrics:\n")

save = do
    putStrLn("\n\nDo you want to 'save', 'edit' or 'discard' the lyric?")

edit = do
    putStrLn("\nOperations:")
    putStrLn("1 - Remove by name: type '1 wordname'")
    putStrLn("2 - Edit by name: type '2 oldword newword'")
    putStrLn("3 - Add line break after word: type '3 word'")
    putStrLn("4 - Add new word before: type '4 word newword'")
    putStrLn("5 - Salvar: type '5'")
    putStrLn("6 - Discard: type '6'")
