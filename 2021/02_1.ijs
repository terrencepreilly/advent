require 'common.ijs'

reshape =: ] $~ 2 ,~ -:@:#
forward =: (0 1)&*
down =: (1 0)&*
up =: (_1 0)&*
navigate =: {{ +/ reshape ; ".each read_lines y }}

NB. */ navigate 'input_02.txt'
