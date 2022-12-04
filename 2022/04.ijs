data =: > ". each ,. > > ('-'&cut) L:0 (','&cut) each LF cut freads '04.txt'

lte =: > +. =
gte =: < +. =
test =: ((0&{ gte 2&{) *. (1&{ lte 3&{)) +. ((0&{ lte 2&{) *. (1&{ gte 3&{))
solution =: +/ test"1 data

first  =: 0&{ + [: i. [: >: 1&{ - 0&{
second =: 2&{ + [: i. [: >: 3&{ - 2&{
test2 =: first ([ -. -.) second
solution2 =: +/ 0&< >./"1 test2"1 data
