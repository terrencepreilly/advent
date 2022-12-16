data =: freads '13.txt'

pairs =: _2 [\ LF cut data
parse =: ('[]';'(<0$0)' ; ',[';';(<' ; '],';');' ; '[';'(<' ; ']';')' ; ',';';')&stringreplace
is_null =: (0$0)&-:
is_box =: (32 = (3 !: 0)) *. -.@:is_null
is_list =: $@:$ *. -.@:is_null
is_number =: (0&-:) +. (1&-:) +. (4 = 3!:0) *. (-.@:is_list)

cmp_box_box =: 0:`1:`(cmp &: }.)@.(cmp &: (>@:{.))
cmp_box_num =: cmp &: boxopen
cmp_null_any =: 1:
cmp_nonnull_any =: 0:
cmp_num_box =: cmp &: boxopen
cmp_num_num =: <`2:@.=

NB. TODO: Make this tacit.
cmp =: 4 : 0
  if. (is_box x) *. is_box y do.
    x cmp_box_box y
  elseif. (is_box x) *. is_number y do.
    x cmp_box_num y
  elseif. (is_null x) *. is_null y do.
    2
  elseif. is_null x do.
    x cmp_null_any y
  elseif. is_null y do.
    x cmp_nonnull_any y
  elseif.  (is_number x) *. is_box y do.
    x cmp_num_box y
  elseif. (is_number x) *. is_number y do.
    x cmp_num_num y
  else.
    type_jthrow =: ''
    throw.
  end.
)

d =: ".@:parse each pairs
order =: ({. cmp {:)"1 d

answer1 =: +/ order # (>: i. # order)


NB. TODO: I made the mergesort backwards, and it sorts from greatest to
NB. least.  Reverse.
init =: (,&(<<<2)) @: (,&(<<<6)) @: ,

NB. x The items
NB. y The range, a list of the number of values to drop and the number to
NB.   take (right exclusive). For a list, l, of size n, then l to_sort 0, <: n
NB.   is its identity.
pivot =: {~ {:
sorted =: (}.~ {.@:]) ({.~ >@:-/@:|.@:]) ]
compared =: 0 < pivot cmp"1 0 sorted
partition_left =: compared # sorted
partition_right =: -.@:compared # sorted

do_sort =: 0&> @: -/ @: ]
recurse_left =: partition_left mergesort_in (0 , <:@:#@:partition_left)
recurse_right =: partition_right mergesort_in (0 , <:@:#@:partition_right)
mergesort_in =: [`(recurse_left , pivot , recurse_right)@.do_sort
mergesort =: ] mergesort_in (0 , <: @: #)

answer2 =: (>:@:i.&(<<<2) * (>:@:i.&(<<<6))) |. mergesort init d
