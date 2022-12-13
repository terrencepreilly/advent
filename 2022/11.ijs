cocurrent 'monkey'

create =: {{
  items =: ". > 1 { y
  ". 'operation =: ' , > 2 { y
  ". 'test =: 0 = ' , > 3 { y
  divisor =: ". }: }: > 3 { y
  next =: ". > 4 { y
  inspected =: 0
}}

destroy =: codestroy

cocurrent 'base'


parse =: 3 : 0
  monkeys =. 0$0
  for_monkey. _5 [\ y do.
    m =. conew 'monkey'
    create__m monkey
    monkeys =. monkeys , m
  end.
  monkeys
)

divs =: 2 3 5 7 11 29 31 37 41 43 47 53 59 61 67 71

NB. x is the monkey who is taking a turn.
NB. y is all of the monkeys.
turn =: 4 : 0
  for_item. items__x do.
    NB. New worry level as monkey inspects item.
    new_item =. operation__x item
    NB. Monkey gets bored.
    NB. new_item =. <. new_item % 3

    for_d. divs do.
      if. 0 = d | new_item do.
        new_item =. new_item % d
      end.
    end.

    new_owner_index =. (next__x @. test__x) new_item
    nowner =. new_owner_index { y
    items__nowner =: items__nowner , new_item
    inspected__x =: >: inspected__x
  end.
  items__x =: 0 $ 0
)

NB. y is the array of monkeys
round =: 3 : 0
  for_monkey. y do.
    monkey turn y
  end.
)

get_inspected =: 3 : 0
  m =: y
  inspected__m
)

answer =: 3 : 0
  for_m. i. 20 do.
    round y
  end.
  */ 2 {. \:~ get_inspected"0 y
)

NB. data =: LF cut freads '11.txt'
NB. monkeys =: parse data
data =: LF cut freads '11_2.txt'
monkeys =: parse data
NB. stdout (,&LF) ": answer monkeys
NB. exit 0


NB. Can we remove all prime numbers not among the prime numbers being tested
NB. When a monkey decides who to throw to?
NB.
NB. I don't think so.  We can't because some of the operations are addition.
NB. For example, monkey 6 has the operation +&1.  For some number n,
NB. if we were to remove non-tested prime divisors, and create m
NB. like  m =: */ (q: n) -. {{ divisor__y }}"0 monkeys
NB. Then (q: n) = (q: m) is false, and so the tests won't be the same after
NB. that operation.  (Take, for example, n = 31, which is prime.  q: 31 = 31,
NB. and q: (31 + 2) = 5 # 2.)

NB. Another approach could be to simply store the numbers in a list.
NB. For example, instead of storing 98 * 13, we could store (q: 98) , 13.
NB. We could keep the numbers sorted.  Then divisibility is just a matter
NB. checking for presence in the list.
NB.
NB. But, again, addition ruins it, since we would have to recalculate the primes
NB. every time.

NB. Could we construct a graph?  Maybe the items only go to the addition monkeys
NB. in certain cycles, and we could simplify the items not going there?  But no,
NB. each node in the graph has two inputs and two outputs, and there are no strongly
NB. connected components.


NB. TODO: Evaluate
NB. But look at the monkeys which are doing addition.  They perform their check
NB. after performing that addition.  We could probably determine numbers for which
NB. that check is true, even after removing primes.
NB.
NB.         Addition                     Mult.           Power
NB.         +&4   +&8   +&5  +&1 +&3     *&13  *&11      *:
NB.         17&|  13&|  2&|  3&| 7&|     11&|  5&|       19&|
NB.
NB. Find a divisor, d, such that, for all n and some c among the primes above,
NB. ((n / d) | c) = (n | c)
NB.
NB. Doesn't look like there is one, following the below script.
NB.
NB. f =: (+&4)`(+&8)`(+&5)`(+&1)`(+&3)`(*&13)`(*&11)`*:
NB. g =: (17&|)`(13&|)`(2&|)`(3&|)`(7&|)`(11&|)`(5&|)`(19&|)
NB.
NB. test =: 4 : 0
NB.   res =. 0 $ 0
NB.   for_mut. i. # f do.
NB.     n =. (f @. mut) x
NB.     normal =. (g @. mut) n
NB.     div =. (g @. mut) (<. n % y)
NB.     res =. res , normal = div
NB.   end.
NB.   res
NB. )
NB.
NB. find_number =: 4 : 0
NB.   primes =. p: i. y
NB.   found =. primes
NB.   for_i. i. x do.
NB.     next =. ((*./"1) _8 [\ i test primes) # primes
NB.     NB. stdout (": next) , LF
NB.     found =. found ([ -. -.) next
NB.   end.
NB.   found
NB. )

NB. It's possible there are cycles in how numbers arrive at a monkey.  If that
NB. exists, we could probably determine it by examining the conditions and using
NB. some logic.  But it's probably easier to just see where the items go.
NB.
NB. clean_out =: 4 : 0
NB.   n =: ({. x) { y
NB.   existing =: ({: x) { items__n
NB.   for_m. y do.
NB.     items__m =: 0 $ 0
NB.   end.
NB.   items__n =: existing
NB. )
NB.
NB. location =: 3 : 0
NB.   I. -. (< 0$0) = <@: {{ items__y }}"0 y
NB. )
NB.
NB. run_for_pattern =: 4 : 0
NB.   pattern =. 0 $ 0
NB.   for_i. i. x do.
NB.     round y
NB.     pattern =. pattern , location y
NB.   end.
NB.   pattern
NB. )
NB.
NB. Its seems like there may be a cycle happening.  A lot of the numbers which start
NB. at monkey 0 start visiting 3 1 and 0.  The problem is that I can't follow the
NB. pattern for long enough.

NB. Maybe there's a pattern I can follow for how many items a monkey handles in a
NB. round?  The numbers grow very consistently in the example run.
NB.
NB. delta =: 4 : 0
NB.   insp =: 0 $ 0
NB.   for_i. i. x do.
NB.     round y
NB.     insp =: insp , get_inspected"0 y
NB.   end.
NB.   (- # y) ]\ insp
NB. )
NB.
NB. Doesn't appear so.

NB.  How about the representation of the worry level?  Since the multiplications
NB. are always of the same values, we could represent it as an array of that length.
NB.
NB.         Addition                     Mult.           Power
NB.         +&4   +&8   +&5  +&1 +&3     *&13  *&11      *:
NB.         17&|  13&|  2&|  3&| 7&|     11&|  5&|       19&|
NB.
NB. So, for example, our worry level could be represented as an array that looks
NB. like
NB.
NB.     98 = */ 2 7 7
NB.
NB.            0          7
NB.     2 7 7 -> 2 7 7 13 -> 2 7 7 13
NB.     1 1 1    1 1 1  1    1 1 1 1  | 4
NB.
NB. Ah, but checking for divisibility will require actually adding the value to
NB. that multiplied amount.  So that doesn't work.
