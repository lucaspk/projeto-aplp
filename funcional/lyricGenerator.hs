import System.Environment
import Txts
import Data.Char
import qualified Data.Map.Strict as M
import Data.Map (Map)
import qualified Data.Map as Map

data MapDic a b = MapDic (Map b (Map a Int)) deriving (Eq, Show)


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

    let mapDic = (addAllToMap Map.empty part4)

    let probDic = calculeAllProbDic (Map.toList mapDic) Map.empty

    print (probDic)

divid :: Int -> Int -> Float
divid a b = (fromIntegral a) / (fromIntegral b)

addProbs :: [(String, Int)] -> Int -> Map String Float -> Map String Float
addProbs [] sum map = map
addProbs (x:xs) sum map = addProbs xs sum (Map.insert (fst x) (divid (snd x) sum) map)

calculeMapSum :: [(String, Int)] -> Int
calculeMapSum list = sum [snd x | x <- list]

calculeProbDic :: Map String (Map String Float) -> (String, (Map String Int)) -> Map String (Map String Float)
calculeProbDic map value = Map.insert (fst value) (addProbs (Map.toList (snd value)) (calculeMapSum (Map.toList (snd value))) (Map.empty)) map

calculeAllProbDic :: [(String, (Map String Int))] -> Map String (Map String Float) -> Map String (Map String Float)
calculeAllProbDic [] map = map
calculeAllProbDic (x:xs) map = calculeAllProbDic xs (calculeProbDic map x) 

subMap :: Map String (Map String Int) -> String -> Maybe (Map String Int)
subMap map key = Map.lookup key map


addToMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addToMap map value = if (Map.notMember (fst value) map) then 
                        Map.insert (fst value) (Map.singleton (snd value) 1) map
                    else
                        if (isMember (findSubMap map (fst value)) (snd value)) then
                            updateSubMap map value
                        else
                            addNewToSubMap map value       

addNewToSubMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addNewToSubMap map (key, value) = Map.insert key (Map.insert value 1 (Map.findWithDefault Map.empty key map)) map

updateSubMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
updateSubMap map value = Map.insert (fst value) (Map.insert (snd value) (getValueSubMap map value) (findSubMap map (fst value))) map

getValueSubMap :: Map String (Map String Int) -> (String, String) -> Int
getValueSubMap map value = (Map.findWithDefault 0 (snd value) (Map.findWithDefault (Map.singleton "test" 0) (fst value) map)) + 1

findSubMap :: Map String (Map String Int) -> String -> Map [Char] Int
findSubMap map key = Map.findWithDefault (Map.singleton "test" 2) key map

isMember :: Map [Char] Int -> String -> Bool
isMember map value = if (Map.member value map) then True else False

addAllToMap :: Map String (Map String Int) -> [(String, String)] -> Map String (Map String Int)
addAllToMap map [] = map
addAllToMap map (x:xs) = addAllToMap (addToMap map x) xs

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
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = [(x,y)] ++ myZip xs ys
