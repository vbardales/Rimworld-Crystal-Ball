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
workflow_stage: publish[1.1.0]
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
remaining: ["9.a to 9.e bis done 2026-11-18: three gallery pictures validated by Virginie (1 take 16 ticket 3b65, 2 take 11, 3 take 13), clean originals in Art/Gallery-clean, subtitles burned in Art/Gallery (lines in PUBLICATION.md); history of takes 2 to 16 in git; writeReleaseDocs 2026-11-18 (stage reached after Preview validated, sent as GitHub social preview, DALL-E confirmed): 11.a/11.b description unchanged (AI-GENERATED names DALL-E); 11.c About.xml unchanged, sync-about-description.mjs not applicable (BBCode source, needs Markdown format); 11.e PUBLICATION.md updated (gallery table, Preview, subtitles, section 4, ### 1.1.0 note with [list]); 11.f CHANGELOG [Unreleased] updated (Preview, gallery); 11.g adult-content No unchanged, pictures opened; 11.h thanks: the twelve gallery mods are all posted, Crystal Ball added to their Covers (WORKSHOP_COMMENTS.md, pushed), ATTRIBUTION.md section Gallery set (root and Mod copies identical), thanks_drafted_line none; next: Check-ModBasics and closing pass, 11.j Virginie rereads PUBLICATION.md and CHANGELOG.md, 11.j DONE (Virginie validated PUBLICATION and CHANGELOG 2026-11-18, publication_changelog_review_sha set), 11.k GALLERY-PROPS row added (protocols repo); 12.a no code commit since code_review_sha (only Preview.png and ATTRIBUTION in Mod/), 12.b no dependency (none), 12.c Check-Status -Strict 0 error 0 warning, 12.c bis STATUS and TESTING compressed (Tests/Pickle/README.md not: its backup name collides with another mod, 2-line change only), 12.d pushed; 12.e CHANGELOG dated 2026-11-18, dry-run run 44307747446 on e807599 green (update_preview true, description false): note read 2026-11-18 (the [list] of 1.1.0 with the CHANGELOG link, correct), preview 481322 bytes sha 342526c8 replaces the page image (568210 bytes), tags to send Mod, 1.6, 1.7 (adds 1.7), version above v1.0.1, DRY RUN nothing sent; 12.h stage set to publish[1.1.0] (new SHA, so a final dry-run is run on it before dispatch); PUBLISHED 2026-11-18: final dry-run 44307937749 on e3412bd green and note read; first publish run 44308969646 failed before Steam (STEAM_REFRESH_TOKEN missing from steam-production, Virginie copied it, CI/CD fixed dispatch-publish.sh); publish run 44309913574 approved by Virginie, success, tag v1.1.0 and release created by CI, tags set and read back from Steam: Mod, 1.6, 1.7, preview sent; PublishedFileId.txt already committed (3806709786); next 13.b: SUBSCRIBE-TEST asked to PiI 2026-11-18, note its answer date, then Virginie updates the gallery on the Steam page by hand (4 pictures from Art/Gallery), then 13.f startWatch[1.1.0]", "Replay 2026-11-17 (whole chain 1 to 6, stopped at 6.g): back from playTests[1.1.0] to localize[1.1.0]; 1.7 declared 2026-11-15, tested_1_7 yes, 8.m code_review_sha e48e3be and the 1.7 runs are kept (history in Docs/runs/status-journal.md)", "Check-ModBasics WARN, pre-existing: About description should end with the Source code on GitHub url form, left for Virginie or Audit"]
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 6a2012f9ad0e2e66a9e8a29ac42b80f1628a2d3a
publication_changelog_review_sha: 5c694993b743883d7b2098292d9b5ed3ab394738
echo_review_sha: f865d9e258c22504ad675ead07806f2893efd632
thanks_drafted_line: none
social_preview_sha256: 342526c8c92ef6374e2ad75a1d26ace190e2d8352ec79f9352d40795e88a990c
updated:      2026-11-18
protocols_read_sha: 3af323f80304f930d38d8845d021494122abc0b9
---
# Crystal Ball: status (2026-11-18)

**`workflow_stage: writeReleaseDocs[1.1.0]`** (minor bump, RimWorld 1.7 line; `1.7` declared 2026-11-15 after green 1.7 diagnostic, `tested_1_7: yes`). `1.0.1` public on Steam (item 3806709786). `Mod/` unchanged since `v1.0.1` except `Mod/About/Preview.png`, `Mod/ATTRIBUTION.md`. Dated sections now one line each in `docs/runs/status-journal.md` (AUDIT.md 14.c); full text in git.

| What | State | Where |
| --- | --- | --- |
| Published version | `1.0.1`, tag `v1.0.1`, rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0) | `CHANGELOG.md`, `PUBLICATION.md` |
| Offline suites | 12/12, 11/11 | `Tests/Rule-OwnValues.ps1`, `Tests/Rule-GameReflection.ps1` (via generated `Tests/Test-Mod.ps1`) |
| Pickle, non-regression `1.0.1` | French `68c7`, English `8acb` green; `sanctuary` `c525` 15/16 (save scenario accepted) | `docs/runs/README.md`, `TESTING.md` |
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

## Repository identity

Git root `C:\Users\nelim\Documents\rimworld\CrystalBall`, own `.git`, no superproject, origin `vbardales/Rimworld-Crystal-Ball` (public). Title **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**, original mod; no continuation suffix. No upstream repo, no PR owed.

## Licence

**MIT**, copyright (c) 2026 Nelim, in `LICENSE` and `Mod/LICENSE`. `licence: original` = catalogue provenance category. Credits: defs + code by Claude Code; texture AI-generated, cut out, outlined, resized under human direction (`ATTRIBUTION.md`); preview by Virginie. No game assembly or third-party mod code shipped.

## Translation audit

French only in `Mod/Languages/French/DefInjected/` (`ThingDef/CrystalBall.xml`, `JobDef/CrystalBall.xml`, `JoyKindDef/CrystalBall.xml`); no Keyed, no pawn token, no agreement left (description reworded without). English = Def source text. Virginie validated French (`FRENCH_REVIEW.md`, revision `17678e8`, `devant elle` wording, 2026-10-08). French changed twice since: `69e82ba` (2026-11-13, `support à griffes`), 2026-11-17 (`qui diffuse de l’intérieur une faible lueur violette`, ChatGPT round 1). `/review-translation` page 1/1: three rounds 2026-11-17 (1 applied French, 1 applied `PUBLICATION.md`, 0 applied), clean round 3; one rejection (taste): `than when they sat down` in English description. `TRANSLATION_REVIEW.md` regenerated; Virginie validated current French 2026-11-17 at `876a481` (review line of `TRANSLATION_REVIEW.md` filled, no correction).

## Clean-up record (2026-10-10)

`STATUS.md` + `TESTING.md` folded (14.c): `TESTING.md` current revision only. Branches: only `main` (14.d done).
**WSL clean-up (14.c), 2026-10-10: nothing removed.** 12 Workshop items of `Tests/Pickle/wsl-deps.sanctuary.map` (1635901197, 2581693737, 2816938779, 2889716301, 2986402536, 3255379190, 3527486510, 3745223213, 3753978140, 3790129900, 3798082132, 3799726535) each named by other mods' `wsl-deps*.map` (A Certain Series, A Perfect Mind, Adaptive Storage, Ancient Buildings, Fieldwork Companions, Megabees, others), so all stay. None in `~/workshop-cache` for this mod alone; machine lock not needed (read-only; lock held by Work Studio run).

## Audit 2026-10-11 (revision `eb8d334` plus the working tree of this commit)

Retained: **`dormant`** (`followUp[1.0.1]` closed 2026-10-10, nothing reopened). No step back.

- Offline suites replayed: `scripts/Run-Tests.ps1` 22/22 (was 25: six generic tests moved to shared `Check-ModBasics`, `Check-DefInjected`, `Check-Translations`, now three tests), `scripts/Run-Functional-Tests.ps1` 11/11; both dot-source `scripts/lib/TestRunner.ps1` + `GameReflection.ps1`. Step project builds, 0 errors (`dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`). Local `Tests/Pickle/Check-Steps.ps1` failed here (sought `CucumberExpressions.dll` in Windows Pickle install root); deleted per Audit session verdict; shared `scripts/Check-Steps.ps1 -ModRoot .` exits 0 (26 patterns compile, 215 step lines resolve to exactly one expression; one unused step, `a crystal ball {string} stands on open ground near ({int}, {int})`). Flagged `05`, `07` using CameraZoom, StageDecor, ColonistRace steps without `@requires`: added, so both skip in passes not staging them. No game launched.
- Shipped content: `Mod/` = defs, French DefInjected, one texture, no assembly; `git diff v1.0.1..HEAD -- Mod` empty; `Mod/About/Preview.png` byte-identical to `Art/Gallery/0-preview.png` (sha256 `56f01ec6...`); `LICENSE`, `ATTRIBUTION.md` identical root vs `Mod/`; `About.xml` description ends with `Source code on GitHub` line; GitHub `og:image` → custom repo image; `Mod/desktop.ini` ignored, no `.ico`/`.dds` tracked.
- Protocols reread after move (06263cb0 to HEAD): new rules applied: no em dash in repo text (fixed `README.md`, `TESTING.md`, `STATUS.md`, `docs/runs/README.md`; left: `CHANGELOG.md` append-only, `ATTRIBUTION.md` has shipped `Mod/` copy, change would touch `Mod/`); intermediates `build/` not `.build/` (`Tests/Pickle/build/`, `Directory.Build.props`, `.gitignore`, `Tests/Pickle/README.md`); `echo_review_sha` replaces `echo_review`.
- Echo review (AUDIT.md 10.a): `Art/echo.png` (line art, claw-footed sphere) matches gallery ball; keep. Validated at `eb8d334`, gallery + echo unchanged since.
- N/A, unchanged: `settings_audit` (no option, page, shortcut), dependencies (none, `loadAfter` game only), DLC (proved offline), adoption clause present (public mod).
- Open, not defect: none. Empty `## [Unreleased]` heading removed from `CHANGELOG.md` (Check-Status: none may stay on top from `publish` on); next patch re-adds at `code[1.0.2]`.

## Echo review (2026-10-15)

Virginie hand-redrew `Art/echo-source.png` (2026-10-14): faceted violet sphere, claws, crystal point, as gallery (old had cracks gallery lacks). Kept, Virginie validated at `bac147e`; Preview, `0-preview.png`, `Preview.ico` regenerated in that commit (echo smaller, accepted). `echo_review_sha` set to it.

## RimWorld 1.7 diagnostic (2026-10-16)

Historic (pre green 1.7 diagnostic 2026-11-15, now `tested_1_7: yes`, see `Docs/runs/README.md`). First 1.7 run `2e1e` (English, in `docs/runs/README.md`, failed evidence deleted after study): 7/16 passed, 5 failed, 4 skipped (`docs/runs/README.md`). Failures: pawns not arriving within 90 s (~10 s on 1.6); save scenario already red at `c525`; no mod exception, cause unknown. Ticket `7a63` (`RUN_DONE` exit 1, `p17-cb-red5-1016`): 0/5, same 5 red. Build: blueprint still awaiting material after 283 s. Gaze: job `CB_GazeIntoCrystalBall` runs, pawn still walking to ball after 90 s. Save: `TryGiveJob returned no job`, as `c525`. No mod exception; cause unknown, pawns slow on 1.7 (Pickle#63, game speed or pathing: unchecked). `Mod/`, `Tests/` free to change again. Checked 2026-10-16: scenarios load Pickle shared fixture `test-colony.rws` (gameVersion 1.6.4633; log `Loaded file (Map) is from version 1.6.4633`), not mod file. Audit knows no green walking/hauling scenario on 1.7: green p17- tickets = load, defs, language, restart checks; DrumBathHygiene `9910` green but teleports pawn onto drum. So cause maybe Pickle#63 or 1.7 pathing, not this mod; unproven. Blocked: no walking scenario of this mod judgeable on 1.7 until pawn walk shown green elsewhere or fixture re-saved on 1.7 (Pickle side). `tested_1_7` unrecorded; no `1.7` in `supportedVersions`.

Open 2026-10-18: 1.7 diagnostic ticket `20261017-180855-702-bf2b` (PathProbe, filed by `1.7` session, evidence deleted after study, superseded by green `75fc`, first try `16aa` stalled at startup): `Jet` ordered 16 cells east on `test-colony`, wait 900 ticks, assert Human on cell. Green: 0/5 of `7a63` from mod's joy path, not 1.7 pathing. Red: Pickle#63 or 1.7 pathing defect, `1.7` session proves. CB files nothing until `RUN_DONE`.

## Stage walk 2026-10-18 (owner request, one stage at a time, nothing skipped)

- `code` to `declareDependencies`: 3.a no `feature` open; 3.b no assembly (`Mod/` = defs, French DefInjected, one texture); 3.c `[Unreleased]` states 1.1.0 changes (Preview echo, 1.7 line). Done.
- `declareDependencies` to `settings` (revision `44658b4`): 4.a read `Mod/Defs/CrystalBall.xml`, `About.xml`: vanilla only (`Jade`, `Gold`, `BuildingsJoy`, `JobDriver_SitFacingBuilding`, `JoyGiver_InteractBuildingSitAdjacent`), no mod ref, no `MayRequire`. 4.b `modDependencies` none, `loadAfter` game only, no `incompatibleWith`. 4.c no DLC ref in defs, no `LoadFolders.xml`, `supportedVersions` `1.6` only. 4.d no cycle (no dependency). 4.e no patch. 4.f not animal mod. Unchanged since 2026-10-11 audit. Done.
- `settings` to `localize` (revision `28bf1a5`): 5.a/5.b inventory: no option, no `ModSettings`, no assembly, no page, no MainButtons def in `Mod/`; nothing player-configurable needed (one def set, vanilla joy logic). 5.c–5.e N/A. 5.f `scripts/Run-Tests.ps1` 22/22, `scripts/Run-Functional-Tests.ps1` 11/11 replayed today. 5.g `settings_audit: not_applicable` stands, no empty page, no shortcut. Done.
- `localize` to `writeTests` (revision `b08ee51`): 6.a texts = 2 ThingDef fields, 1 JobDef `reportString`, 1 JoyKindDef label, no Keyed, no code string. 6.b English = Def source text. 6.c `Check-Translations` pass, `Check-DefInjected` 4 keys 0 errors, today. 6.d no pawn token needed, no `tu`/`vous`/`nous` to player (`on s’assied`, `scrute`). 6.f `FRENCH_REVIEW.md` regenerated (revision line only). 6.g French unchanged since Virginie review at `17678e8` (2026-10-08): `Mod/Languages`, `Mod/Defs` untouched. `localization`, `translation_en`, `translation_fr` stay `complete`. Done.
- `writeTests` to `playTests` (revision `90b24fc`): 7.a scenarios in `TESTING.md`, one per promised behaviour. 7.b `Run-Tests.ps1` 22/22 replayed today. 7.c `Check-ModBasics` pass, `Run-Functional-Tests.ps1` 11/11. 7.d 7 Pickle features (`Tests/Pickle/Mod/Pickle/Features/`), `Check-Steps.ps1 -ModRoot .` clean (one known unused step); local steps + scripts catalogued (`Inventory-LocalScripts.ps1 -Check` OK). 7.f results for `Mod/` unchanged since `v1.0.1`. 7.g translations complete, French reviewed. This `playTests[1.1.0]` = 1.7 diagnostic: ticket `75fc` pending, verdict from `1.7` session at `RUN_DONE`. Done.

## NSB (sync 2026-11-17, writeShotlist[1.1.0])

Places read: 2026-11-17 (hut only). Tribe read: 2026-11-17 (Nelim only). Steps read: 2026-11-18 (NPT steps + catalogues since 2026-11-17: only `face-parts.md` vanilla face notes, unused by gallery). NSB log since 2026-11-17 checked 2026-11-18 (Iori, Miel, Daichi, Dalia, BiB gene renames: no Nelim, no hut change), Places + Tribe dates unchanged.
Since last gallery run (2026-10-15) nothing in NSB/NPT breaks plan: NSB `Docs/steps.md` unchanged bar folder rename; NPT adds `the game is advanced by N ticks`, `the decor ... burns`, `the joy giver {string} job is forced on {string}`. Owner rules (2026-11-05) restated: all NSB free; outside NSB needs express validation; colonist properties change only with her express validation; outfits free; every mod-added animal must show (mod adds none).

| Place | Shots | Changes for the gallery | Last read |
| --- | --- | --- | --- |
| `hut` (alias `tea-room`, centre (140, 73), roofed, dark) | 1, 2, 3 | room emptied, decor laid/removed per scenario (3 TorchLamp, Plant_Rose, Plant_Daylily, Shelf, Bookcase, 2 SculptureSmall); load `Nelims-tribe`, not decorated fixture | 2026-11-17 |

| Colonist | Shots | Outfit per shot | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| Nelim (NSB) | 1, 2, 3 | 1, 2: `Apparel_Robe` of `Leather_Plain` (tan vs violet ball); 3: same robe + `Apparel_Cape` dyed rgb (98, 52, 150) (mage at night, owner suggestion 2026-10-08) | 2026-11-17 | hairstyle `Roo_HD_Hair_Highpony` (official canon, Virginie 2026-11-17, replaces `Flowy`) VALIDATED by Virginie 2026-11-17: "ok pour la coiffure (pour faire mage)"; eye colour NOT validated ("pas pour les yeux"): no rgb step, canon `Eyes_DarkBrown` (#4C1200) stays, so pictures 1–3 change slightly, retaken |

| Animal | Shots | Outfit | Last read | Exceptions |
| --- | --- | --- | --- | --- |
| none (hut emptied of animals on purpose) | | | | none |

| Animal the mod includes | Shot |
| --- | --- |
| none: mod adds no animal | n/a |

## Shotlist (v3 2026-11-17, after the Opus director pass)

Story: seer's evening, one hut, light fading. Nelim (protagonist, NSB) enters waterside hut at 17:00 with crystal ball, crosses to it same hour as first torch burns, sits and gazes at 18:00 with all three torches lit; at 23:00 torches out, only ball's violet glow left. Rhythm: hour set per scenario (each reloads save), then set-up wait; 2,500 ticks per game hour. Pictures 1–3 of 1.0.1 retaken: eye colour step dropped (canon `Eyes_DarkBrown`, Virginie 2026-11-17: "pas pour les yeux"); scenes 1, 2 gain mid-action instant. Hairstyle `Roo_HD_Hair_Highpony` (official canon, Virginie 2026-11-17, replaces `Flowy`), validated by Virginie 2026-11-17: "ok pour la coiffure (pour faire mage)". Outfit continuity: tan leather robe (`Leather_Plain`) all three, violet cape (dyed rgb (98, 52, 150)) only at 23:00 (seer dresses as mage for night: written, owner suggestion 2026-10-08). Set (same all three scenes, laid after room emptied, removed with scenario): TorchLamp (137,71), (144,70), (143,76); Plant_Rose pot (140,75); Plant_Daylily pot (140,73); Shelf (136,73); Bookcase (138,77); SculptureSmall (136,70), (144,77); bare plank floor. No animal: mod adds none, hut emptied on purpose.

| # | a Frame of time | b Decor | c Living | d Pawn | e Action, instant, how obtained | f Composition | g Subject | j The mod at 268 px |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 1 `1-the-ball-by-day` wide | hut, 17:00, Clear, 60 ticks set-up | 9 named objects around ball on planks, first torch lit in frame | Rose, Daylily in pots | Nelim, `Roo_HD_Hair_Highpony` (official canon, Virginie 2026-11-17, replaces `Flowy`), tan robe, canon eyes, calm kit (own face showed sweat drop on take 9, so calm kit like scenes 2, 3, written) | just entered by east door (146,73), walks to ball; obtained: `the joy giver sends Nelim to the ball` from (146,73), `the game is advanced by 4 ticks`, paused before sitting | zoom 2.8 on (143,73), ball off centre line, shelf + bookcase west, door east | seer walks in at dusk to violet ball in half-lit room | violet sphere + glow reads as the one bright violet object |
| 2 `2-a-colonist-gazing` medium | hut, 18:00, Clear, 60 ticks | same set, all three torches lit | same pots | same outfit; expression `SocialRelax`, calm kit (relaxed gaze, written) | just sat on west cell, looks into ball, torches she lit behind; obtained: joy giver job, `Nelim sits beside the ball`, 90 ticks after sitting, paused | zoom 2.6 on (139,74), ball left, Nelim right | gazes alone, no chair | ball + seated colonist side by side, ball a third of width |
| 3 `3-the-ball-glowing-in-the-dark` close | hut, 23:00, Clear, no torch, 60 ticks | same set, torches unlit, room dark | same pots, lit violet | same robe + violet cape, calm kit, `LidSleepy`, expression `normal` last (dreamy, written) | stayed with ball after torches out; obtained: joy giver job east side, 600 ticks gazing, paused | zoom 2.2 on (139,74), face + ball lit violet, rest dark | ball's own glow is only light | glow + ball fill frame |

Series k: one story, three episodes (arrive, gaze, night); wide, medium, close; opening sets hut, closing is glow alone; framing + hour change each time. Plan rating (`score-gallery`, plan only, no capture rated): scene 1 criteria a–g and j ok, scene 2 ok, scene 3 ok, k ok: 5, 5, 5; pre-rewrite draft 3.5, 4, 3.5 (e weak on 1, 2, 3; j weak on 1; f weak on 3 repeating scene 2; k weak on series). Unverified: steps `the joy giver sends ... to sit on its west side` and `the game is advanced by N ticks` read in catalogues, none played with these ticks; `LidSleepy` needs VEFA (check `wsl-deps.sanctuary.map`); `I dress ... made of` and `I destroy the gear of` in no catalogue read (Pickle core?).

Subtitles (`PUBLICATION.md`, "Gallery subtitles"): 1 "The seer arrives with her crystal ball and lights the first torch." (reword: she walks in, torch lit), 2 "Dusk falls, and she sits beside it, no chair needed.", 3 "By night, the ball's own glow is the only light left."

Open before any ticket: Opus director pass; scenarios rewritten from plan (1.0.1 scenarios replaced: delete `Art/Gallery/1-*` to `3-*` clean copies at commit, none in `Art/Gallery-clean/`); `Check-ShotlistVsScenario.ps1`; subtitles after captures; owner review at end.

Opus director pass (one call, 2026-11-17), kept: scene 1 no draft, no posed stance, torch lit by east door (144,70), frame (142,73) zoom 6 with open east door, renamed `1-the-seer-arrives`, caption "walks in at dusk"; scene 2 frame (139,74) zoom 5.5, Nelim left, profile, last torch just caught, caption says "gazes" (sit-facing driver draws her standing); scene 3 frame (139,74) zoom 4, Nelim right of centre, unlit torch (143,76) in frame, 600 ticks gazing, story "she came back after the torches died"; series cue torches 1, 3, 0 plus cape. Kept as unverified risks: 30 ticks presentation after instant, mid-stride timing (second take ~50 ticks if needed), `SocialRelax` after joy job, `LidSleepy` + VEFA, dark-room readability at 268 px. Refused: nothing. Plan rating after pass: 5, 5, 5 (`score-gallery`, plan only). Scenarios rewritten from plan in `05-workshop-captures.feature`, `07-workshop-glow.feature`; `Check-ShotlistVsScenario.ps1`: OK (one WARN, picture 3 in feature 07). Old captures `Art/Gallery/1-*` to `3-*` removed (git rm, rule of 2026-11-06); uploaded Steam images stay until new gallery accepted.