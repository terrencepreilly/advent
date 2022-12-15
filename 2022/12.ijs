parse =: > @: (LF&cut)

index_of =: I. @: (e."1) , ,@:(e."1 # ]) i. [
get_start =: 'S'&index_of
get_end =: 'E'&index_of

translate =: ((97 }. a.)&i.)"0 @: (('S';'a';'E';'z')&stringreplace"1)
NB. abcdefghijklmnopqrstuvwxyz


NB. ----- Implement djikstra's algorithm --------------------------------
neighbors =:  _2 [\ _1 0  1 0   0 1  0 _1
coordinates =: >@:,@:{ @: (i.@:{. ; i.@:{:) @: $

NB. Get all possible coordinates (including OOB)
all_neighbor_coordinates =: ,/ @: (|:"2) @: (neighbors&(,:/ . +)) @: |:

NB. y: The coordinate to check.
NB. x: The dimensions of the map.
valid =: [: */"1 > *. (_1 _1) < ]
clean =: valid"1 # ]

data =: parse freads '12.txt'
map =: translate data
coords =: ;/ coordinates map
ncoords =: ((($map)&clean)@:all_neighbor_coordinates) each coords
graph =: coords ,. ncoords

curr =: [ {~ {. @: ]
neigh =: [ {~ ;/@:>@:{:@:]
allowed_steps =: <: i. 27
reachable =: allowed_steps e.~ curr - neigh

filter_reachable =: {.@:] , [: < reachable # {:@:>@:]

NB. A graph represented by an adjacency matrix.
graph =: map filter_reachable"2 1 graph


NB. Priority queue implementation
NB. Initialize the priority queue.
NB. x the index of the key to prioritize against
NB. y The initial items and priorities as a list lists of boxed values.
pq_init =: ; <@:]

pq_key_ =: > @: {.
pq_val_ =: > @: {:
pq_keys =: pq_key_ { |: @: pq_val_
pq_items =: {: @: |: @: pq_val_
pq_sort =: pq_key_ ; < @: (/: @: pq_keys { pq_val_)

pq_head =: {. @: pq_val_
pq_pop =: pq_key_ ; < @: }. @: pq_val_

NB. Not sure why I have to add Fix to this.
NB. They should be equivalent, but they're erroring out.
pq_ind_val_ =: (pq_items @: ] i. {:@:[) f.
pq_set =: {{(pq_key_ y) ; < x (x pq_ind_val_ y) } pq_val_ y }}
NB. q =: 0 pq_init (0 ; 'a') , (5 ; 'b') ,: (2 ; 'c')

NB. x: The graph
NB. y: The initial index and end index
djikstra =: 4 : 0
  NB. The index of the given index (boxed)
  graph_index =. ({. |: x)&i.

  NB. y The index, boxed.
  NB. returns: a list of boxed indices
  neighbors =. x&(<"1 @: > @: {: @: (graph_index@:] { [))

  start =. {. y
  end =. {: y
  end_index =. ({. |: x) i. end
  NB. The distance to each node.  The index into dist matches the index
  NB. of the node in the graph.
  dist =. (# x) $ _
  dist =. 0 (graph_index start) } dist

  NB. A "priority queue".  This implementation is just the index of
  NB. the node in the graph, and the score.  The queue is manually
  NB. sorted after each round.
  Q =. 0 pq_init (<@:_: ,. {.@:|: ) x
  Q =. pq_sort (0 ; start) pq_set Q

  while. 0 < # pq_items Q do.
    'priority min_item' =. pq_head Q
    Q =. pq_pop Q
    min_item_score =. (graph_index <min_item) { dist

    for_neighbor. neighbors < min_item do.
      curr_score =. (graph_index neighbor) { dist
      NB. The weight is always 1.
      alt_score =. >: min_item_score
      if. alt_score < curr_score do.
        dist =. alt_score (graph_index neighbor) } dist
        Q =. (alt_score ; neighbor) pq_set Q
      end.
    end.
    Q =. pq_sort Q
  end.
  (graph_index end) { dist
)

NB. answer =: graph djikstra (get_start data) ; get_end data

answer2 =: 3 : 0
  starts =. 0 $ 0
  for_coord. coords do.
    if. 0 = map curr coord do.
      starts =. starts , coord
    end.
  end.
  starts

  end =. get_end data
  dist =. 0 $ 0
  for_start. starts do.
    dist =. dist , graph djikstra start , < end
  end.
  {. starts /: dist
)

NB. stdout (LF&,) ": answer2 ''
NB. 26 0
answer2 =: graph djikstra (26 0) ; get_end data
stdout (,&LF) ": answer2
exit 0
