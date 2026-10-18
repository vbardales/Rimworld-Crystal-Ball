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
workflow_stage: settings[1.1.0]
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
remaining: ["1.7 diagnostic ticket 75fc (PathProbe v2, Jet drafted, 4 and 16 cells) pending; bf2b was a defective scenario (Jet undrafted, AI gave HaulToCell), no pathing verdict. 1.7 session (local_88a251c4) sends verdict at RUN_DONE of 75fc. Decides whether the 0 of 5 of 7a63 is the mod or Pickle#63; then replay the 5 red scenarios alone, waiting in ticks not real seconds, colonists drafted"]
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 302e6d8593e3ae17bc191c3823819bbd5a033cfc
publication_changelog_review_sha: 6625b154c312ed5a8356cf6d6388b1496d41923a
echo_review_sha: bac147eac58e4e46d69cc428796f2c508282265f
updated:      2026-10-18
protocols_read_sha: b7ed0bd92ef9c1a1a5c74fa52332110b024377dd
---
# Crystal Ball: status (2026-10-10)

**`workflow_stage: declareDependencies[1.1.0]`** (stage walked one by one from `code`, 2026-10-18, owner request: nothing coded for 1.1.0, `Mod/` unchanged since `v1.0.1` but the Preview; 3.a to 3.c checked: no feature open, no assembly, `[Unreleased]` present) (minor bump for RimWorld 1.7 line; no `1.7` in `supportedVersions` before green 1.7 run; `tested_1_7` not recorded yet). Version `1.0.1` public on Steam (item 3806709786), post-publication
non-regression green. Dated sections that used to live here now one line each in `docs/runs/status-journal.md`
(AUDIT.md 14.c); full text in git.

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 22 of 22 and 11 of 11 | `scripts/Run-Tests.ps1`, `scripts/Run-Functional-Tests.ps1` |
| Pickle, non-regression of `1.0.1` | French `68c7` and English `8acb` green; `sanctuary` `c525` 15 of 16 (save scenario accepted) | `docs/runs/README.md`, `TESTING.md` |
| Thank-you comments | None to post: Pickle and RimLogging already `posted` in global register, Ludeon no page | `PUBLICATION.md` section 4, `WORKSHOP_COMMENTS.md` |
| Gallery | `0-preview`, `1-the-ball-by-day`, `2-a-colonist-gazing`, `3-the-ball-glowing-in-the-dark`, qualified and uploaded by Virginie | `Art/Gallery/`, `PUBLICATION.md` |
| French | Validated by Virginie, `FRENCH_REVIEW.md` at `17678e8` | `FRENCH_REVIEW.md` |
| Reviews | `code_review_sha` `302e6d8`, all findings fixed or closed; `publication_changelog_review_sha` `6625b15` | front matter |
| Ideas not started | Stronger night glow, for later patch | `BACKLOG.md` |

`git diff v1.0.1..HEAD -- Mod` shows only `Mod/About/Preview.png` (echo redrawn, `bac147e`): no def, text or code change. `CHANGELOG.md` carries it under `## [Unreleased]` for `1.1.0`.

## Repository identity

Git root `C:\Users\nelim\Documents\rimworld\CrystalBall`, own `.git`, no superproject, origin `vbardales/Rimworld-Crystal-Ball`
(public). Title **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**, presented as original mod; no
continuation suffix. No upstream repository, so no pull request owed.

## Licence

**MIT**, copyright (c) 2026 Nelim, in `LICENSE` and `Mod/LICENSE`. `licence: original` is catalogue provenance
category. Credits: defs and code made with Claude Code; texture generated with AI image model, cut out, outlined
and resized under human direction (`ATTRIBUTION.md`); preview by Virginie. No game assembly or third-party mod code
shipped.

## Translation audit

French lives in `Mod/Languages/French/DefInjected/` only (`ThingDef/CrystalBall.xml`, `JobDef/CrystalBall.xml`,
`JoyKindDef/CrystalBall.xml`); no Keyed file, no pawn token, no agreement left (description reworded with none).
English is Def source text. Virginie validated French (`FRENCH_REVIEW.md`, revision `17678e8`, `devant elle`
wording, 2026-10-08).

## Clean-up record (2026-10-10)

`STATUS.md` and `TESTING.md` folded (14.c): `TESTING.md` now carries current revision only. Branches: only `main` (14.d done).
**WSL clean-up (14.c), 2026-10-10: nothing removed.** The 12 Workshop items of `Tests/Pickle/wsl-deps.sanctuary.map`
(1635901197, 2581693737, 2816938779, 2889716301, 2986402536, 3255379190, 3527486510, 3745223213, 3753978140, 3790129900,
3798082132, 3799726535) each named by `wsl-deps*.map` of other mods (A Certain Series, A Perfect Mind, Adaptive
Storage, Ancient Buildings, Fieldwork Companions, Megabees and others), so all stay. None in `~/workshop-cache`
for this mod alone; machine lock not needed (read-only check; lock held by Work Studio run).

## Audit 2026-10-11 (revision `eb8d334` plus the working tree of this commit)

Retained: **`dormant`** (`followUp[1.0.1]` closed 2026-10-10, nothing reopened). No step went back.

- Offline suites replayed today: `scripts/Run-Tests.ps1` 22 of 22 (was 25: six generic tests moved to shared `Check-ModBasics`, `Check-DefInjected` and `Check-Translations`, now called as three tests), `scripts/Run-Functional-Tests.ps1` 11 of 11; both now dot-source `scripts/lib/TestRunner.ps1` and `GameReflection.ps1`. Step project builds with 0 errors (`dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`). Local `Tests/Pickle/Check-Steps.ps1` could not run here (looked for `CucumberExpressions.dll` in root of Windows Pickle install); deleted on Audit session verdict, shared `scripts/Check-Steps.ps1 -ModRoot .` exits 0 (26 patterns compile, 215 step lines resolve to exactly one expression; one unused step, `a crystal ball {string} stands on open ground near ({int}, {int})`). It flagged `05` and `07` for using CameraZoom, StageDecor and ColonistRace steps without `@requires`: added, so those two features skip in pass that does not stage them. No game launched.
- Shipped content: `Mod/` has defs, French DefInjected, one texture, no assembly; `git diff v1.0.1..HEAD -- Mod` empty; `Mod/About/Preview.png` byte-identical to `Art/Gallery/0-preview.png` (sha256 `56f01ec6...`); `LICENSE` and `ATTRIBUTION.md` identical in root and `Mod/`; `About.xml` description ends with `Source code on GitHub` line; GitHub `og:image` points to custom repository image; `Mod/desktop.ini` ignored, no `.ico` or `.dds` tracked.
- Protocols reread after they moved (06263cb0 to HEAD): new rules applied: no em dash in repository text (fixed in `README.md`, `TESTING.md`, `STATUS.md`, `docs/runs/README.md`; left alone: `CHANGELOG.md` append-only, `ATTRIBUTION.md` with `Mod/` copy, shipped, so change would touch `Mod/`); intermediates folder `build/` instead of `.build/` (`Tests/Pickle/build/`, `Directory.Build.props`, `.gitignore`, `Tests/Pickle/README.md`); `echo_review_sha` replaces `echo_review`.
- Echo review (AUDIT.md 10.a): `Art/echo.png` (line art of claw-footed sphere) shows ball gallery shows; keep. Validated at `eb8d334`, gallery and echo unchanged since.
- Not applicable, unchanged: `settings_audit` (no option, no page, no shortcut), dependencies (none, `loadAfter` names game only), DLC (proved offline), adoption clause present (public mod).
- Open, not a defect: none. Empty `## [Unreleased]` heading removed from `CHANGELOG.md` (Check-Status: none may stay on top from `publish` on); next patch adds it back at `code[1.0.2]`.

## Echo review (2026-10-15)

Virginie redrew `Art/echo-source.png` by hand (2026-10-14): faceted violet sphere, claws and crystal point, as gallery shows (old one carried cracks gallery does not show). Kept and validated by Virginie at `bac147e`; Preview, `0-preview.png` and `Preview.ico` regenerated in that commit (echo shows smaller than before, accepted). `echo_review_sha` set to it.

## RimWorld 1.7 diagnostic (2026-10-16)

`tested_1_7` not recorded. First 1.7 run `2e1e` (English, `Tests/Pickle/Evidence/p17-cb-english-1016-0426`): 7 of 16 passed, 5 failed, 4 skipped (`docs/runs/README.md`). Failures: pawns not arriving within 90 s (same scenarios take about 10 s on 1.6) and save scenario already red at `c525`; no mod exception in log, cause not established. Ticket `7a63` (`RUN_DONE` exit 1, `p17-cb-red5-1016`): 0 of 5 passed, same 5 red. Build: blueprint still waiting for material after 283 s. Gaze scenarios: job `CB_GazeIntoCrystalBall` runs, pawn still moving toward ball after 90 s. Save: `TryGiveJob returned no job`, as at `c525`. No mod exception; cause not established, pawns slow on 1.7 (Pickle#63, game speed or pathing: not checked here). `Mod/` and `Tests/` free to change again. Checked 2026-10-16: scenarios load Pickle's shared fixture `test-colony.rws` (gameVersion 1.6.4633; log `Loaded file (Map) is from version 1.6.4633`), not a mod file. Audit knows no green walking or hauling scenario on 1.7: the green p17- tickets are load, defs, language and restart checks; DrumBathHygiene `9910` is green but its scenarios teleport the pawn onto the drum. So the cause may be Pickle#63 or 1.7 pathing, not this mod; not proven. Blocked: no walking scenario of this mod can be judged on 1.7 until a pawn walk is shown green elsewhere or the fixture is re-saved on 1.7 (Pickle side). `tested_1_7` stays unrecorded; no `1.7` in `supportedVersions`.

Open 2026-10-18: 1.7 diagnostic ticket `20261017-180855-702-bf2b` (PathProbe, filed by the `1.7` session, evidence `Tests/Pickle/Evidence/p17-pathprobe-1017b`, first try `16aa` stalled at startup): `Jet` ordered 16 cells east on `test-colony`, wait 900 ticks, assert a Human on the cell. Green: the 0 of 5 of `7a63` comes from the mod's joy path, not 1.7 pathing. Red: Pickle#63 or 1.7 pathing defect, `1.7` session gives the proof. Nothing is filed by CB until `RUN_DONE`.

## Stage walk 2026-10-18 (owner request, one stage at a time, nothing skipped)

- `code` to `declareDependencies`: 3.a no `feature` open; 3.b no assembly (`Mod/` has defs, French DefInjected, one texture); 3.c `[Unreleased]` says what 1.1.0 changes (Preview echo, 1.7 line). Done.
- `declareDependencies` to `settings` (revision `44658b4`): 4.a read `Mod/Defs/CrystalBall.xml` and `About.xml`: vanilla things only (`Jade`, `Gold`, `BuildingsJoy`, `JobDriver_SitFacingBuilding`, `JoyGiver_InteractBuildingSitAdjacent`), no mod reference, no `MayRequire`. 4.b `modDependencies` none, `loadAfter` names the game only, no `incompatibleWith`. 4.c no DLC reference in defs, no `LoadFolders.xml`, `supportedVersions` is `1.6` only. 4.d no cycle possible (no dependency). 4.e no patch. 4.f not an animal mod. Nothing changed since the 2026-10-11 audit. Done.
