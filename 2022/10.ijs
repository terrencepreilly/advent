
parse =: > @: (' '&cut each) @: (LF&cut)
convert =: ". each @:{:@:|:

data =: convert parse freads '10.txt'

NB. Initial approach -- replicate the CPU.
type =: 1&= +. 4 = 3 !: 0

in_range =: [ e. (_1 0 1) + #@:]

NB. x: The states to add the score of
NB. y: The instructions to execute.
execute =: 4 : 0
  regx =. 1
  states =. 1 $ 1
  instructions =. y
  crt =. ''
  while. # instructions do.
    inst =. > {. instructions
    if. (< 0$0) = {. instructions do.
      if. regx in_range crt do.
        crt =. crt , '#'
      else.
        crt =. crt , '.'
      end.
      if. 0 = 40 | # crt do.
        stdout crt , LF
        crt =. ''
      end.
      states =. states , regx
    else.
      NB. During first cycle
      if. regx in_range crt do.
        crt =. crt , '#'
      else.
        crt =. crt , '.'
      end.
      if. 0 = 40 | # crt do.
        stdout crt , LF
        crt =. ''
      end.
      states =. states , regx
      NB. During second cycle
      if. regx in_range crt do.
        crt =. crt , '#'
      else.
        crt =. crt , '.'
      end.
      if. 0 = 40 | # crt do.
        stdout crt , LF
        crt =. ''
      end.
      states =. states , regx
      NB. End second cycle
      regx =. regx + inst
    end.
    instructions =. }. instructions
  end.
  stdout crt, LF
  +/ x ([ * {) states
)

answer =: +/ 20 60 100 140 180 220 execute data
