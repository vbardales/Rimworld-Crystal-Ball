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
workflow_stage: code[1.1.0]
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
echo_review_sha: bac147eac58e4e46d69cc428796f2c508282265f
updated:      2026-10-13
protocols_read_sha: 1ae53af82d9576a606e77280542ea4d52032c320
---


# Crystal Ball: status (2026-10-10)

**`workflow_stage: code[1.1.0]`** (minor bump for the RimWorld 1.7 line; no `1.7` in `supportedVersions` before a green 1.7 run; `tested_1_7` not recorded yet). Version `1.0.1` is public on Steam (item 3806709786) and its post-publication
non-regression is green. The dated sections that used to live here are one line each in `docs/runs/status-journal.md`
(AUDIT.md 14.c); the full text is in git.

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 22 of 22 and 11 of 11 | `scripts/Run-Tests.ps1`, `scripts/Run-Functional-Tests.ps1` |
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

`STATUS.md` and `TESTING.md` folded (14.c): `TESTING.md` now carries the current revision only. Branches: only `main` (14.d done).
**WSL clean-up (14.c), 2026-10-10: nothing removed.** The 12 Workshop items of `Tests/Pickle/wsl-deps.sanctuary.map`
(1635901197, 2581693737, 2816938779, 2889716301, 2986402536, 3255379190, 3527486510, 3745223213, 3753978140, 3790129900,
3798082132, 3799726535) are each named by the `wsl-deps*.map` of other mods (A Certain Series, A Perfect Mind, Adaptive
Storage, Ancient Buildings, Fieldwork Companions, Megabees and others), so all stay. None of them is in `~/workshop-cache`
for this mod alone; the machine lock was not needed (read-only check; the lock was held by a Work Studio run).

## Audit 2026-10-11 (revision `eb8d334` plus the working tree of this commit)

Retained: **`dormant`** (`followUp[1.0.1]` closed 2026-10-10, nothing reopened). No step went back.

- Offline suites replayed today: `scripts/Run-Tests.ps1` 22 of 22 (it was 25: six generic tests left for the shared `Check-ModBasics`, `Check-DefInjected` and `Check-Translations`, which it now calls as three tests), `scripts/Run-Functional-Tests.ps1` 11 of 11; both now dot-source `scripts/lib/TestRunner.ps1` and `GameReflection.ps1`. Step project builds with 0 errors (`dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`). The local `Tests/Pickle/Check-Steps.ps1` could not run here (it looked for `CucumberExpressions.dll` in the root of the Windows Pickle install); deleted on the Audit session's verdict, the shared `scripts/Check-Steps.ps1 -ModRoot .` exits 0 (26 patterns compile, 215 step lines resolve to exactly one expression; one unused step, `a crystal ball {string} stands on open ground near ({int}, {int})`). It flagged `05` and `07` for using CameraZoom, StageDecor and ColonistRace steps without `@requires`: added, so those two features skip in a pass that does not stage them. No game launched.
- Shipped content: `Mod/` has defs, French DefInjected, one texture, no assembly; `git diff v1.0.1..HEAD -- Mod` empty; `Mod/About/Preview.png` byte-identical to `Art/Gallery/0-preview.png` (sha256 `56f01ec6...`); `LICENSE` and `ATTRIBUTION.md` identical in root and `Mod/`; `About.xml` description ends with the `Source code on GitHub` line; GitHub `og:image` points to a custom repository image; `Mod/desktop.ini` is ignored, no `.ico` or `.dds` tracked.
- Protocols reread after they moved (06263cb0 to HEAD): new rules applied here: no em dash in repository text (fixed in `README.md`, `TESTING.md`, `STATUS.md`, `docs/runs/README.md`; left alone: `CHANGELOG.md` append-only, and `ATTRIBUTION.md` with its `Mod/` copy, shipped, so a change would touch `Mod/`); intermediates folder `build/` instead of `.build/` (`Tests/Pickle/build/`, `Directory.Build.props`, `.gitignore`, `Tests/Pickle/README.md`); `echo_review_sha` replaces `echo_review`.
- Echo review (AUDIT.md 10.a): `Art/echo.png` (line art of the claw-footed sphere) shows the ball the gallery shows; keep. Validated at `eb8d334`, gallery and echo unchanged since.
- Not applicable, unchanged: `settings_audit` (no option, no page, no shortcut), dependencies (none, `loadAfter` names the game only), DLC (proved offline), adoption clause present (public mod).
- Open, not a defect: none. Empty `## [Unreleased]` heading removed from `CHANGELOG.md` (Check-Status: none may stay on top from `publish` on); the next patch adds it back at `code[1.0.2]`.

## Echo review (2026-10-15)

Virginie redrew `Art/echo-source.png` by hand (2026-10-14): faceted violet sphere, claws and crystal point, as the gallery shows it (the old one carried cracks the gallery does not show). Kept and validated by Virginie at `bac147e`; Preview, `0-preview.png` and `Preview.ico` regenerated in that commit (the echo shows smaller than before, accepted). `echo_review_sha` set to it.
