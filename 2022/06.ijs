data =: dltbs freads '06.txt'


diff =: (4 = #@:~.)"1
answer  =: 4 + {. I. diff 4 [\/ data

answer2  =: 14 + 14 i.~ > #@:~. each ;/ 14 [\/ data
