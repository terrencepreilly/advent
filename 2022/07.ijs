data =: dltbs each LF cut freads '07.txt'

is_dir =: 'd'&= @: {.
is_ls =: -:&'$ ls'
classes =: {. each data

is_command =: '$' = {.
get_name =: 5&}.
NB. get_size =: ". @: > @: {. @: (' '&cut)
clean =: , @: (] ` get_name @. is_command)

cleaned =: clean each (> -.@:(is_dir +. is_ls) each data) # data

coclass 'DirMap'

create =: {{ dirs =: 0 $ 0 }}
destroy =: codestroy
index =: {{
  is_empty =. -:&(0 $ 0) @: [
  dirs (({.@:[ i. <@:])`1:@.is_empty) y
}}
append =: {{
  if. dirs -: 0 $ 0 do.
    dirs =: 2 1 $ x ; y
  else.
    dirs =: dirs ,. x ;y
  end.
}}
set =: {{ dirs =: |: (x ; y) (index x) } |: dirs }}
get =: {{ > (index y) { {: dirs }}
add =: {{
  if. (# {. dirs) = index x do.
    x append 0
  end.
  new_value =. y + get x
  x set new_value
}}

cocurrent 'base'


dedup =: 3 : 0
  stack =. 0 $ 0
  output =. 1 1 $ < (0 $ 0)
  for_m. y do.
    NB. There's a space if it's a file.
    if. ' ' e. > m do.
      output =. output , < stack , m
    else.
      if. '..' -: > m do.
        stack =. }: stack
      else.
        stack =. stack , m
      end.
      output =. output , < stack
    end.
  end.
  ~. }. output
)

count =: 3 : 0
  curr =. 0
  D =: conew 'DirMap'
  create__D ''
  for_m. y do.
    item =: > {: , > m
    is_file =: ' ' e. item
    if. is_file do.
      stack =: }: , > m
      num =: ". > {. ' ' cut item
      for_i. >: i. # stack do.
      (i {. stack) add__D num
      end.
    end.
  end.
  D
)

totals =: count dedup cleaned
answer =: +/ ((<&100001 # ])@:>@:{:) dirs__totals

total_size =: > {. {: dirs__totals
current_space =: 70000000 - total_size
required_space =: 30000000
need_to_free =: | required_space - current_space

sorting =: /: {: dirs__totals
sorted =: ([: |: |: /: {:) dirs__totals
test =: (=&need_to_free) +. (>&need_to_free)
index =: {. I. test > {: sorted
answer2 =: > index { {: sorted

stdout (,&LF) ": answer2

destroy__totals ''
exit 0
