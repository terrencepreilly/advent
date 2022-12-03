data =: LF cut freads '03.txt'

lines =: ] $~ [ , [ %~ #@:]
columns =: ] $~ [ ,~ [ %~ #@:]
doubled =: [: ~. ([ -. -.)/ @: (2&lines)

priority_lookup =: (26 {. 'a' dropto a.) , (26 {. 'A' dropto a.)
priority =: 1 + (priority_lookup&i.)

answer =: +/ > (priority @: doubled) each data

common =: (~. @: ([ -. -.)/ @: >)"1
answer2 =: +/ , priority common 3 columns data
