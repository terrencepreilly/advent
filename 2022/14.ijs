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

NB. y the parsed data
NB. You have to transpose the returned value to get the
NB. actual map.
draw_paths =: {{
  t =. blank_table y
  for_p. paths y do.
    my_p =: p
    t =. '#' p } t
  end.
  t
}}

NB. Restrict the output to contain just the rock (for debugging.)
restrict =: {{
  cols =. I. '#' e."1 y
  min_col =. <./ cols
  max_col =. >./ cols
  newy =. (2 + max_col - min_col) {. (<: min_col) }. y
  newy =. |: newy
  rows =. I. '#' e."1 newy
  min_row =. <./ rows
  max_row =. >./ rows
  newy =. (2 + max_row - min_row) {. (<: min_row) }. newy
  newy
}}


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
NB. update_at_index =: {{ (update_cell (get_cell x) { y) (get_cell x) } y }}

NB. x The index where we're starting the update
NB. y The map
NB. Returns the updated map.
update_map =: 4 : 0
  m =. y
  prev =. 0 $ 0
  index =. x
  while. -. prev -: index do.
    prev =. index
    cell =. (get_cell index) { m
    updated_cell =. update_cell cell
    m =. updated_cell (get_cell index) } m
    NB. 7 no change; 1 left; 5 down; 4 right
    update_case =. #. *./ cell = updated_cell
    NB. We'll add spaces to the left & right of the map to ensure the indices
    NB. are never negative.
    index =. (]`((1 _1)&+)`]`]`((1 1)&+)`((1 0)&+)`]`]@.update_case) index
    NB. Check if out of bounds, and if so, stop.
    too_small =: <&0 @: [
    too_big =: (> +. =) <:@:$@:]
    if. index ([: +./ too_small +. too_big) m do.
      prev =. index
    end.
  end.
  m
)

NB. x the index at which to insert the sand.
NB. y the map.
insert_sand =: 4 : 0
  'o' (< x) } y
)

in_abyss =: 'o' e. {:
get_answer =: (+/) @: (+/) @: ('o'&=) @: }: @: (((0 500)&update_map @: ((0 501)&insert_sand)`]@.in_abyss)^:_)
run =: (((0 498)&update_map @: ((0 499)&insert_sand)`]@.in_abyss)^:_)

raw_data =: freads '14.txt'
data =: |: draw_paths parse raw_data
stdout (,&LF) ": get_answer data


data =: parse raw_data
map =: |: draw_paths data

last_hash =: >: @: (>./) @: I. @: ('#'&e."1)
widen_left =: '.'&,.
widen_right =: ,.&'.'
add_floor =: ,&'#' @: (,&'.') @: (last_hash {. ])

NB. For some reason, I'm missing a line at the top.
NB. Some sort of off-by-one error above.
map =: '.' , map

run =: (((0 2498)&update_map @: ((0 2499)&insert_sand)`]@.in_abyss)^:_)
map =: add_floor (widen_right ^: 2000) (widen_left ^: 2000) map
ran_map =: run map
answer2 =: +/ +/ 'o' = ran_map
stdout (,&LF) ": answer2
exit 0
