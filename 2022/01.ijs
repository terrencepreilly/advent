load 'strings'

data =: freads '01.txt'
parse =: (". @: ((LF,' ')&charsub)) each @: (([: 2&= (1&|. + [) @: (LF&=)) <;.2 ])
calories =: +/"1 > parse data
highest =: >. / calories
sum_three_heighest =: +/ 3 {. |. (/: { ]) calories
