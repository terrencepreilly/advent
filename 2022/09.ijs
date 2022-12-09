NB. Coords are in the format 2 2 $ x1 y1 x2 y2
NB. where x1 and y1 are the head, and x2 y2 are
NB. the tail.

NB. I put the head at 0 0, always, so that the movement
NB. calculation below indexes into the correction array
NB. nicely.
head =: { (2 - i. 5) ; 2 - i. 5
possible_movements =: (2 2)&$ each (0 0)&(,"1 1) each head

NB. Converts all possible coordinates of head and tails into a
NB. code in i. 25.
movement =: 5&#. @: (2&+) @: -/

NB. Sets of actions the tail must take in each case.
id =: 0 0
d =: 0 _1
u =: 0 1
r =: 1 0
l =: _1 0

NB.                      | 0 0  | 0 0  | 0 0  | 0  0  | 0  0  |
NB.                      | 2 2  | 2 1  | 2 0  | 2 _1  | 2 _2  |
correction =:            (d + l);(d + l); l   ;(u + l);(u + l)

NB.                      | 0 0  | 0 0  | 0 0  | 0  0  | 0  0  |
NB.                      | 1 2  | 1 1  | 1 0  | 1 _1  | 1 _2  |
correction =: correction ,(d + l); id  ; id   ; id    ;(u + l)

NB.                      | 0 0  | 0 0  | 0 0  | 0  0  | 0  0  |
NB.                      | 0 2  | 0 1  | 0 0  | 0 _1  | 0 _2  |
correction =: correction ,   d  ; id   ; id   ; id    ; u

NB.                      |  0 0 |  0 0 |  0 0 |  0  0 |  0  0 |
NB.                      | _1 2 | _1 1 | _1 0 | _1 _1 | _1 _2 |
correction =: correction ,(d + r); id  ; id   ; id    ;(u + r)

NB.                      |  0 0 |  0 0 |  0 0 |  0  0 |  0  0 |
NB.                      | _2 2 | _2 1 | _2 0 | _2 _1 | _2 _2 |
correction =: correction ,(d + r);(d + r); r  ;(u + r);(u + r)


NB. y: the coordinates
NB. x: the direction to move in
index =: 'DLRU' i. [
mv =: (d&[) ` (l&[) ` (r&[) ` (u&[) @. ]
new_head =: mv @: index + {.@:]
set_head =: 2 : 'u 0 } v'
move_head =: new_head set_head ]


NB. y: the coordinates
set_tail =: 2 : 'u 1 } v'
tmv =: > @: ({&correction) @: movement
new_tail =: tmv + {:
move_tail =: new_tail set_tail ]


parse =: |: @: > @: (' '&cut each) @: (LF&cut)
clean =: ".@:>@:{: # {.
data =: , > clean parse freads '09.txt'

NB. y: the directions to move in as a sequence of letters
NB. returns: The positions visited by tail
simulate =: 3 : 0
  coords =. 2 2 $ 0
  visited =. 1 2 $ 0 0
  for_inst. y do.
    coords =. move_tail inst move_head coords
    visited =. visited , {: coords
  end.
  /:~ ~. visited
)

answer1 =: # simulate data
