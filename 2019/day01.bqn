# to find the fuel required for a module, take its mass, divide by three,
# round down, and subtract 2.
#
# For example:
#  - For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
#  - For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel
#    required is also 2.
#  - For a mass of 1969, the fuel required is 654.
#  - For a mass of 100756, the fuel required is 33583.


⟨TestSuite⟩ ← •Import "./Test.bqn"


# PROBLEM 1

# 𝕩: mass
CalculateFuel ← (-⟜2) ∘ ⌊ ∘ ÷⟜3
CalculateTotalFuel ← CalculateFuel +´

data ← •ParseFloat¨ •FLines "input01.txt"
•Out •Repr CalculateTotalFuel data

# PROBLEM 2

H ⇐ CalculateFuel∘⊑
T ⇐ (0 < H)◶⊢‿(H ∾ ⊢)
Cont ⇐ 0 < H∘⊑
CalcTotal ⇐ +´ (+´ ∘ (1 ↓ ⌽) ∘ { Cont 𝕩 ? 𝕊 T 𝕩; 𝕩 })¨

•Out •Repr CalcTotal data

# TESTS

# ts ← TestSuite "Day01"
#
# { 𝕤 ⋄ 2 = CalculateFuel 12 } ts._Test "1.1"
# { 𝕤 ⋄ 2 = CalculateFuel 14 } ts._Test "1.2"
# { 𝕤 ⋄ 654 = CalculateFuel 1969 } ts._Test "1.3"
# { 𝕤 ⋄ 33583 = CalculateFuel 100756 } ts._Test "1.4"
#
# { 𝕤 ⋄ 4 = CalcTotal ⟨12, 12⟩ } ts._Test "2.e2"
# { 𝕤 ⋄ 966 = CalcTotal ⟨1969⟩ } ts._Test "2.1"
# { 𝕤 ⋄ 50346 = CalcTotal ⟨100756⟩ } ts._Test "2.2"
# { 𝕤 ⋄ 957 = CalcTotal ⟨54, 1969 - 54⟩ } ts._Test "2.e1"
#
# ts.Report @
