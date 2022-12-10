
parse =: > @: (' '&cut each) @: (LF&cut)
convert =: ". each @:{:@:|:

data =: convert parse freads '10.txt'
type =: 4 = 3 !: 0

NB. cpu:
NB. +---+-------+----------+------+
NB. | x | clock | pipeline | tape |
NB. +---+-------+----------+------+
NB.
NB. pipeline:
NB. +-------+-------+
NB. | count | instr |
NB. +-------+-------+
init_pipeline =: 0 ; (0$0)&[
init_cpu =: 1 ; 0 ; init_pipeline ; <

get_x =: > @: (0&{)
set_x =: {{ x 0 } y }}
add_x =: <@:([ + get_x@:]) set_x ]

get_clock =: > @: (1&{)
set_clock =: {{ x 1 } y }}
tick =: <@:>:@:get_clock set_clock ]

NB. get_pipeline =: [: > (2&+@:[) { ]
get_pipeline =: > @: (2&{)
NB. pick_pipeline =: 0 = >@:{. @: (1&get_pipeline)
cycles =: 0:`2:@.type @: > @: {.@:get_tape
unpack_instruction =: cycles ; {.@:get_tape
load_instruction_setter =: 4 : 'x (3 2) } y'
load_instruction =: (}.@:get_tape ; <@:unpack_instruction) load_instruction_setter ]

NB. x is the index of the pipeline
NB. y is the cpu
get_updated_instr_counter =: <:@:>@:{.@:get_pipeline ; {:@:get_pipeline

counter_at_one =: 1 = >@:{.@:get_pipeline
has_instr =: type@:>@:{:@:get_pipeline
exec_instr =: >@:{:@:get_pipeline add_x ]
decr_instr_counter =: 3 : '(< get_updated_instr_counter y) 2 } y'
exec_and_decr =: decr_instr_counter @: exec_instr
NB. 0: zero or two counter, no instruction
NB. 1: zero or two counter, instruction
NB. 2: 1 counter, no instruction -- shouldn't happen
NB. 3: 1 counter, instruction
step =: ]`decr_instr_counter`decr_instr_counter`exec_and_decr@.([: #. counter_at_one , has_instr )
load_instruction_p =: ]`load_instruction@. (0 = > @: {. @: get_pipeline)
execute =: tick @: step @: load_instruction_p

get_tape =: > @: {:
