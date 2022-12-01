require 'common.ijs'

convert =: '1'&=
get_input =: {{ > convert each read_lines y }}

ones =: +/"1 @: |:
zeros =: # - ones
most_common =: ones >: zeros
gamma =: most_common
power =: #. @: gamma * #. @: -. @: gamma

NB. power get_input 'input_03.txt'
