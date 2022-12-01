load '03_1.ijs'

NB. get_input

index    =: > @: (0&{) @: ]
numbers  =: > @: (1&{) @: ]

most_common_at =: [: most_common index { |:@:numbers
least_common_at =: -. @: most_common_at

retain_most_common_at =: numbers {~ [: I. most_common_at = index {"1 numbers
retain_least_common_at =: numbers {~ [: I. least_common_at = index {"1 numbers

found =: 1 = #@:numbers
oxygen_step =: >:@:index ; retain_most_common_at
oxygen =: [: numbers (oxygen_step ` ] @. found) ^: _ 

co2_step =: >:@:index ; retain_least_common_at
co2 =: [: numbers (co2_step ` ] @. found) ^: _ 

life_support =: #. @: oxygen * #. @: co2



NB. life_support 0 ; get_input 'input_03.txt'
