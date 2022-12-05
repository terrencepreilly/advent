crates =: ,. dltbs @: , @: > each <"1 |: > ;/ each LF cut freads '05.txt'
instrs =: > ". each LF cut freads '05_2.txt'

amount =: {. @: [
from =: <: @: (1&{) @: [
to =: <: @: (2&{) @: [
new_from =: [: < amount }. ; @: (from { ])
crane_version =: 0:
new_to =: [: < ((] ` |. @. crane_version) @: (amount {. ; @: (from { ]))) , (; @: (to { ]))
update =: {{
  a =. x new_from y
  b =. x from y
  c =. x new_to y
  d =. x to y
  c d } a b } y
}}

update_all =: {{
  a =. y
  for_i. x do.
    a =. i update a
  end.
  a
}}

answer =: , > {. each instrs update_all crates

crane_version =: 1:
answer2 =: , > {. each instrs update_all crates
