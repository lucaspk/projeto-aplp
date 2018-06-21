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

    --let meuMapSub = SubMap2 (Map.singleton "casa" 1)
    let mapDic = Map.singleton "default" (Map.singleton "default" 1)
    --print (subMap (Map.singleton "default" (Map.singleton "default" 1)) "default")
    --print (Map.insert "default2" (Map.singleton "default2" 1) mapDic)
    --print (Map.keys (Map.elems (Map.singleton "default" (Map.singleton "default2" 1))))
    let test = (addAllToMap mapDic (take 500 part4))
    print (test)

subMap :: Map String (Map String Int) -> String -> Maybe (Map String Int)
subMap map key = Map.lookup key map

--mapInsert :: Map String (Map String Int) -> (String, String) -> Map String Int
--mapInsert map value = Map.insert (snd value) 1 (subMap map (fst value))

--addToMap :: MapDic String b -> [(String, String)] -> Bool
--addToMap map (x:xs) = if not (Map.member (fst x) map) then False
--                        else True

addToMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addToMap map value = if (Map.notMember (fst value) map) then Map.insert (fst value) (Map.singleton (snd value) 1) map
                    --else ifMap.insert (snd value) (Map.singleton (snd value) 1) (Map.lookup (fst value) map)
                    else
                        --if (Map.member (snd value) (Map.elems )) then
                       --     Map.insert (fst value) ((fst value) (Map.singleton (snd value) 1)) map
                        --else
                          --  if (Map.notMember (snd value) (Map.findWithDefault "not" (fst value) map)) then
                                --Map.insert (snd value) (Map.singleton (snd value) 1) map
                            --else
                        if (isMember (findSubMap map (fst value)) (snd value)) then
                            updateSubMap map value
                        else
                            Map.insert (fst value) (Map.singleton (snd value) 1) map
                                {-addToMap :: Maybe Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addToMap map value = if (Map.notMember (fst value) map) then Map.insert (fst value) (Map.singleton (snd value) 1) map
                     else
                        if (Map.notMember (snd value) (Map.lookup (fst value) map)) then
                            Map.update (Map.insert (snd value) (Map.singleton (snd value) 1) (Map.lookup (fst value) map)) (fst value) map
                        else 
                            Map.update (Map.insertWith (+) (snd value) 1 (Map.lookup (fst value) map)) (fst value) map
-}

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

--addNewKey :: Key -> Key -> MainMap
--addNewKey k1 k2 = M.singleton k1 (M.singleton k2 1)

--uptdateKey :: (MainMap) -> Key -> Key -> SubMap
--updateKey map k1 k2 = alter 2 "joao" (fromListWithKey "casa" map)

--addFrequency (a, b) map = if (not (M.member a b map)) then True else False

--data SubMap2 a = SubMap2 (Map a Int) deriving (Eq, Show)

-- Insert
--insert mainKey (SubMap2 a) (SuperMap2 b) = SuperMap2 (Map.insertWith' mainKey a b)

--insertSub elem (SubMap2 b) = SubMap2 (Map.insertWith' (+) elem 1 b)
