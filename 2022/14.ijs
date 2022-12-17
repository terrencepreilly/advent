sand_source =: 500 0

split_lines =: (' -> '&cut each) @: (LF&cut)
is_arrow =: (<'->')&(-:"0)
remove_arrow =: (-.@:is_arrow # ]) L:1
parse =: {{ >L:1 ".L:0 remove_arrow split_lines y }}

NB. Build a table from the descriptions.
dimensions =: >: @ >./ @: > @: (>./ L:0)
blank_table =: ($&'.') @: dimensions

NB. Split of the descriptions into sets of 2
divide_paths =: 2&([\) each

amount =: | @: -/
subpath =: 1 : '(<./) @: (u"1) + i. @: >: @: amount @: (u"1)'
path =: < @: ({. subpath ; {: subpath)

remove_empty =: -. @: ((<0$0) = ]) # ]
paths =: (<: L:0) @: remove_empty @: , @: > @: ((path"2) each) @: divide_paths

NB. y the raw data
NB. You have to transpose the returned value to get the
NB. actual map.
draw_paths =: {{
  data =. parse y
  t =. blank_table data
  for_p. paths data do.
    my_p =: p
    t =. '#' p } t
  end.
  t
}}

raw_data =: freads '14.txt'

NB. Design a cellular automaton that simulates the falling sand.

NB. Cases:
NB.   /o/ => /./
NB.   /./    /o/
fall_down =: (0 1 ; 1 1)

NB.   /o/ => /./
NB.   .x/ => ox/
fall_left =: (0 1 ; 1 0)

NB.   /o/ => /./
NB.   xx. => xxo
fall_right =: (0 1 ; 1 2)

check =: 'o.'&-: @: {
update =: {{ '.o' x } y }}

pu =: 1 : ']`(u&update)@.(u&check)'
update_cell =: (fall_right pu) @: (fall_left pu) @: (fall_down pu)

indices =: [: >@:,@:{ i. each @: ;/ @: (-&(1 2)) @: $
get_cell =: [: < ((0 1) + {.) ; (0 1 2) + {:
update_at_index =: {{ (update_cell (get_cell x) { y) (get_cell x) } y }}
update_map =: 3 : 0
  m =. y
  for_i. indices m do.
    m =. i update_at_index m
  end.
)

NB. x the index at which to insert the sand.
NB. y the map.
insert_sand =: 4 : 0
  'o' (< x) } y
)

in_abyss =: 'o' e. {:

NB. TODO: Instead of updating every single part of the map,  we should start
NB. at the sand origin, and only update at one down, and + _1 0 or 1.  And
NB. if there is no change, we're done.
answer =: (+/) @: (+/) @: ('o'&=) @: }: @: ((update_map @: ((0 500)&insert_sand)`]@.in_abyss)^:_)
