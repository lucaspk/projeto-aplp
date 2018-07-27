word(preposition, to).
word(preposition, for).
word(preposition, with).
word(verb, appreciate).
word(verb, want).
word(verb, fuck).
word(noun, ass).
word(noun, bitch).
word(noun, shit).
word(adverb, now).
word(adverb, back).
word(adverb, really).
word(pronoun, i).
word(pronoun, you).
word(pronoun, ya).
word(conjuction, and).
word(conjuction, but).
word(conjuction, if).
word(determiner, the).
word(determiner, that).
word(determiner, your).
word(determiner, my).
word(timer, tomorrow).
word(timer, today).
word(timer, now).
word(timer, tonight).

wordpop(adjective, bad).
wordpop(adjective, dangerous).
wordpop(adjective, baby).
wordpop(adjective, dead).
wordpop(preposition, to).
wordpop(preposition, like).
wordpop(preposition, in).
wordpop(preposition, for).
wordpop(preposition, with).
wordpop(preposition, on).
wordpop(preposition, of).
wordpop(verb, want).
wordpop(verb, feel).
wordpop(verb, believe).
wordpop(verb, wonder).
wordpop(verb, pray).
wordpop(verb, came).
wordpop(verb, think).
wordpop(noun, halo).
wordpop(noun, girl).
wordpop(noun, stuff).
wordpop(noun, kid).
wordpop(noun, face).
wordpop(noun, world).
wordpop(noun, eyes).
wordpop(adverb, now).
wordpop(adverb, so).
wordpop(adverb, away).
wordpop(adverb, then).
wordpop(adverb, never).
wordpop(adverb, much).
wordpop(pronoun, i).
wordpop(pronoun, you).
wordpop(pronoun, we).
wordpop(pronoun, she).
wordpop(conjuction, and).
wordpop(conjuction, but).
wordpop(conjuction, if).
wordpop(determiner, the).
wordpop(determiner, a).
wordpop(determiner, that).
wordpop(determiner, your).
wordpop(determiner, my).
wordpop(determiner, no).
matchpop(for, my).
matchpop(for, a).
matchpop(for, no).
matchpop(of, my).
matchpop(of, your).
matchpop(on, my).
matchpop(you, that).
matchpop(she, that).
matchpop(we, that).
matchpop(i, that).
matchpop(i, your).
matchpop(i, a).
matchpop(she, no).
matchpop(we, no).
matchpop(pray, for).
matchpop(think, of).
matchpop(believe, in).


match(the, ass).
match(the, bitch).
match(the, shit).
match(that, ass).
match(that, bitch).
match(that, shit).
match(your, ass).
match(your, bitch).
match(your, shit).
match(my, ass).
match(my, bitch).
match(my, shit).
match(to, the).
match(to, that).
match(to, your).
match(to, my).
match(for, the).
match(for, that).
match(for, your).
match(for, my).
match(with, the).
match(with, that).
match(with, your).
match(with, my).
match(and, the).
match(and, that).
match(and, your).
match(and, my).
match(but, the).
match(but, that).
match(but, your).
match(but, my).
match(if, the).
match(if, that).
match(if, your).
match(if, my).
match(wish, the).
match(wish, that).
match(wish, your).
match(wish, my).
match(give, the).
match(give, that).
match(give, your).
match(give, my).
match(fuck, the).
match(fuck, that).
match(fuck, your).
match(fuck, my).
match(the, back).
match(that, really).
match(your, now).
match(your, back).
match(your, really).
match(my, back).

match(i, you).
match(i, your).
match(i, that).
match(i, the).
match(you, the).
match(you, that).
match(you, my).
match(want, ass).

match(want, that).
match(that, bitch).


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

sentence_rap(W1, W2, W3, W4):-
    match(W1, W3),
    match(W3, W4),
    word(pronoun, W1),
    word(verb,       W2),
    word(determiner, W3),
    word(noun, W4).

sentence_pop(W1, W2, W3, W4, W5):-
    matchpop(W2, W3),
    wordpop(pronoun, W1),
    wordpop(verb,       W2),
    wordpop(preposition, W3),
    wordpop(determiner, W4),
    wordpop(noun, W5).


sentence3(W1, W2, W3, W4, W5, W6):-
    match(W1, W3),
    match(W1, W2),
    match(W4, W6),
    match(W4, W5),
    word(pronoun, W1),
    word(adverb,       W2),
    word(verb,       W3),
    word(determiner, W4),
    word(adverb,       W5),
    word(noun, W6).

sentenceMake(W2, W3, W4, W5):-
    (starts_with_vowel(W2) -> sentence(an, W2, W3, W4, W5); sentence(a, W2, W3, W4, W5)).

printfacts() :-
    forall(sentence(W1, W2, W3, W4, W5),format('~w ~w ~w ~w ~w ~n', [W1, W2, W3, W4, W5])).

mostrar_refraos_rap() :-
    forall(sentence_rap(W1, W2, W3, W4),format('~w ~w ~w ~w ~n', [W1, W2, W3, W4])).

mostrar_refraos_pop() :-
    forall(sentence_pop(W1, W2, W3, W4, W5),format('~w ~w ~w ~w ~w ~n', [W1, W2, W3, W4, W5])).
