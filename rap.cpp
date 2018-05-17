#include <bits/stdc++.h>
#include <iostream>

using namespace std;

#define ASCII_A 65
#define ASCII_Z 90
#define ASCII_DIFF 32

typedef map<string, map<string, double> > probDict;
typedef map<string, map<string, int> > counterDict;

inline int asciiCode(char a) {
    return a;
}

inline string toLowerCase(const string str) {
    string output;

    for (int i = 0; i < str.size(); i++) {
        int asciiChar = asciiCode(str[i]);
        if (ASCII_A <= asciiChar && asciiChar <= ASCII_Z) {
            output += (str[i] + ASCII_DIFF);
        } else {
            output += str[i];
        }
    }
    return output;
}

inline int getRandomIndex(const int size) {
    srand((int) time(0));
    return rand() % (size);
}

inline double randomDoubleNumber(const double lowerBound, const double upperBound) {
    uniform_real_distribution<double> unif(0.0, 1.0);
    default_random_engine re;
    return unif(re);
}

inline double randomDoubleNumb() {
    this_thread::sleep_for(chrono::milliseconds(2));
    default_random_engine eng{static_cast<long unsigned int>(chrono::high_resolution_clock::now().time_since_epoch().count())};
    uniform_real_distribution<double> unif(0, 1);

    return unif(eng);
}

inline string getRandomWord(probDict probabilities) {
    int index = getRandomIndex(probabilities.size());
    int i = 0;
    for (auto it = probabilities.begin(); it != probabilities.end(); ++it) {
        if (i == index) {
            return it->first;
        }
        i++;
    }
    return probabilities.begin()->first;
}

string markovNext(string curWord, probDict probabilities) {
    bool foundCurrWord = probabilities.find(curWord) != probabilities.end();
    if (foundCurrWord) {
        map<string, double> succProbs = probabilities[curWord];
        double randProb = randomDoubleNumb();
        double currProb = 0;
        for (auto it = succProbs.begin(); it != succProbs.end(); ++it) {
            currProb += it->second;
            if (randProb <= currProb) {
                return it->first;
            }
        }
    } 
    return getRandomWord(probabilities);
}

string makeRap(
    string curWord,
    probDict probabilities,
    unsigned short num_words = 50) {

        vector<string> rap;
        rap.push_back(curWord);
        for (int i = 0; i < num_words; i++) {
            rap.push_back(markovNext(rap[rap.size() - 1], probabilities));
        }

        string output = "";
        if (rap.size() > 0) {
            output = rap[0];
            for (int i = 1; i < rap.size(); i++) {
                output += (' ' + rap[i]);
            }
        }
        return output;
}

inline probDict toDict(string filePath) {
    counterDict counter;
    ifstream lyrics(filePath);

    vector<string> words;
    for (string line; getline(lyrics, line); ) {
        istringstream iss(line);
        vector<string> wordsLine{istream_iterator<string>{iss},
            istream_iterator<string>{}};

        if (wordsLine.size() > 0) {
            for (int i = 0; i < wordsLine.size(); i++)
                wordsLine[i] = toLowerCase(wordsLine[i]);            

            wordsLine[0] = "\n" + wordsLine[0];
            words.insert(words.end(), wordsLine.begin(), wordsLine.end());
        }
    }
    for (int i = 0; i < ((int)words.size()) - 1; i++) {
        counter[words[i]][words[i + 1]]++;
    }

    probDict result;
    for(auto it = counter.begin(); it != counter.end(); ++it) {
        map<string, int> c = it->second;
        
        int total = 0;
        for (auto it2 = c.begin(); it2 != c.end(); ++it2)
            total += it2->second;

        for (auto it2 = c.begin(); it2 != c.end(); ++it2)
            result[it->first][it2->first] = ((double)it2->second) / total;
    }

    return result;
}

inline void printMap(map<string, double> probs) {
    for (auto it = probs.begin(); it != probs.end(); ++it) {
        cout << it->first << " " << it->second << endl;
    }
}

int main(int argc, char const *argv[]) {
    probDict rapProbDict = toDict("lyrics2.txt");
    string word;
    cout << "What do you want to start your rap with? > ";
    cin >> word;
    cout << endl << "Alright, here's your rap:" << endl;
    cout << makeRap(word, rapProbDict) << endl;


    return 0;
}
