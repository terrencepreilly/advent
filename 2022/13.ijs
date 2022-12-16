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
