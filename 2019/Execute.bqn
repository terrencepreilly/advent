# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
#     Unless required by applicable law or agreed to in writing, software
#     distributed under the License is distributed on an "AS IS" BASIS,
#     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#     See the License for the specific language governing permissions and
#     limitations under the License.

# ANSII Escape codes for colors.
red ← (27 + @) ∾ "[31m"
green ← (27 + @) ∾ "[32m"
clr ← (27 + @) ∾ "[0m"
qt ← """"
prefix ← "    "

ExecuteTests ← {
  ExecuteSingleTest ← {
    title‿successes‿failures ← •Import∘(∾⟜".bqn") 𝕩
      < title‿successes‿failures
  }
  ExecuteSingleTest¨ 𝕩
}

ReportSingleSuccess ← {
  •Out ∾ prefix‿green‿𝕩‿" Passed"‿clr
}
ReportSingleFailure ← {
  •Out ∾ prefix‿red‿𝕩‿" Failed"‿clr
}
ReportAllPass ← {𝕤
  •Out ∾ green‿"All Passed!"‿clr
}
Report ← {𝕤
  title‿successes‿failures ← ⊑ 𝕩
  ReportSingleSuccess¨ successes

  # We only want to report a single failure, if there is one.
  # That way, users can focus on the next step, only.
  failure ← (0 < ≠)◶⟨⟩‿(1⊸↑) failures
  ReportSingleFailure¨ failure
}

{ 𝕤 ⋄
 reports ← ExecuteTests 𝕩

 HasFailure ← (0 < ≠)∘(2⊸⊑)∘⊑¨
 filesPassed‿filesWithFailures← (∨´ ∘ HasFailure)◶(reports‿⟨⟩)‿(HasFailure ⊔ ⊢) reports

 Report¨ filesPassed
 ((0 = ≠)◶(Report∘⊑)‿ReportAllPass) filesWithFailures
} ⟨
  "day01"
⟩
