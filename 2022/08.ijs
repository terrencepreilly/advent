parse =: {{ >> ". L:0 ;/ each LF cut y }}
data =: parse fread '08.txt'


visible_at =: *./@({ > {.)"0 1
NB. Whether it's visible from the left. (Excludes leftmost tree.)
visible =: {{ 1 ,. > ((}. i. # y)&visible_at) each ;/ y }}

fl =: 1 : 'u'
fa =: &.|:
fr =: 1 : '(|."1) @: u @: (|."1)'
fb =: &.(|: @: |.)
all_visible =: visible fl +. visible fa +. visible fr +. visible fb
answer1 =: +/ +/ all_visible data


NB. The locations of trees to check.
index_to_check =: }: @: }. @: i. @: #
indices =: > , { (index_to_check ; index_to_check) data

get_at =: <@:[ { ]

NB. Get the trees surrounding an index.
get_dirs =: 3 : 0
  row =. {. y
  col =. {: y
  left =. |. col {. row { data
  right =. (>: col) }. row { data
  above =. |. row {. col { |: data
  below =. (>: row) }. col { |: data
  NB. Take each of the directions
  dirs =. left ; right ; above ; below
  NB. consider only ascending sequences
  dirs =. >./\ each dirs
  NB. only need to consider unique numbers, now
  NB. dirs =. ~. each dirs
  dirs
)

NB. Get the score in this direction.
NB. y: The trees, monotonically increasing (that is, >./\)
NB. x: The height of the current tree under consideration.
score_at_dir =: >: @: # @: }. @: (|.!.1 @: > # ])

NB. Calculate the overall at that location.
NB. y: The map of trees
NB. x: The index whose score we want.
score =: */ @: > @: (get_at score_at_dir each get_dirs@:[)

answer2 =: >./ indices (score"1 2) data

stdout (,&LF) ": answer1, answer2
exit 0
