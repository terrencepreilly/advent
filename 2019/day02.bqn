
⟨TestSuite⟩ ← •Import "./Test.bqn"


parse ⇐ {
  Clean ← ((','⊸= ⊑)◶⊢‿(1⊸↓))¨
  IParse ← +`∘(','⊸=) ⊔ ⊢
  •ParseFloat¨ ∘ Clean ∘ IParse
}

_op ← { pos f _𝕣 code :
  src1‿src2‿dest ← 3 ↑ (pos + 1) ↓ code

  res ← F´ src1‿src2 ⊏ code
  res⌾(dest⊸⊑) code
}

Add ⇐ + _op
Mult ⇐ × _op
Step ⇐ +⟜4

Run ⇐ {
  pos 𝕊 code : 99 = pos ⊑ code ?
    code;
  pos 𝕊 code : 1 = pos ⊑ code ?
     (4 + pos) 𝕊 pos Add code;
  pos 𝕊 code : 2 = pos ⊑ code ?
    (4 + pos) 𝕊 pos Mult code;
  ¯1
}

ParseAndRun ⇐ 0⊸Run ∘ Parse

ResetState ⇐ { noun‿verb 𝕊 code :  noun⌾(1⊸⊑) ∘ (verb⌾(2⊸⊑)) code }

data ⇐ 12‿2 ResetState Parse ¯1 ↓ •FChars "input02.txt"

# solution ⇐ 0 Run data
# •Out •Repr ⊑ solution


_applyRanges ← {
  (0 = ≠ 𝕨) ∧ (0 = ≠ 𝕩) ?
    𝕨 𝔽 𝕩 ;
  (0 = ≠ 𝕨) ?
    (𝕨 𝔽 ⊑ 𝕩) ∾ 𝕨 (𝕣 𝔽) (1 ↓ 𝕩) ;
  (𝕩 (𝕣 𝔽)˜ ⊑ 𝕨) ∾ 𝕩 (𝕣 𝔽)˜ (1 ↓ 𝕩)
}

ts ← TestSuite "Day02"

{ 𝕤 ⋄
  data ← "1,9,10,3,2,3,11,0,99,30,40,50"
  1‿9‿10‿3‿2‿3‿11‿0‿99‿30‿40‿50 ≡ Parse data
} ts._Test "1.e1 Parse"

{ 𝕤 ⋄
  ⟨1⟩ = Parse "1"
} ts._Test "1.e2 Simplest Parse"

{
  10‿4‿5‿0‿4‿6 ≡ 0 Add 1‿4‿5‿0‿4‿6
} ts._Test "1.e3 Add"

{
  24‿4‿5‿0‿4‿6 ≡ 0 Mult 2‿4‿5‿0‿4‿6
} ts._Test "1.e4 Mult"

{ 3500 = ⊑ ParseAndRun "1,9,10,3,2,3,11,0,99,30,40,50" } ts._Test "1.1"
{ 2 = ⊑ ParseAndRun "1,0,0,0,99" } ts._Test "1.2"
{ 6 = 3 ⊑ ParseAndRun "2,3,0,3,99" } ts._Test "1.3"
{ 9801 = ¯1 ⊑ ParseAndRun "2,4,4,5,99,0" } ts._Test "1.4"
{ 30 = ⊑ ParseAndRun "1,1,1,4,99,5,6,0,99" } ts._Test "1.5"

{ 4 = ⊑ ParseAndRun "1,4,4,0,1,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,1,4,0,0,99" } ts._Test "1.e5"


{
    F ← +
    4‿5‿5‿6 ≡ 1‿2 _applyRanges F 3‿4
} ts._Test "2.e1 Applying args"

ts.Report @
