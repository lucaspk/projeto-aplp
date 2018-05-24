module Txts (
    welcome,
    songStyle
) where

welcome = do
    putStrLn("\t###############################################################")
    putStrLn("\t##                                                           ##")
    putStrLn("\t##   ###    ### ##    ## ##### ## ######    ######           ##")
    putStrLn("\t##   ####  #### ##    ## ##    ## ##  ##    ##               ##")
    putStrLn("\t##   ## #### ## ##    ## ##### ## ##        ## ####          ##")
    putStrLn("\t##   ##  ##  ## ##    ##    ## ## ##  ##    ##  ##           ##")
    putStrLn("\t##   ##      ##  ######  ##### ## ######    ###### ENERATOR  ##")
    putStrLn("\t##                                                           ##")
    putStrLn("\t###############################################################")
    putStrLn("\n")
    return()

songStyle = do
    putStrLn("\nWhat music genre do you want? Type 'rap', 'pop', 'random' or 'mixed'?")