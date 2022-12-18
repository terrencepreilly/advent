split_numbers =: -.@:('0123456789-' e.~ ]) <;._1 ]
remove_empty =: -.@:((<0$0)&=) # ]
parse_numbers =: remove_empty @: split_numbers
parse =: (_4&([\)) @: > @: (". each) @: parse_numbers

NB. Get rid of negative numbers.
min_at =: 1 : '| @: (0&<.) @: (<./^:2) @: (u&{"1)'
max_at =: 1 : '| @: (0&>.) @: (>./^:2) @: (u&{"1)'
normalize =: 4&$ @: ((0; 2) min_at , (1 ; 3) min_at) +"1 ]

NB. Note that our map is the |:^:_1 of the example.
empty_map =: '.'&($~) @: (>: @: >./ @: (2 2&$) @: (>./))

NB. x: the parsed data, y: the map
render_sensors =: {{ 'S' ((<"1 @: (2&{.)"1) x) } y }}
render_beacons =: {{ 'B' ((<"1 @: (2&}.)"1) x) } y }}

NB. List the points within the given distance between this
NB. sensor and beacon.
mdist =: +/@:|@:-
xcoords =: <"0 @: i. @: >: @: mdist
ycoords =: i.@:>: each @: (mdist - each xcoords)
within_quarter =: > @: remove_empty @: , @: { @: (xcoords ,. ycoords)
NB. TODO: Can probably use { (_1 1) ; _1 1 to produce these four at the
NB. same time.
q1 =: [ +"1 within_quarter
q2 =: [ +"1 (_1 1) *"1 1 within_quarter
q3 =: [ +"1 (1 _1) *"1 1 within_quarter
q4 =: [ +"1 (_1 _1) *"1 1 within_quarter
scanned =: [: ~. q1 , q2 , q3 , q4

NB. x the data
NB. y the scanned points
NB. TODO: Factor out max_bounds, and let the user use a custom max bounds.
max_bounds =: (0;2)max_at , (1;3) max_at
remove_oob =: -. @: +./"1 @: (0&>@:] +. [ (= +. <)"1 ]) # ]

NB. x The amount by which to shift the map in the horizontal direction.
NB. y the raw data
render =: 4 : 0
  data =: normalize parse y
  NB. Shift the data over the given amount.
  NB. This gives us space on the left of the map.
  data =: (4 $ (x , 0)) +"1 data
  new_max_bounds =. (x, 0) + max_bounds data
  m =: empty_map data
  NB. Add space to the right of the map.
  m =: ('.'&,) ^: x m
  for_reading. data do.
    sensor =: 2 {. reading
    beacon =: 2 }. reading
    sensed =: new_max_bounds remove_oob sensor scanned beacon
    m =: '#' (<"1 sensed) } m
  end.
  data render_sensors data render_beacons m
)

raw_data =: fread '15.txt'
padding =: 2
get_answer =: {{ +/ '#' = x { |: padding render y }}
NB. answer =: 2000000 get_answer
stdout (,&LF) ": 10 get_answer raw_data
exit 0
