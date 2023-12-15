data ← > •FLines "/dev/stdin"

# Remove spaces
StripLeft ← (+´ ∘ (0⊸=) ∘ (+`) ∘ ¬ ∘ (' '⊸=))⊸↓
Strip ← StripLeft StripLeft⌾⌽

RemoveCard ← 2⊸↓ (+` ∘ (':'⊸=))⊸/
GetWinning ← Strip (¬ ∘ (+`) ∘ ('|'⊸=))⊸/

# Remove double 1s from a mask. This ensures we won't have extra spaces.
# (Which would lead to empty lists when we group.)
DoubleMask ← ∧⟜((¬∘∧´˘)∘(2⊸↕) ∾ ¯1 ⊑ ⊢)

GetNumbers ← •ParseFloat¨ (¬∘(' '⊸=) / +`∘DoubleMask∘(' '⊸=)) ⊔ ¬∘(' '⊸=)⊸/
GetPresentNumbers ← Strip ∘ (2⊸↓)  (+` ∘ ('|'⊸=))⊸/
ParseScratchCard ← GetNumbers¨ ∘ (GetWinning⋈GetPresentNumbers) ∘ RemoveCard

Score ← ≤⟜0◶(2⊸⋆(-⟜1))‿0

ScoreCard ← Score∘(+´)∘(⊑ ∊ 1⊸⊑)∘ParseScratchCard
Solution ← +´ ScoreCard˘

# •Show Solution data


CountWins ← (+´)∘(⊑ ∊ 1⊸⊑)∘ParseScratchCard
InitTotal ← ⍉ (2‿∘⊸⥊ (⥊⟜1∘≠) ∾ CountWins˘)
StepCard ← {
  reps‿n ← ⊏ 𝕩
  Inc ← reps⊸+⌾(n ↑ 1 ↓ ⊏∘⍉)
  Inc 𝕩
}
ScoreCard2 ← {
  1 ≥ ≠ 𝕩 ? 𝕩 ;
  s ← StepCard 𝕩
  (1 ↑ s) ∾ (𝕊 (1 ↓ s))
}
Solution2 ← { +´ ⊏ ⍉ ScoreCard2 InitTotal 𝕩 }

•Show Solution2 data
