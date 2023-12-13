data ← > •FLines "/dev/stdin"

IsDigit ← '9'⊸≥ ∧ '0'⊸≤
IsSpace ← '.'⊸=
IsSymbol ← ¬ IsDigit ∨ IsSpace
SymbolIndex ← ∘‿2⊸⥊ ∘ ∾ ∘ ⥊ IsSymbol /¨ ↕∘≢

# Given a offset, returns a function which takes
# a map (𝕨) and an index (𝕩) and returns 0 if it's not a number.
_IsNumberAt ← { offset _op:
  InRangeL ← 0‿0 ≤ offset + ⊢
  InRangeU ← ≢∘⊣ > offset + ⊢
  InRange ← ∧´ InRangeL ∧ InRangeU
  CheckDigit ← IsDigit (offset + ⊢) ⊑ ⊣
  InRange◶⟨⟩‿(CheckDigit◶⟨⟩‿(offset + ⊢))
}

# While the number to the left of this is a digit, subtract one.
LeftRaw ← (0‿¯1 + ⊢)
Left ← (∧´ 0‿0 ≤ LeftRaw)◶⊢‿LeftRaw
StepCanonical ← (IsDigit ⊑˜⟜Left)◶⊢‿Left # (IsDigit∘⊑˜)
GetCanonical ← StepCanonical⍟100 # TODO: Replace with recursion
GetNumbers ← ∘‿2 ⥊ (0‿1 _IsNumberAt) ∾ (0‿¯1 _IsNumberAt) ∾ (1‿0 _IsNumberAt) ∾ (¯1‿0 _IsNumberAt) ∾ (1‿1 _IsNumberAt) ∾ (1‿¯1 _IsNumberAt) ∾ (¯1‿1 _IsNumberAt) ∾ (¯1‿¯1 _IsNumberAt)

# There must be a better way to do this?
GetStarting ← { ⍷ (𝕩⊸GetCanonical)¨ <˘ ∾ (𝕩⊸GetNumbers)¨ <˘ SymbolIndex 𝕩 }

GetLine ← (⊏˜⟜(⊑∘⊢))
TakeDigitPrefix ← •ParseFloat ∘ ⊑ ∘ ((+` ¬∘IsDigit)⊸⊔)
GetDigit ← TakeDigitPrefix (1⊸⊑∘⊢ ↓ GetLine)

Solution ← { +´ 𝕩⊸GetDigit¨ GetStarting 𝕩 }



GetSymbolIndices ← <˘∘SymbolIndex
IsAsterix ← '*' = GetSymbolIndices⊸⊑
GetAsterixIndices ← IsAsterix / GetSymbolIndices
FilterOverTwo ← (2 ≤ ≠¨ ) / ⊢

GetGearNumbers ← { 𝕤 ⋄
  indices ← GetAsterixIndices 𝕩
  numbers ← (𝕩⊸GetNumbers)¨ indices
  numbers ↩ (⍷ (𝕩⊸GetCanonical)¨ ∘ <˘)¨ numbers

  gearNumberIndices ← ((2 = ≠)¨ numbers) / numbers
  𝕩⊸GetDigit¨¨ gearNumberIndices
}

Solution2 ← +´ ×´¨ ∘ GetGearNumbers

•Out •Repr Solution2 data

# •Out •Repr Solution data
