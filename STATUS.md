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
workflow_stage: ecosystem[1.1.0]
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    1.0.1 (published 2026-10-08), played in game through Pickle 2026-10-08 and 2026-10-09: French `68c7` and English `8acb` green (12 of 12 played, the 4 `workshop` captures skipped there); `sanctuary` `c525` 15 of 16, the four captures green, the save scenario red outside the scope of that pass (accepted by Virginie 2026-10-09, played green in the two minimal passes). Older runs: `docs/runs/pickle.md`.
tested_1_7:   yes
workshop:     3806709786
published_on: 2026-10-08, version 1.0.1 by the publish workflow (run 37839600085, SHA c090e2fa7a1cb64e7a19416e43e2e5443c0a333d, dry-run 37839358655), tag v1.0.1 and GitHub release by the CI. First publication 2026-09-26 (1.0.0, SHA 7d64a56491d7f131ec5770342f65875d993f8279), made public by Virginie the same day; gallery and subscriptions are hers, by hand.
remaining: ["2.h done 2026-11-22: PiI delta, nothing new, ecosystem_line 1.1 written; replay 2026-11-22 (second) proposes code[1.1.0], not written, waits for Virginie's oui; 3.c open (no [Unreleased] in CHANGELOG.md)", "9.f gallery_validated_sha absent (rule 2026-11-20): needs Virginie's oui on the gallery, asked when the chain reaches shootGallery", "other missing records to check at replay: preview_source_decision (10.a bis), workshop_required_items (4.g, n/a: no dependency)", "replay 2026-11-22 stopped at 2.h; later sections not replayed"]
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 6a2012f9ad0e2e66a9e8a29ac42b80f1628a2d3a
publication_changelog_review_sha: 5c694993b743883d7b2098292d9b5ed3ab394738
echo_review_sha: f865d9e258c22504ad675ead07806f2893efd632
thanks_drafted_line: none
ecosystem_line: 1.1
social_preview_sha256: 342526c8c92ef6374e2ad75a1d26ace190e2d8352ec79f9352d40795e88a990c
updated:      2026-11-22
protocols_read_sha: 588afcca9786e7da139bf5e009dab6cd5de1ba13
---
# Crystal Ball: status (2026-11-22)

**`workflow_stage: ecosystem[1.1.0]`** (replay 2026-11-22: `ecosystem_line` missing, 2.h open; was `dormant[1.1.0]`). `1.1.0` public on Steam (item 3806709786, tag `v1.1.0`, SHA `e3412bd`), tags Mod, 1.6, 1.7, `tested_1_7: yes`. Non-regression 1.1.0 closed 2026-11-18: French `0365` 7 of 7, English `cef9` 121 of 129 with one red (build scenario, colonists on horseshoes), replayed alone `bc9b` green 1 of 1 (not a mod defect, `Mod/` unchanged).

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 12/12, 11/11 | `Tests/Rule-OwnValues.ps1`, `Tests/Rule-GameReflection.ps1` (via generated `Tests/Test-Mod.ps1`) |
| Pickle, non-regression `1.0.1` | French `68c7`, English `8acb` green; `sanctuary` `c525` 15/16 (save scenario accepted) | `docs/runs/pickle.md`, `TESTING.md` |
| Thank-you comments | None to post: 14 recipients (Pickle, RimLogging, 12 gallery mods) `posted`, Crystal Ball added to `Covers` 2026-11-18; Ludeon no page; `thanks_drafted_line: none` | `PUBLICATION.md` section 4, `WORKSHOP_COMMENTS.md` |
| Gallery | `0-preview`, `1-the-seer-arrives`, `2-a-colonist-gazing`, `3-the-ball-glowing-in-the-dark`, Virginie accepted 2026-11-18, subtitled | `Art/Gallery/`, `Art/Gallery-clean/`, `PUBLICATION.md` |
| Preview | New DALL-E key art from gallery, `panelBare`, validated 2026-11-18, sent as GitHub social preview (`social_preview_sha256`) | `Art/Preview.config.json`, `Mod/About/Preview.png` |
| French | Virginie validated; ChatGPT review round 1 clean (0 applied) | `TRANSLATION_REVIEW.md` |
| Reviews | `code_review_sha` `6a2012f` (no code commit since); `publication_changelog_review_sha` set 2026-11-18 (Virginie validated) | front matter |
| Ideas not started | Stronger night glow, later patch | `BACKLOG.md` |

`CHANGELOG.md` has Preview + gallery under `## [Unreleased]` for `1.1.0`; dated heading written at dry-run (12.e).

## Ecosystem (8.0, 2026-11-13, PiI, `docs/inventory/ecosystem-steam/CrystalBall.md`)

No duplicate, patch, retexture or translation of our mod. Sources: Steam (Chrome, per page) + corpus scan of 3 defNames, 2 labels (2 weak hits, 0 shared defName).

| packageId or Workshop id | Type | Last update | Note |
| --- | --- | --- | --- |
| 2137901315 (CrystalBall, The Pickles) | same name, other function | 2020 | pawns foresee incidents; not duplicate |
| 2483367722 (CrystalBall Continued, Mlie) | same name, other function | 1.6 | update of above; only title overlaps |
| 3603522660 (Pondering Orbs) | theme neighbour | 1.6 | palantiri orbs |

Study subscriptions all removed 2026-11-13. No licence read (page only).

Delta 2026-11-22 (PiI, same report, section "Delta 2026-11-22"): original work; no new neighbour found beyond CrystalBall (Continued), CrystalBall (The Pickles) and Pondering Orbs. No subscription made, links block and marks untouched.

## Repository identity

Git root `C:\Users\nelim\Documents\rimworld\CrystalBall`, own `.git`, no superproject, origin `vbardales/Rimworld-Crystal-Ball` (public). Title **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**, original mod; no continuation suffix. No upstream repo, no PR owed.

## Licence

**MIT**, copyright (c) 2026 Nelim, in `LICENSE` and `Mod/LICENSE`. `licence: original` = catalogue provenance category. Credits: defs + code by Claude Code; texture AI-generated, cut out, outlined, resized under human direction (`ATTRIBUTION.md`); preview by Virginie. No game assembly or third-party mod code shipped.

## Translation audit

French only in `Mod/Languages/French/DefInjected/` (`ThingDef`, `JobDef`, `JoyKindDef`); no Keyed, no pawn token. English = Def source text. French validated by Virginie at `876a481` (2026-11-17, after ChatGPT review round 3 clean); `TRANSLATION_REVIEW.md` current. One taste rejection kept: `than when they sat down` in the English description.

## Gallery and NSB

Gallery of 1.1.0: three pictures in the hut (`hut`, Nelim of NSB, hairstyle `Roo_HD_Hair_Highpony`, canon eyes, tan robe, violet cape at 23:00), shotlist and takes in git history of this file (commit `215a302` and before). Eye colour and colonist properties: no change without Virginie. Mod adds no animal.
