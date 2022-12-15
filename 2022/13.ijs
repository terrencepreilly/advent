data =: freads '13.txt'
pairs =: _2 [\ LF cut data
parse =: (',[';';(<' ; '[]';'(<0$0)' ; '],';');' ; '[';'(<' ; ']';')' ; ',';';')&stringreplace
is_null =: (0$0)&-:
is_box =: (32 = (3 !: 0)) *. -.@:is_null
is_list =: $@:$ *. -.@:is_null
is_number =: (0&-:) +. (1&-:) +. (4 = 3!:0) *. (-.@:is_list)

NB. TODO: Is there a way to use these definitions?
NB. The problem is that tacit verbs are greedy, and so
NB. we can't use short-curcuiting.
NB. CMP
NB.
NB. cmp_boxes =: (}.@:[ cmp }.@:]) *. (>@:{.@:[ cmp >@:{.@:])
NB. cmp_box_num =: cmp &: boxopen
NB. cmp_null_any =: 1:
NB. cmp_nonnull_null =: 0:
NB. cmp_num_box =: cmp &: boxopen
NB. cmp_num_num =: < +. =


NB. 0 - not correct; 1 - correct; 2 continue
NB. box box
cmp_box_box =: 0:`1:`(cmp &: }.)@.(cmp_num_num &: (>@:{.))
NB. box num
cmp_box_num =: cmp &: boxopen
NB. null any
cmp_null_any =: 1:
NB. any null
cmp_nonnull_any =: 0:
NB. num box
cmp_num_box =: cmp &: boxopen
NB. num num
cmp_num_num =: <`2:@.=

NB. TODO: Make this tacit.
cmp =: 4 : 0
  repr =: ":`(1&{@:":)@.is_box
  a =. (repr x), ': ', (": is_box x) , (": is_number x) , (": is_null x)
  b =. (repr y), ': ', (": is_box y) , (": is_number y) , (": is_null y)
  stdout 'cmp: ', a , ' ; ' , b , LF
  if. (is_box x) *. is_box y do.
    x cmp_boxes y
  elseif. (is_box x) *. is_number y do.
    x cmp_box_num y
  elseif. is_null x do.
    stdout ' ' , (": x cmp_null_any y), LF
    x cmp_null_any y
  elseif. is_null y do.
    stdout ' ' , (": x cmp_nonnull_null y), LF
    x cmp_nonnull_null y
  elseif.  (is_number x) *. is_box y do.
    x cmp_num_box y
  elseif. (is_number x) *. is_number y do.
    stdout ' ' , (": x cmp_num_num y), LF
    x cmp_num_num y
  else.
    type_jthrow =: ''
    throw.
  end.
)


d =: ".@:parse each pairs

NB. ({. cmp {:)"1 d

expected =: 1 1 0 1 0 1 0 0
