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
workflow_stage: shootGallery[1.1.0]
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    1.0.1 (published 2026-10-08), played in game through Pickle 2026-10-08 and 2026-10-09: French `68c7` and English `8acb` green (12 of 12 played, the 4 `workshop` captures skipped there); `sanctuary` `c525` 15 of 16, the four captures green, the save scenario red outside the scope of that pass (accepted by Virginie 2026-10-09, played green in the two minimal passes). Older runs: `docs/runs/README.md`.
tested_1_7:   yes
workshop:     3806709786
published_on: 2026-10-08, version 1.0.1 by the publish workflow (run 37839600085, SHA c090e2fa7a1cb64e7a19416e43e2e5443c0a333d, dry-run 37839358655), tag v1.0.1 and GitHub release by the CI. First publication 2026-09-26 (1.0.0, SHA 7d64a56491d7f131ec5770342f65875d993f8279), made public by Virginie the same day; gallery and subscriptions are hers, by hand.
remaining: ["9.a open: take 2 (redo 8f8f) read 2026-11-17: pictures 1 and 3 green but j weak (ball 10 to 14 px at 268 px, picture 2 same), so ALL THREE REDO; zooms tightened to 3 (142,72), 3 (139,73), 2.2 (139,74), scene 1 advance 8 ticks (she stood seated at 20), old captures and Inbox runs removed, commit 92523db; take 3 ticket 696e green 3 of 3, read and scored 2026-11-17 at 268 px (ball about 23, 23, 33 px, j ok): picture 1 REDO (image 3, adequacy 2.5, understanding 3.5, decoration 3: she stands beside the ball in the top-left corner, not mid-stride, rose cut at the top edge, bare floor), picture 2 REDO (decoration 3.5, bare floor, two torches in frame, she stands), picture 3 candidate (4, 4, 4, 4; unlit torch not in frame); scenes 1 and 2 recomposed (2414adc), picture 3 clean original kept in Art/Gallery-clean, take 3 run deleted; take 4 ticket 029f green 2 of 2, read and scored 2026-11-17 (ball about 25 px at 268 px): picture 1 REDO (she stands at the far west edge beside the ball, not walking in from the east door, bare floor, no torch lit in frame; decoration 3, adequacy 2.5), picture 2 REDO (one torch only in frame, bare floor around, she stands, other torches not behind her; decoration 3.5, adequacy 3), run deleted; scenes 1 and 2 recomposed 508d52d (cause of the arrival: speed stayed ultrafast between steps, now paused before the walk, 40 + 6 ticks; zoom 3.0 on (143,74) with torch (143,76) lit; zoom 3.3 on (140,73), three torches; third sculpture (142,72)), take 5 ticket 00b0 green 2 of 2, read and scored 2026-11-17 at 268 px (ball about 24 px, j ok): picture 1 REDO (she is clipped by the east door frame at the right edge, small, ground mostly bare, one torch; decoration 3.5, image 4, adequacy 4, understanding 4), picture 2 candidate (4, 4, 4, 4: three torches lit, shelf, plants, sculptures; she stands beside the ball in profile, kept as risk), clean original kept as Art/Gallery-clean/2-a-colonist-gazing.png, run deleted; scene 1 recomposed (advance 40 to 140 ticks so she is mid-room, not in the doorway; unverified: walk speed), take 6 ticket 6ed1 green 1 of 1, read 2026-11-17: picture 1 REDO (advance 140 ticks did not move her: she still stands in the east door frame at the right edge, small, same as take 5 at 40 ticks; ball about 23 px; one torch, bare floor; decoration 3, adequacy 2.5; cause of the no-walk unproven: advance step or the joy job not walking while paused), run deleted; NPT (PiT) said the advance step does tick pawns and jobs while paused, so she has no job or a job that cannot start; take 7 ticket 1d35 green 1 of 1, read 2026-11-17: `job=CB_GazeIntoCrystalBall` before AND after the 140 ticks (0.7 s real), yet she still stands in the east door frame (146,73): job set, pawn does not move; question relayed to NPT (PiT) through the TM: does the advance step run pathing, a step to read her position or toil, how to make her walk (run deleted); take 7 plan was (scene 1 only, e112baa): logs `[face-state] Nelim: ... job=<JobDef or none>` before and after the 140 ticks; if job=none or Wait: check the giver (`gives no job`, `can reach`), or force the job (`"Nelim" is forced into the job "<JobDef>" on the building "<def>" at (x, z)`) then advance about 25 to 90 ticks (walk about 4 cells per second, 60 ticks per second); then read at 268 px, score, subtitles (Add-Subtitle on the clean originals), 9.e bis, one review by Virginie (only when the whole gallery is ready), 9.f", "Replay 2026-11-17 (whole chain 1 to 6, stopped at 6.g): back from playTests[1.1.0] to localize[1.1.0]; 1.7 declared 2026-11-15, tested_1_7 yes, 8.m code_review_sha e48e3be and the 1.7 runs are kept (history in Docs/runs/status-journal.md)", "Check-ModBasics WARN, pre-existing: About description should end with the Source code on GitHub url form, left for Virginie or Audit"]
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 6a2012f9ad0e2e66a9e8a29ac42b80f1628a2d3a
publication_changelog_review_sha: 6625b154c312ed5a8356cf6d6388b1496d41923a
echo_review_sha: 78b73b79bb007ef9a3b8efe097bb8cf09defbd6c
updated:      2026-11-17
protocols_read_sha: 161d23ea994de6aab35c3cabe5af940316d80e1b
---
# Crystal Ball: status (2026-10-10)

**`workflow_stage: shootGallery[1.1.0]`** (6.g validated by Virginie 2026-11-17, left localize) (replay 2026-11-17 moved it back from `playTests[1.1.0]`: 6.g, French changed 2026-11-13 after Virginie's review; earlier note: stage walked one by one from `code`, 2026-10-18, owner request: nothing coded for 1.1.0, `Mod/` unchanged since `v1.0.1` but the Preview; 3.a to 3.c checked: no feature open, no assembly, `[Unreleased]` present) (minor bump for RimWorld 1.7 line; `1.7` declared 2026-11-15 after the green 1.7 diagnostic, `tested_1_7: yes`). Version `1.0.1` public on Steam (item 3806709786), post-publication
non-regression green. Dated sections that used to live here now one line each in `docs/runs/status-journal.md`
(AUDIT.md 14.c); full text in git.

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 12 of 12 and 11 of 11 | `Tests/Rule-OwnValues.ps1`, `Tests/Rule-GameReflection.ps1` (via generated `Tests/Test-Mod.ps1`) |
| Pickle, non-regression of `1.0.1` | French `68c7` and English `8acb` green; `sanctuary` `c525` 15 of 16 (save scenario accepted) | `docs/runs/README.md`, `TESTING.md` |
| Thank-you comments | None to post: Pickle and RimLogging already `posted` in global register, Ludeon no page | `PUBLICATION.md` section 4, `WORKSHOP_COMMENTS.md` |
| Gallery | `0-preview`, `1-the-ball-by-day`, `2-a-colonist-gazing`, `3-the-ball-glowing-in-the-dark`, qualified and uploaded by Virginie | `Art/Gallery/`, `PUBLICATION.md` |
| French | Validated by Virginie, `FRENCH_REVIEW.md` at `17678e8` | `FRENCH_REVIEW.md` |
| Reviews | `code_review_sha` `fe64cae` (revue du diff : images et texte seuls, 2026-11-02), all findings fixed or closed; `publication_changelog_review_sha` `6625b15` | front matter |
| Ideas not started | Stronger night glow, for later patch | `BACKLOG.md` |

`git diff v1.0.1..HEAD -- Mod` shows only `Mod/About/Preview.png` (echo redrawn, `bac147e`): no def, text or code change. `CHANGELOG.md` carries it under `## [Unreleased]` for `1.1.0`.

## Ecosystem (8.0, 2026-11-13, PiI, `docs/inventory/ecosystem-steam/CrystalBall.md`)

No duplicate, no patch, retexture or translation of our mod found. Source of each line: Steam (Chrome, by page) and corpus scan of 3 defNames and 2 labels (2 weak hits, 0 shared defName).

| packageId or Workshop id | Type | Last update | Note |
| --- | --- | --- | --- |
| 2137901315 (CrystalBall, The Pickles) | same name, other function | 2020 | pawns foresee incidents; not a duplicate |
| 2483367722 (CrystalBall Continued, Mlie) | same name, other function | 1.6 | update of the above; only the title overlaps |
| 3603522660 (Pondering Orbs) | theme neighbour | 1.6 | palantiri orbs |

Study subscriptions all removed 2026-11-13. No licence read (page only).

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
wording, 2026-10-08). French changed twice since: `69e82ba` (2026-11-13, `support à griffes`) and 2026-11-17 (`qui diffuse de l’intérieur une faible lueur violette`, ChatGPT round 1). `/review-translation` page 1 of 1: three rounds on 2026-11-17 (1 applied French, 1 applied `PUBLICATION.md`, 0 applied), clean at round 3; one rejection (taste): `than when they sat down` in the English description. `TRANSLATION_REVIEW.md` regenerated; Virginie validated the current French on 2026-11-17 at `876a481` (review line of `TRANSLATION_REVIEW.md` filled, no correction).

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

Historic (before the green 1.7 diagnostic of 2026-11-15, now `tested_1_7: yes`, see `Docs/runs/README.md`). First 1.7 run `2e1e` (English, in `docs/runs/README.md`, failed evidence deleted once studied): 7 of 16 passed, 5 failed, 4 skipped (`docs/runs/README.md`). Failures: pawns not arriving within 90 s (same scenarios take about 10 s on 1.6) and save scenario already red at `c525`; no mod exception in log, cause not established. Ticket `7a63` (`RUN_DONE` exit 1, `p17-cb-red5-1016`): 0 of 5 passed, same 5 red. Build: blueprint still waiting for material after 283 s. Gaze scenarios: job `CB_GazeIntoCrystalBall` runs, pawn still moving toward ball after 90 s. Save: `TryGiveJob returned no job`, as at `c525`. No mod exception; cause not established, pawns slow on 1.7 (Pickle#63, game speed or pathing: not checked here). `Mod/` and `Tests/` free to change again. Checked 2026-10-16: scenarios load Pickle's shared fixture `test-colony.rws` (gameVersion 1.6.4633; log `Loaded file (Map) is from version 1.6.4633`), not a mod file. Audit knows no green walking or hauling scenario on 1.7: the green p17- tickets are load, defs, language and restart checks; DrumBathHygiene `9910` is green but its scenarios teleport the pawn onto the drum. So the cause may be Pickle#63 or 1.7 pathing, not this mod; not proven. Blocked: no walking scenario of this mod can be judged on 1.7 until a pawn walk is shown green elsewhere or the fixture is re-saved on 1.7 (Pickle side). `tested_1_7` stays unrecorded; no `1.7` in `supportedVersions`.

Open 2026-10-18: 1.7 diagnostic ticket `20261017-180855-702-bf2b` (PathProbe, filed by the `1.7` session, evidence deleted once studied, superseded by green `75fc`, first try `16aa` stalled at startup): `Jet` ordered 16 cells east on `test-colony`, wait 900 ticks, assert a Human on the cell. Green: the 0 of 5 of `7a63` comes from the mod's joy path, not 1.7 pathing. Red: Pickle#63 or 1.7 pathing defect, `1.7` session gives the proof. Nothing is filed by CB until `RUN_DONE`.

## Stage walk 2026-10-18 (owner request, one stage at a time, nothing skipped)

- `code` to `declareDependencies`: 3.a no `feature` open; 3.b no assembly (`Mod/` has defs, French DefInjected, one texture); 3.c `[Unreleased]` says what 1.1.0 changes (Preview echo, 1.7 line). Done.
- `declareDependencies` to `settings` (revision `44658b4`): 4.a read `Mod/Defs/CrystalBall.xml` and `About.xml`: vanilla things only (`Jade`, `Gold`, `BuildingsJoy`, `JobDriver_SitFacingBuilding`, `JoyGiver_InteractBuildingSitAdjacent`), no mod reference, no `MayRequire`. 4.b `modDependencies` none, `loadAfter` names the game only, no `incompatibleWith`. 4.c no DLC reference in defs, no `LoadFolders.xml`, `supportedVersions` is `1.6` only. 4.d no cycle possible (no dependency). 4.e no patch. 4.f not an animal mod. Nothing changed since the 2026-10-11 audit. Done.
- `settings` to `localize` (revision `28bf1a5`): 5.a/5.b inventory: no option, no `ModSettings`, no assembly, no page, no MainButtons def in `Mod/`; nothing configurable that a player needs (one def set, vanilla joy logic). 5.c to 5.e not applicable. 5.f `scripts/Run-Tests.ps1` 22 of 22 and `scripts/Run-Functional-Tests.ps1` 11 of 11 replayed today. 5.g `settings_audit: not_applicable` stands, no empty page, no shortcut. Done.
- `localize` to `writeTests` (revision `b08ee51`): 6.a texts = 2 ThingDef fields, 1 JobDef `reportString`, 1 JoyKindDef label, no Keyed, no code string. 6.b English is Def source text. 6.c `Check-Translations` pass, `Check-DefInjected` 4 keys 0 errors, today. 6.d no pawn token needed, no `tu`/`vous`/`nous` addressed to player (`on s’assied`, `scrute`). 6.f `FRENCH_REVIEW.md` regenerated (revision line only). 6.g French unchanged since Virginie's review at `17678e8` (2026-10-08): `Mod/Languages` and `Mod/Defs` untouched since. Fields `localization`, `translation_en`, `translation_fr` stay `complete`. Done.
- `writeTests` to `playTests` (revision `90b24fc`): 7.a scenarios in `TESTING.md`, one per promised behaviour. 7.b `Run-Tests.ps1` 22 of 22 replayed today. 7.c `Check-ModBasics` pass, `Run-Functional-Tests.ps1` 11 of 11. 7.d 7 Pickle features written (`Tests/Pickle/Mod/Pickle/Features/`), `Check-Steps.ps1 -ModRoot .` exits clean (one unused step, known); local steps and scripts catalogued (`Inventory-LocalScripts.ps1 -Check` OK). 7.f results are for `Mod/` unchanged since `v1.0.1`. 7.g translations complete, French reviewed. This `playTests[1.1.0]` is the 1.7 diagnostic: ticket `75fc` pending, verdict from the `1.7` session at `RUN_DONE`. Done.

## NSB (sync 2026-11-17, writeShotlist[1.1.0])

Places read: 2026-11-17 (hut only). Tribe read: 2026-11-17 (Nelim only). Steps read: 2026-11-17 (NPT steps and catalogues since 2026-10-15).
Since the last gallery run (2026-10-15) nothing in NSB or NPT breaks the plan: `Docs/steps.md` of NSB unchanged but a folder rename; NPT adds `the game is advanced by N ticks`, `the decor ... burns`, `the joy giver {string} job is forced on {string}`. Rules of the owner (2026-11-05) said back: everything in NSB is free; outside NSB needs express validation; a colonist's properties change only with her express validation; every outfit is free; every animal the mod adds must show (this mod adds none).

| Place | Shots | Changes for the gallery | Last read |
| --- | --- | --- | --- |
| `hut` (alias `tea-room`, centre (140, 73), roofed, dark) | 1, 2, 3 | room emptied, set of decor laid and taken down per scenario (3 TorchLamp, Plant_Rose, Plant_Daylily, Shelf, Bookcase, 2 SculptureSmall); load `Nelims-tribe`, not the decorated fixture | 2026-11-17 |

| Colonist | Shots | Outfit per shot | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Nelim (NSB) | 1, 2, 3 | 1 and 2: `Apparel_Robe` of `Leather_Plain` (tan against the violet ball); 3: same robe plus `Apparel_Cape` dyed rgb (98, 52, 150) (a mage at night, owner suggestion 2026-10-08) | 2026-11-17 | hairstyle `Flowy` VALIDATED by Virginie 2026-11-17: "ok pour la coiffure (pour faire mage)"; eye colour NOT validated ("pas pour les yeux"): no rgb step, canon `Eyes_DarkBrown` (#4C1200) stays, so pictures 1 to 3 change slightly and are retaken |

| Animal | Shots | Outfit | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| none (hut emptied of animals on purpose) | | | | none |

| Animal the mod includes | Shot |
| --- | --- |
| none: the mod adds no animal | n/a |

## Shotlist (v3 2026-11-17, after the Opus director pass)

Story: the seer's evening, one hut, the light going down. Nelim (protagonist, NSB) comes into the hut at the water's edge at 17:00 with her crystal ball, crosses the room to it at the same hour while the first torch burns, sits and gazes at 18:00 with all three torches lit, and at 23:00 the torches are out and only the ball's own violet glow is left. Rhythm: the hour is set in each scenario (each reloads the save), then a set-up wait; 2,500 ticks per game hour. Pictures 1 to 3 of 1.0.1 are retaken: the eye colour step is dropped (canon `Eyes_DarkBrown`, Virginie 2026-11-17: "pas pour les yeux") and scenes 1 and 2 gain a mid-action instant. Hairstyle `Flowy`, validated by Virginie 2026-11-17: "ok pour la coiffure (pour faire mage)". Outfit continuity: leather robe (tan, `Leather_Plain`) in all three, violet cape (dyed rgb (98, 52, 150)) only at 23:00 (the seer dresses as a mage for the night: written, the owner's suggestion of 2026-10-08). Set (same in the three scenes, laid after the room is emptied, taken down with the scenario): TorchLamp (137,71), (144,70), (143,76); Plant_Rose pot (140,75); Plant_Daylily pot (140,73); Shelf (136,73); Bookcase (138,77); SculptureSmall (136,70), (144,77); bare plank floor. No animal: the mod adds none and the hut is emptied of animals on purpose.

| # | a Frame of time | b Decor | c Living | d Pawn | e Action, instant, how obtained | f Composition | g Subject | j The mod at 268 px |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 `1-the-ball-by-day` wide | hut, 17:00, Clear, 60 ticks set-up | 9 named objects around the ball on planks, first torch lit in frame | Rose and Daylily in pots | Nelim, `Flowy`, tan robe, canon eyes, own face (canon smirk, written) | she has just come through the east door (146,73) and walks to the ball; obtained: `the joy giver sends Nelim to the ball` from (146,73), `the game is advanced by 4 ticks`, then paused before she sits | zoom 2.8 on (143,73), ball off the centre line, shelf and bookcase west, door east | a seer walks in at dusk to a violet ball in a half-lit room | violet sphere with its glow reads as the one bright violet object |
| 2 `2-a-colonist-gazing` medium | hut, 18:00, Clear, 60 ticks | same set, all three torches lit | same pots | same outfit; expression `SocialRelax`, calm kit (relaxed gaze, written) | she has just sat on the west cell and looks into the ball, the torches she lit behind her; obtained: joy giver job, `Nelim sits beside the ball`, 90 ticks after sitting, paused | zoom 2.6 on (139,74), ball left, Nelim right | she looks into it on her own, no chair | ball and seated colonist side by side, ball a third of the width |
| 3 `3-the-ball-glowing-in-the-dark` close | hut, 23:00, Clear, no torch, 60 ticks | same set, torches unlit, room dark | same pots, lit violet | same robe plus violet cape, calm kit, `LidSleepy`, expression `normal` last (dreamy, written) | she has stayed with the ball after the torches went out; obtained: joy giver job on the east side, 600 ticks of gazing, paused | zoom 2.2 on (139,74), face and ball lit violet, rest dark | the ball's own glow is the only light | glow and ball fill the frame |

Series k: one story, three episodes (arrive, gaze, night); shots wide, medium, close; opening sets the hut, closing is the glow alone; framing and hour change each time. Plan rating (`score-gallery`, plan only, no capture rated): scene 1 criteria a to g and j ok, scene 2 ok, scene 3 ok, k ok: 5, 5, 5; before this rewrite the draft rated 3.5, 4, 3.5 (e weak on 1, 2 and 3, j weak on 1, f weak on 3 repeating scene 2, k weak on the series). Not verified: the steps `the joy giver sends ... to sit on its west side` and `the game is advanced by N ticks` are read in the catalogues, none of them played with these ticks; `LidSleepy` needs VEFA (`wsl-deps.sanctuary.map` to check); `I dress ... made of` and `I destroy the gear of` found in no catalogue read (Pickle core?).

Subtitles (`PUBLICATION.md`, "Gallery subtitles"): 1 "The seer arrives with her crystal ball and lights the first torch." (to reword: she walks in, the torch is lit), 2 "Dusk falls, and she sits beside it, no chair needed.", 3 "By night, the ball's own glow is the only light left."

Open before any ticket: Opus director pass; scenarios rewritten from this plan (the scenarios of 1.0.1 are replaced: delete `Art/Gallery/1-*` to `3-*` clean copies at the commit, none exist in `Art/Gallery-clean/`); `Check-ShotlistVsScenario.ps1`; subtitles after the captures; owner review at the end.

Opus director pass (one call, 2026-11-17), kept: scene 1 no draft and no posed stance, torch lit by the east door (144,70), frame (142,73) zoom 6 with the open east door, renamed `1-the-seer-arrives`, caption "walks in at dusk"; scene 2 frame (139,74) zoom 5.5 with Nelim left, in profile, the last torch just caught, caption says "gazes" (the sit-facing driver draws her standing); scene 3 frame (139,74) zoom 4 with Nelim right of centre, the unlit torch (143,76) in frame, 600 ticks of gazing, story "she came back after the torches died"; series cue torches 1, 3, 0 plus the cape. Kept as risks, unverified: the 30 ticks of presentation after the instant, mid-stride timing (second take at about 50 ticks if needed), `SocialRelax` after the joy job, `LidSleepy` and VEFA, dark-room readability at 268 px. Not kept: nothing refused. Plan rating after the pass: 5, 5, 5 (`score-gallery`, plan only). Scenarios rewritten from this plan in `05-workshop-captures.feature` and `07-workshop-glow.feature`; `Check-ShotlistVsScenario.ps1`: OK (one WARN, picture 3 lives in feature 07). Old captures `Art/Gallery/1-*` to `3-*` removed (git rm, rule of 2026-11-06); the uploaded Steam images stay until the new gallery is accepted.
