word(preposition, to).
word(preposition, like).
word(preposition, in).
word(preposition, for).
word(preposition, with).
word(preposition, on).
word(preposition, of).
word(verb, wish).
word(verb, give).
word(verb, go).
word(verb, use).
word(verb, make).
word(verb, fuck).
word(verb, know).
word(verb, could).
word(verb, call).
word(verb, said).
word(verb, hit).
word(noun, ass).
word(noun, bitch).
word(noun, shit).
word(noun, airplanes).
word(noun, shooting).
word(noun, night).
word(adverb, now).
word(adverb, so).
word(adverb, then).
word(adverb, really).
word(adverb, fuckin).
word(pronoun, i).
word(pronoun, you).
word(pronoun, it).
word(pronoun, we).
word(pronoun, she).
word(pronoun, ya).
word(conjuction, and).
word(conjuction, but).
word(conjuction, if).
word(determiner, the).
word(determiner, a).
word(determiner, an).
word(determiner, that).
word(determiner, your).
word(determiner, my).
word(determiner, what).
word(determiner, no).

match(i, wish).
match(you, wish).
match(wish, it).
match(we, wish).
match(she, wish).
match(wish, ya).
match(i, give).
match(you, give).
match(give, you).
match(give, it).
match(we, give).
match(she, give).
match(give, she).
match(give, ya).
match(i, go).
match(you, go).
match(we, go).
match(she, go).
match(i, use).
match(use, me).
match(you, use).
match(use, you).
match(we, use).
match(she, use).
match(use, she).
match(i, make).
match(make, me).
match(you, make).
match(make, you).
match(make, it).
match(we, make).
match(she, make).
match(make, ya).
match(i, fuck).
match(fuck, me).
match(you, fuck).
match(fuck, you).
match(we, fuck).
match(she, fuck).
match(fuck, she).
match(fuck, ya).
match(i, know).
match(know, me).
match(you, know).
match(know, you).
match(know, it).
match(we, know).
match(she, know).
match(know, she).
match(know, ya).
match(i, could).
match(you, could).
match(could, you).
match(we, could).
match(she, could).
match(i, call).
match(call, me).
match(call, you).
match(we, call).
match(she, call).
match(i, said).
match(you, said).
match(we, said).
match(she, said).
match(i, hit).
match(hit, me).
match(you, hit).
match(hit, you).
match(hit, it).
match(we, hit).
match(she, hit).

is_vowel(Letter):-
    member(Letter, [a,e,i,o,u]).

starts_with_vowel(W):-
    atom_chars(W, Letters),
    nth0(0, Letters, First),
    is_vowel(First).

sentence(W1, W2, W3, W4, W5):-
    word(determiner, W1),
    word(noun,       W2),
    word(verb,       W3),
    word(determiner, W4),
    word(noun, W5).

sentence_rap(W1, W2, W3, W4, W5, W6):-
    match(W1, W3),
    word(pronoun, W1),
    word(adverb,       W2),
    word(verb,       W3),
    word(determiner, W4),
    word(adverb,       W5),
    word(noun, W6).


sentence2(A, B):-
    sentence_rap(A, really, B, that, fuckin, bitch).

sentenceMake(W2, W3, W4, W5):-
    (starts_with_vowel(W2) -> sentence(an, W2, W3, W4, W5); sentence(a, W2, W3, W4, W5)).

printfacts() :-
    forall(sentence_rap(i, really, W2, that, fuckin, bitch),format('~w ~w ~w ~w ~w ~w ~n', [i, really, W2, that, fuckin, bitch])).

pf() :- forall(sentenc(i, W2), format('~w ~w ~n', [i, W2])).
