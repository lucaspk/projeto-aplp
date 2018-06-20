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
    print (addAllToMap mapDic part4)
    
{-
- Insere um elemento na estrutura. Caso o elemento ja existe, sua quantidade na estrutura sera incrementada.
-}
--insert elem (Bag b) = Bag (Map.insertWith' (+) elem 1 b)


--addToMap :: MapDic String b -> [(String, String)] -> Bool
--addToMap map (x:xs) = if not (Map.member (fst x) map) then False
--                        else True
                   
addToMap :: Map String (Map String Int) -> (String, String) -> Map String (Map String Int)
addToMap map value = Map.insert (fst value) (Map.singleton (snd value) 1) map

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
