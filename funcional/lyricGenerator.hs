import System.Environment
import Txts
import Data.List 
import Data.List (sortBy)
import Data.Char
import Data.Map (Map)
import qualified Data.Map as Map
import qualified System.Random as R
import Control.Monad.Random


data MapDic a b = MapDic (Map b (Map a Int)) deriving (Eq, Show)

main :: IO ()
main = do
    Txts.welcome
    
    Txts.songGenre
    genre <- getLine

    Txts.firstWord
    firstWord <- getLine

    popLyrics <- readFile "pop.txt"
    rapLyrics <- readFile "rap.txt"

    let pop = popLyrics :: String
    let rap = rapLyrics :: String

    let lyrics = selectGenre genre pop rap

    Txts.wordsNumber
    wordsNum <- getLine
    let wordsNumber = read wordsNum :: Int

    Txts.ready

    let part3 = mySplit (==' ') (toLowerCase (replace lyrics))
    
    let part4 = myZip (tail part3) (init part3)

    let mapDict = (addAllToMap Map.empty part4)

    let probDict = calculeAllProbDict (Map.toList mapDict) Map.empty
    
    probs1 <- evalRandIO $ dice 20
    probs2 <- evalRandIO $ dice 20
    probs3 <- evalRandIO $ dice 20
    probs4 <- evalRandIO $ dice 20

    let lyric1 = (makeLyric probDict (div wordsNumber 4) [firstWord] probs1)
    
    let lyric2 = (makeLyric probDict (div wordsNumber 4) [(last lyric1)] probs2)

    let lyric3 = (makeLyric probDict (div wordsNumber 4) [(last lyric2)] probs3)

    let lyric4 = (makeLyric probDict (div wordsNumber 4) [(last lyric3)] probs4)

    let complete = ((lyric1 ++ (tail lyric2) ++ (tail lyric3) ++ (tail lyric4)))

    putStrLn (intercalate " " complete)

    Txts.save

    save <- getLine

    if (save == "save") then
        saveOnBase (intercalate " " complete) genre
    else if (save == "edit") then
        editor (intercalate " " complete) genre
    else putStrLn("\nThe lyric was discarded!")

    main

editor :: String -> String -> IO()
editor lyric genre = do

    Txts.edit

    operation <- getLine

    let arrayLyric = mySplit (==' ') lyric

    let operands = mySplit (==' ') operation

    if ((head operands) == "1") then
        showLyric (concat (intersperse " " (removeAll arrayLyric (last operands)))) genre
    else if ((head operands) == "2") then
        showLyric (concat (intersperse " " (editWordByName arrayLyric (last (init operands)) (last operands)))) genre
    else if ((head operands) == "3") then
        showLyric (concat (intersperse " " (addLineBreaker arrayLyric (last operands)))) genre
    else if ((head operands) == "4") then
        showLyric (concat (intersperse " " (addWordBefore arrayLyric (last (init operands)) (last operands)))) genre
    else if ((head operands) == "5") then
        saveOnBase lyric genre
    else
        main

showLyric :: String -> String -> IO()
showLyric str genre = do
    putStrLn ("")
    putStrLn (str)
    editor str genre

saveOnBase :: String -> String -> IO()
saveOnBase lyric genre = do
    putStrLn (lyric)
    if (genre == "rap") then
        appendFile "rap.txt" lyric
    else 
        appendFile "pop.txt" lyric

------------------- Operations -----------------------------------
removeAll :: [String] -> String -> [String]
removeAll xs word = [x | x <- xs, x /= word]

removeByIndex xs index = take (index - 1) xs ++ drop (index) xs

editWordByName :: [String] -> String -> String -> [String]
editWordByName [] oldWord newWord = []
editWordByName (x:xs) oldWord newWord = if (x == oldWord) then
                                            newWord : editWordByName xs oldWord newWord
                                        else x : editWordByName xs oldWord newWord

addWordBefore :: [String] -> String -> String -> [String]
addWordBefore [] word newword = []
addWordBefore (x:xs) word newword = if (x == word) then
                                newword : x : addWordBefore xs word newword
                            else x : addWordBefore xs word newword
                                        

addLineBreaker :: [String] -> String -> [String]
addLineBreaker [] word = []
addLineBreaker (x:xs) word = if (x == word) then
                                (lineB x) : addLineBreaker xs word
                            else x : addLineBreaker xs word

lineB :: String -> String
lineB = (++) "\n"
------------------------------------------------------------------

randomNumber :: (RandomGen g) => Rand g Float
randomNumber = do
      randomNumber <- getRandomR (0.0, 0.5)
      return $ randomNumber
    
dice :: RandomGen g => Int -> Rand g [Float]
dice n = sequence (replicate n randomNumber)
    
---------------------------------------------------------------
selectGenre genre pop rap = if (genre == "pop") then pop
                            else if (genre == "rap") then rap
                            else (pop ++ rap)

------------------------MakeRap--------------------------------

makeLyric :: Map String (Map String Float) -> Int -> [String] -> [Float] -> [String]
makeLyric probDict 0 array probs = array
makeLyric probDict wordsNumber array probs = makeLyric probDict (wordsNumber - 1) (array ++ [(markovNext (last array) probDict probs)]) probs


----------------------Markov_Next------------------------------
markovNext :: String -> Map String (Map String Float) -> [Float] -> String
markovNext current probDict probs = if (Map.member current probDict) then
                                        selectWord (addExtraProb probs (Map.toList (probDict Map.! current)))
                                    else selectWord (addExtraProb probs (Map.toList (probDict Map.! "when")))

addExtraProb :: [Float] -> [(String, Float)] -> [(String, Float)]
addExtraProb (x:xs) [] = []                       
addExtraProb [x] (y:ys) = ((fst y), (snd y) + x) : addExtraProb [x] ys
addExtraProb (x:xs) (y:ys) = ((fst y), (snd y) + x) : addExtraProb xs ys

selectWord :: [(String, Float)] -> String
selectWord words = fst (returnMaxProb ("a", -0.1) words)

returnMaxProb :: (String, Float) -> [(String, Float)] -> (String, Float)
returnMaxProb maxProb [] = maxProb
returnMaxProb maxProb (x:xs) = if ((snd x) > (snd maxProb)) then returnMaxProb x xs
                               else returnMaxProb maxProb xs
    
addExponencialProb :: [(String, Float)] -> [Float] -> [(String, Float)]
addExponencialProb [] _ = []
addExponencialProb (x:xs) (y:ys) = (fst x, (snd x) + y) : addExponencialProb xs ys

------------------------ToDict---------------------------------

calculeAllProbDict :: [(String, (Map String Int))] -> Map String (Map String Float) -> Map String (Map String Float)
calculeAllProbDict [] map = map
calculeAllProbDict (x:xs) map = calculeAllProbDict xs (calculeProbDict map x) 

calculeProbDict :: Map String (Map String Float) -> (String, (Map String Int)) -> Map String (Map String Float)
calculeProbDict map (key, subMap) = Map.insert key (addProbs (Map.toList subMap) (calculeMapSum (Map.toList subMap)) (Map.empty)) map

calculeMapSum :: [(String, Int)] -> Int
calculeMapSum list = sum [snd x | x <- list]

addProbs :: [(String, Int)] -> Int -> Map String Float -> Map String Float
addProbs [] sum map = map
addProbs (x:xs) sum map = addProbs xs sum (Map.insert (fst x) (divide (snd x) sum) map)

divide :: Int -> Int -> Float
divide a b = (fromIntegral a) / (fromIntegral b)

---------------------------------------------------------------------------------------------------

addAllToMap :: Map String (Map String Int) -> [(String, String)] -> Map String (Map String Int)
addAllToMap map [] = map
addAllToMap map (x:xs) = addAllToMap (addToMap map x) xs

addToMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addToMap map (key, value) = if (Map.notMember key map) then 
                        Map.insert key (Map.singleton value 1) map
                    else
                        if (Map.member value (findSubMap map key)) then
                            updateSubMap map (key, value)
                        else
                            addNewToSubMap map (key, value)       

addNewToSubMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addNewToSubMap map (key, value) = Map.insert key (Map.insert value 1 (map Map.! key)) map
                            
updateSubMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
updateSubMap map (key, value) = Map.insert key (Map.insert value (getValueSubMap map (key, value)) (findSubMap map key)) map

getValueSubMap :: Map String (Map String Int) -> (String, String) -> Int
getValueSubMap map (key, value) = ((map Map.! key) Map.! value ) + 1

findSubMap :: Map String (Map String Int) -> String -> Map [Char] Int
findSubMap map key = map Map.! key
                            
----------------- Funções auxiliares ---------------------
toLowerCase :: [Char] -> [Char]
toLowerCase str = [ toLower x | x <- str]

replace :: [Char] -> [Char]
replace [] = []
replace (x:xs) =
    if x == '\n'
      then " \n" ++ replace xs
      else x : replace xs

mySplit :: (Char -> Bool) -> String -> [String]
mySplit p s = case dropWhile p s of
            "" -> []
            s' -> w : mySplit p s''
                where (w, s'') = break p s' 

myZip [] [] = []
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = [(x,y)] ++ myZip xs ys