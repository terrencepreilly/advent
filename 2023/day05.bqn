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

ParseSeeds ← (GetNumbers∘Strip∘(6⊸↓))∘⊑

DiscardToEmpty ← {
  ⟨⟩ ≡ 𝕩 ? ⟨⟩ ;
  (⟨⟩≡⊑)◶(𝕊 ∘ (1⊸↓))‿(⊢) 𝕩
}
ParseMapName ← Strip∘(TakeTo⟜"map:")⌾(1⊸⊑) (SplitBy⟜"-to-")
ParseMapNumbers ← {
  ⟨⟩ ≡ 𝕩 ? ⟨⟩ ;
  (⟨⟩≡⊑)◶(⋈∘GetNumbers∘⊑ ∾ 𝕤∘(1⊸↓))‿(⟨⟩) 𝕩
}
ParseMap ← DiscardToEmpty ⋈˜ ParseMapName∘⊑ ⋈ >∘ParseMapNumbers∘(1⊸↓)

ParseMaps ← ∘‿2⊸⥊ ∘ {
  ⟨⟩ ≡ 𝕩 ? ⟨⟩ ;
  m‿rest ← ParseMap 𝕩
  m ∾ ((0 < ≠)◶(⟨⟩)‿(𝕊 1⊸↓)) rest
} ∘ (2⊸↓)

# Given a map of numbers, 𝕨, and a number 𝕩, find what number 𝕩 maps to.
# The map consists of lines, where each line has the format
#
#   <dest> <source> <length>.
#
# So, if source_n ≤ 𝕩 ≤ (source_n + length_n), then the result will be
# dest + 𝕩 - source_n.
Map ← {
  # If there are no values in the map, then the number maps to itself.
  0 = ≠ 𝕨 ? 𝕩 ;
  first ← ⊏ 𝕨
  dest‿source‿length ← first
  ((source⊸≤) ∧  (<⟜(source + length)))◶((1 ↓ 𝕨)⊸𝕊)‿(dest⊸+ ∘ (-⟜source)) 𝕩
}

# Given maps as 𝕨, and a seed 𝕩, get the location of the seed.
# (Assumes that the maps are ordered.  That is, each map is the source
# for the following map.)
GetLocationForSeed ← {
  0 = ≠ 𝕨 ? 𝕩 ;
  curr ← 1 ⊑ ⊏ 𝕨
  rest ← 1 ↓ 𝕨
  rest 𝕊 curr Map 𝕩
}

Solution ← {
  seeds ← ParseSeeds 𝕩
  maps ← ParseMaps 𝕩
  ⌊´ maps⊸GetLocationForSeed¨ seeds
}

# A naive solution.
Solution2 ← {
  seeds ← ParseSeeds 𝕩
  ExtractSeeds ← ∾ (< ⊑ + ↕ ∘ (1⊸⊑))˘
  seeds ↩ ExtractSeeds ∘‿2 ⥊ seeds
  maps ← ParseMaps 𝕩
  ⌊´ maps⊸GetLocationForSeed¨ seeds
}

•Show Solution2 data
