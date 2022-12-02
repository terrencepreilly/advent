
data =: freads '02.txt'
parse =: {{ ". each LF&cut rplc&('A';'0';'B';'1';'C';'2';'X';'0';'Y';'1';'Z';'2') y }}
data =: parse data

index_card =: {: @: [ { ({. @:[ { ])

NB.   X Y Z
NB. A 3 6 0
NB. B 0 3 6
NB. C 6 0 3
scorecard =: 3 3 $ 3 6 0 0 3 6 6 0 3
score =: > index_card&scorecard each data
piece_score =: > >:@:{: each data
answer =: +/ piece_score , score

NB.    X Y Z
NB. A  3 1 2
NB. B  1 2 3
NB. C  2 3 1
piececard =: 3 3 $ 3 1 2 1 2 3 2 3 1
pieces =: > index_card&piececard each data
win_score =: > 3&*@:{: each data
answer2 =: +/ win_score , pieces
