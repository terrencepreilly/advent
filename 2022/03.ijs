data =: LF cut freads '03.txt'

first =: -:@:# {. ]
second =: -:@:# }. ]
doubled =: [: ~. first ([ -. -.) second

priority_lookup =: (26 {. 'a' dropto a.) , (26 {. 'A' dropto a.)
priority =: >: @: (priority_lookup&i.)

a_index =: a. i. 'a'
A_index =: a. i. 'A'

answer =: +/ > (priority @: doubled) each data


common =: (~. @: ([ -. -.)/ @: >)"1
reshape =: (3 ,~ (%&3)@:#) $ ]
answer2 =: +/ , priority common reshape data
