
data =: freads '02.txt'
parse =: {{ ". each LF&cut rplc&('A';'0';'B';'1';'C';'2';'X';'0';'Y';'1';'Z';'2') y }}
data =: parse data

index_card =: {: @: [ { ({. @:[ { ])

NB.   X Y Z
NB. A 3 6 0
NB. B 0 3 6
NB. C 6 0 3
scorecard =: 3 3 $ 3 6 0 0 3 6 6 0 3
wscore =: > index_card&scorecard each data
pscore =: > >:@:{: each data
answer =: +/ pscore , wscore

NB.    X Y Z
NB. A  3 1 2
NB. B  1 2 3
NB. C  2 3 1
piececard =: 3 3 $ 3 1 2 1 2 3 2 3 1
pscore2 =: > index_card&piececard each data
wscore2 =: > 3&*@:{: each data
answer2 =: +/ wscore2 , pscore2
