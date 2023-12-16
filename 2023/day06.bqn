data ← •FLines "/dev/stdin"

# Remove spaces
StripLeft ← (+´ ∘ (0⊸=) ∘ (+`) ∘ ¬ ∘ (' '⊸=))⊸↓
Strip ← StripLeft StripLeft⌾⌽

# Remove double 1s from a mask. This ensures we won't have extra spaces.
# (Which would lead to empty lists when we group.)
DoubleMask ← ∧⟜((¬∘∧´˘)∘(2⊸↕) ∾ ¯1 ⊑ ⊢)
GetNumbers ← •ParseFloat¨ (¬∘(' '⊸=) / +`∘DoubleMask∘(' '⊸=)) ⊔ ¬∘(' '⊸=)⊸/

IndexOf ← ⊑ (⊢ / ↕∘≠)∘⍷˜
SplitBy ← (IndexOf ↑ ⊣) ⋈ ((≠∘⊢ + IndexOf) ↓ ⊣)
TakeTo ← IndexOf ↑ ⊣




"
When graphing the distance per time held we will have a graph like the following
(where ¨¨¨ depicts the best time.)

d |       .
i |     .˙ ˙.
s |    .     .
t | ¨¨.¨¨¨¨˘˘¨.¨¨
a |  .         .
n | .           .
c |__________________
e    Time held

We're always starting at zero, and if we hold it for the entire duration,
we'll travel zero.  We can find the apex.  Then, we can use binary search to
find where the best speed is on each side.
"
Parse ← (GetNumbers∘Strip∘(1⊸⊑)∘(SplitBy⟜':'))¨

# 𝕨 the duration of the race.
# 𝕩 the duration the button was held.
Score ← ⊢×-

_BinarySearch ← { data f _𝕣 lo‿hi‿needle:
  TerminatedSearch ← ≥
  Mid ← ⌊  ⊣ + (÷⟜2 -˜)
  Found ← needle = (⊑⟜data ∘ Mid)
  lo Found◶(0)‿Mid hi
}

•Show (↕10) ⊢ _BinarySearch 0‿9‿4

# •Show Parse data
