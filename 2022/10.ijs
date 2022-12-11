
parse =: > @: (' '&cut each) @: (LF&cut)
convert =: ". each @:{:@:|:

data =: convert parse freads '10.txt'

NB. Initial approach -- replicate the CPU.
type =: 1&= +. 4 = 3 !: 0

NB. x: The states to add the score of
NB. y: The instructions to execute.
execute =: 4 : 0
  regx =. 1
  states =. 1 $ 1
  instructions =. y
  while. # instructions do.
    inst =. > {. instructions
    if. (< 0$0) = {. instructions do.
      states =. states , regx
    else.
      NB. During first cycle
      states =. states , regx
      NB. During second cycle
      states =. states , regx
      NB. End second cycle
      regx =. regx + inst
    end.
    instructions =. }. instructions
  end.
  +/ x ([ * {) states
)

answer =: +/ 20 60 100 140 180 220 execute data
