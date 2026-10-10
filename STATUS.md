---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Crystal Ball
packageId:    nelim.crystalball
repo:         Rimworld-Crystal-Ball
remote:       https://github.com/vbardales/Rimworld-Crystal-Ball.git
local_path:   C:\Users\nelim\Documents\rimworld\CrystalBall
visibility:   public
detached:     yes
workflow_stage: followUp[1.0.1]
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    1.0.1 (published 2026-10-08), played in game through Pickle 2026-10-08 and 2026-10-09: French `68c7` and English `8acb` green (12 of 12 played, the 4 `workshop` captures skipped there); `sanctuary` `c525` 15 of 16, the four captures green, the save scenario red outside the scope of that pass (accepted by Virginie 2026-10-09, played green in the two minimal passes). Older runs: `docs/runs/README.md`.
workshop:     3806709786
published_on: 2026-10-08, version 1.0.1 by the publish workflow (run 37839600085, SHA c090e2fa7a1cb64e7a19416e43e2e5443c0a333d, dry-run 37839358655), tag v1.0.1 and GitHub release by the CI. First publication 2026-09-26 (1.0.0, SHA 7d64a56491d7f131ec5770342f65875d993f8279), made public by Virginie the same day; gallery and subscriptions are hers, by hand.
remaining: []
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 302e6d8593e3ae17bc191c3823819bbd5a033cfc
publication_changelog_review_sha: 6625b154c312ed5a8356cf6d6388b1496d41923a
updated:      2026-10-10
protocols_read_sha: 06263cb0d19e6e3cf21e0145cad5ce348d9a4a69
---


# Crystal Ball — status (2026-10-10)

**`workflow_stage: followUp[1.0.1]`.** Version `1.0.1` is public on Steam (item 3806709786) and its post-publication
non-regression is green. The dated sections that used to live here are one line each in `docs/runs/status-journal.md`
(AUDIT.md 14.c); the full text is in git.

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 25 of 25 and 11 of 11 | `scripts/Run-Tests.ps1`, `scripts/Run-Functional-Tests.ps1` |
| Pickle, non-regression of `1.0.1` | French `68c7` and English `8acb` green; `sanctuary` `c525` 15 of 16 (save scenario accepted) | `docs/runs/README.md`, `TESTING.md` |
| Thank-you comments | None to post: Pickle and RimLogging already `posted` in the global register, Ludeon has no page | `PUBLICATION.md` section 4, `WORKSHOP_COMMENTS.md` |
| Gallery | `0-preview`, `1-the-ball-by-day`, `2-a-colonist-gazing`, `3-the-ball-glowing-in-the-dark`, qualified and uploaded by Virginie | `Art/Gallery/`, `PUBLICATION.md` |
| French | Validated by Virginie, `FRENCH_REVIEW.md` at `17678e8` | `FRENCH_REVIEW.md` |
| Reviews | `code_review_sha` `302e6d8`, all findings fixed or closed; `publication_changelog_review_sha` `6625b15` | front matter |
| Ideas not started | A stronger night glow, for a later patch | `BACKLOG.md` |

`git diff v1.0.1..HEAD -- Mod` is empty: no `1.0.2` material. A next patch reopens the chain at `code[1.0.2]`.

## Repository identity

Git root `C:\Users\nelim\Documents\rimworld\CrystalBall`, own `.git`, no superproject, origin `vbardales/Rimworld-Crystal-Ball`
(public). Title **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**, presented as an original mod; no
continuation suffix. No upstream repository, so no pull request is owed.

## Licence

**MIT**, copyright (c) 2026 Nelim, in `LICENSE` and `Mod/LICENSE`. `licence: original` is the catalogue's provenance
category. Credits: defs and code made with Claude Code; the texture generated with an AI image model, cut out, outlined
and resized under human direction (`ATTRIBUTION.md`); the preview by Virginie. No game assembly or third-party mod code is
shipped.

## Translation audit

French lives in `Mod/Languages/French/DefInjected/` only (`ThingDef/CrystalBall.xml`, `JobDef/CrystalBall.xml`,
`JoyKindDef/CrystalBall.xml`); no Keyed file, no pawn token, no agreement left (the description was reworded with none).
English is the Def source text. Virginie validated the French (`FRENCH_REVIEW.md`, revision `17678e8`, `devant elle`
wording, 2026-10-08).

## Clean-up record (2026-10-10)

`STATUS.md` folded (this commit). Branches: only `main` (14.d done). Still open before `dormant` (14.c): `TESTING.md`
(23 KB, old-revision sections to fold into `docs/runs/`, vocabulary "What `tested` requires" to update), and the WSL
clean-up: `Tests/Pickle/wsl-deps.sanctuary.map` stages optional Workshop items (facial animation set, body variants, eye
genes), to remove under the machine lock once no ticket of this mod is left and no other mod's map names them.
