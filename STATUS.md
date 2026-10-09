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
stage:        published[1.0.1]
workflow_stage: published[1.0.1]
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    1.0.1 (published 2026-10-08) played 2026-10-08 and 2026-10-09 in game through Pickle: French `68c7` and English `8acb` green (12 of 12 played, 4 `workshop` captures skipped there); `sanctuary` `c525` 15 of 16, the four captures green, the save scenario red outside the scope of that pass (accepted by Virginie 2026-10-09, played green in the two minimal passes). Before that: 2026-09-25, in game through Pickle in the WSL (RimWorld 1.6.4871): 11 scenarios of 11 played and green, English and French, revisions f72ecd6 (ten in the two full passes) and 8ecaf70 (the save scenario, corrected); plus the 3 Workshop-picture scenarios of `05-workshop-captures.feature`, a conditional feature (`@requires:nelim.pickletools.screenshotstudio`) played in its own pass `workshop` on PickleTools' zen studio, revision 768ae50, green; the info-card review scenario added and played green 2026-09-26 (run 145b); non-regression of the published 1.0.0 (commit 7d64a56) played 2026-09-26 in all three passes, English and workshop green outright, French green after replaying one flaky scenario (docs/runs/README.md, runs d421, dcd5+519c, 0f99)
workshop:     3806709786
published_on: 2026-09-26, version 1.0.0 by the publish workflow (run 36232486752, SHA 7d64a56491d7f131ec5770342f65875d993f8279, dry-run 36232421213, description sent), tag v1.0.0 and GitHub release created by the CI. Made public by Virginie on 2026-09-26; the gallery (Art/Gallery/) and the subscriptions are hers, by hand.
remaining: []
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
code_review_sha: 302e6d8593e3ae17bc191c3823819bbd5a033cfc
publication_changelog_review: reviewed by Virginie (confirmed 2026-10-09) on 44ddfe6bcd26df3e08d3fddbeca0e236831e280e, PUBLICATION.md and CHANGELOG.md
updated:      2026-10-02
---


# Crystal Ball — status (2026-09-28)

**Stage `done` for `1.0.1` (2026-10-08); `1.0.0` is `published`.** The repository carries changes not yet played in game on their final build (texture, French text, images), so the audit falls back to `done` until the in-game suites and captures of `1.0.1` are green and read (`tested`). Version `1.0.0` was sent to Steam by the publish workflow on 2026-09-26 (run 36232486752, commit
`7d64a56491d7f131ec5770342f65875d993f8279`, dry-run 36232421213), which created the tag `v1.0.0` and the GitHub release. The item
is public and its gallery is uploaded. The public page carries the description as sent.

| What | State | Where |
| --- | --- | --- |
| Offline suites | 25 of 25 and 11 of 11, re-run 2026-09-26 | `scripts/Run-Tests.ps1`, `scripts/Run-Functional-Tests.ps1` |
| Pickle suite, published commit | Green in English and in the `workshop` pass; French green after replaying one flaky scenario | `docs/runs/README.md`, runs `d421`, `dcd5` and `519c`, `0f99` |
| Info card of the ball | Seen, the description fits | run `145b` |
| Publication sheet | Description, change note, gallery, rollback | `PUBLICATION.md` |
| Scenario coverage | Every scenario settled, four not applicable | `TESTING.md` |
| Ideas not started | A stronger night glow, for a later patch | `BACKLOG.md` |

Nothing is pending on `1.0.0`. The next publication is a patch (`1.0.1` or later) with its own dry-run of the exact commit and
Virginie's approval of `steam-production`; the last good commit is the rollback target, chosen then.

Audits and older records (the three audits `preTest`, `done` and `tested`, the translation audit, the preview overlay, the
workflow audits) are in git history (commit `1536950` and earlier).

## Repository identity

Verified on 2026-09-12: the Git root is `C:\Users\nelim\Documents\rimworld\CrystalBall`,
with its own `.git` directory and no Git superproject. This task manages this single local
repository, no longer the former monorepo. Origin fetch and push both point to the remote above.
GitHub reports `PUBLIC` through `gh repo view --json name,visibility,url`.

The mod title is **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**.
No continuation or fork suffix is justified by the provenance documented here: this is presented
as an original mod, not a maintained copy of someone else's mod. Keep the title unchanged.
The GitHub link is present in both `About.xml`'s `url` and, after this audit, its description.

## Licence and justification

The actual licence is **MIT**, copyright (c) 2026 Nelim. `LICENSE` and `Mod/LICENSE` carry
that licence. `licence: original` is the status catalogue's provenance category, not a licence name.

The repository credits original defs and vector texture made with Claude Code and a preview made
with DALL-E under human direction. Its behaviour references vanilla RimWorld classes; it ships
no game assembly or third-party mod code. That documented provenance supports keeping the
existing MIT licence: it allows reuse and continuations while retaining the copyright and licence
notice. This audit confirms the files and credits, not an independent history of every asset.
No additional attribution file or third-party licence is present.

## Audit 2026-10-02 (revision `8f82612` plus the working tree of this commit)

Retained: **`published`** (`workflow_stage: published`, session title `crystalball / published`). No step went back.

- Chain: unchanged since the 2026-09-26 publication. The current showcase is generated by the shared renderer from
  `Art/Preview-source.png`, `Art/Preview.config.json`, `Art/echo.png`, and the transparent
  `Art/ModIcon-source.png`; `Mod/About/Preview.png` is byte-identical to `Art/Gallery/0-preview.png`.
- Offline suites replayed today: `scripts/Run-Tests.ps1` 25 of 25, `scripts/Run-Functional-Tests.ps1` 11 of 11. No game launched.
- `.dds`: not in git (ignored by `*.dds`, never tracked). The cache file the game wrote at
  `Mod/Textures/Things/Building/Joy/CrystalBall.dds` was deleted from disk; the game regenerates it.
- `PublishedFileId.txt` exists and is committed (item 3806709786), so `CHANGELOG.md` already opens on `1.0.0` over `0.1.0`
  (append-only, not touched).
- Original mod: `upstream_mod_remotes: N/A`, `licence: original`. No upstream repository, so no pull request is owed.
- Gallery folder renamed to the current rule (single digit, `0-` = copy of the Preview): `PUBLICATION.md`,
  `BACKLOG.md` follow (the crop script, `Art/Crop-WorkshopScreenshots.ps1`, was removed from `Art/` on 2026-10-02 and stays in git history). `publish.config.json` points at the folder, not at names.
- Evidence (disk only, `Tests/Pickle/Evidence/`, 11.8 MB → 6.7 MB): removed `2026-09-25-validation-french` (revision
  `f72ecd6`, one scenario red there, replaced by the 2026-09-26 runs); `Player.log` of the three kept runs gzipped. Kept: the
  English non-regression (3 reviewed captures), the `workshop` pass, the French replay. Nothing in git or in a doc pointed at a
  removed folder. The French full pass of the published commit survives only as its line in `docs/runs/README.md`.
- Workflow documents: read versions in `docs/PROTOCOLS-READ.md`.

### Translation audit

French lives in `Mod/Languages/French/DefInjected/` only, laid out for review in `FRENCH_REVIEW.md` (generated by `scripts/Make-FrenchReview.ps1 -ModRoot .` (protocols repository; doubts in `french-review-flags.json`); English beside French, flagged points, her review line): `ThingDef/CrystalBall.xml` (label, description), `JobDef/CrystalBall.xml`
(`reportString`), `JoyKindDef/CrystalBall.xml` (label). No Keyed file, no grammar rule, no pawn token. English is the Def source text.
Flagged for Virginie: "Les colons viennent la scruter **d'eux-mêmes**" (agrees in the masculine plural without a switch; a wording
without agreement, e.g. "de leur propre initiative", would avoid it). Not corrected here: a session does not edit French it audits.
Review line: none yet.

## Next patch candidate (2026-10-02, not published)

Stage stays `published`: `1.0.0` is unchanged on Steam. Commit `5c0b282` replaces `Mod/Textures/Things/Building/Joy/CrystalBall.png` with Virginie's hand-painted texture (source `Art/CrystalBall-original.png`); superseded the same day by the RimWorld-style one (`Art/RWBall-cutout.png`, commit `9280384`, workshop pass `1462`). Offline suites 25/25 and 11/11 green on it. Pickle requests dropped on `5c0b282`: `20261002-093456-420-41eb` (`workshop` pass, new gallery captures) and `20261002-093457-974-d5fe` (full English pass); both green, read; they cover the previous texture. The French pass `afe0` is green. Still to do before a `publish`: read `1462` and retake the gallery crops from it, upload the new gallery pictures by hand, `CHANGELOG.md` `[Unreleased]` dated and versioned, dry-run of the exact SHA, rollback target `7d64a56`.

**Preview and gallery, Virginie, 2026-10-02.** She regenerated `Mod/About/Preview.png` and `ModIcon.png` (`Art/echo.png`, `Art/Preview.config.json`, `Art/Preview-source.png`) and moved the gallery to `Art/Gallery/` (`0-preview.png` a copy of the Preview, `.github/publish.config.json` `galleryDir` follows). These landed in commits `17283c4` and `800b8aa` under unrelated messages (swept in by `git add -A`); the work is hers. Reference revision for the two Pickle requests is therefore `800b8aa` or later, not `5c0b282`: `Mod/About/` images differ, nothing else in `Mod/`. `Art/Gallery/0-preview.png` is byte-identical to `Mod/About/Preview.png` (checked 2026-10-02, after `da1a4d2`); re-check before any publish. The `.ico` files are committed.

**French corrected, 2026-10-02**, on Virginie's review: the description had two masculine agreements (`d'eux-mêmes`, `on ne s'est assis`), now reworded with none (`de leur propre initiative`, `pour se divertir`, `on s'y assied`). Her proposed text, verbatim. `translation_fr` stays `partial` until she validates the corrected text in `FRENCH_REVIEW.md`; the French file changed, so the tickets `41eb` and `d5fe` (staged before this edit if already played) do not cover it, and a French pass is owed.

**French review line, 2026-10-02** (recorded from Virginie's message in chat; the review line of `FRENCH_REVIEW.md` is hers and stays empty): reviewer Virginie, revision reviewed `fb1adb2`, corrections requested earlier the same day (two masculine agreements, `en loisir`), applied verbatim; verdict: validated, neutral, natural and faithful. `translation_fr` is `complete`.

**French pass, 2026-10-02** (ticket `afe0`, no optional mods, French): `exitReason: passed`, 12 of 15 passed, 0 failed, 3 skipped (the three `workshop` captures, a conditional feature played in the `workshop` pass). The info-card capture was opened: the corrected description reads in French with no masculine agreement. Evidence `Tests/Pickle/Evidence/2026-10-02-texture-french`. The `workshop` pass for the RimWorld-style texture is ticket `1462`; `41eb`, `d5fe` cover the previous texture.

**Evidence trim, 2026-10-05** (disk full, Ticket Manager relaying Virginie): Tests/Pickle/Evidence/ 171 MB to 0.1 MB. Gone: the 2026-09-26 runs on 7d64a56 and 41eb, eport.html and messages.ndjson everywhere, all captures (the French info-card capture of fe0 was lost by a failed re-encode after I had opened it; its reading is in the French pass note above). Kept: 1462, d5fe, fe0, trimmed. No field of this file points at a removed report; the 2026-09-26 mentions above are history.

**Code review, 2026-10-05** (`/code-review` at low effort, diff from `0.1.0` = `b26a5ac` to `28a9acb`, full SHA `28a9acb536f5f84963ddbc6555069adaf66f95ab`): two findings, nothing fixed yet. (1) The texture provenance sentence (vector art with Claude Code) in `Mod/About/About.xml`, `ATTRIBUTION.md`, `README.md` and `PUBLICATION.md` is false for the shipped texture; it waits for Virginie's wording of how the new texture was made, and `ATTRIBUTION.md` still names `scripts/svg/CrystalBall.svg` as its source. (2) Minor: the corrected French reads a little differently from the English source (validated by Virginie at `fb1adb2`).

**Review fixes and regenerated images, 2026-10-05.** (1) Texture provenance corrected in `About.xml`, `README.md`, `PUBLICATION.md` and `ATTRIBUTION.md` (and its copy in `Mod/`): generated with an AI image model, cut out, outlined and resized under human direction; the vector art is named as superseded. (2) The French wording finding is closed `no_change_needed`: Virginie validated that text at `fb1adb2`. Virginie replaced `Art/ModIcon-source.png` (the winking orange ball); `Render-Preview.cjs` regenerated `Mod/About/ModIcon.png` (128 x 128, now with `modIconSource` in `Art/Preview.config.json`), `Mod/About/Preview.png` (896 x 504, 568 KB), `Art/Gallery/0-preview.png` (byte-identical) and both `.ico`. **Open defect, for Virginie to decide:** `Mod/About/ModIcon.png` weighs 31.9 KB, over the 30 KB ceiling of the shared guide (20-30 KB) and of `scripts/Run-Tests.ps1` (that test is now the one failing: 24 of 25). Not overridden here: only she decides to accept it or to send a lighter source. `.build/` at the repository root was deleted (regenerable build intermediates).

**ModIcon override, 2026-10-05:** Virginie accepted the 31.9 KB `Mod/About/ModIcon.png` (shared guide: 20-30 KB). Recorded as her override; the ceiling of `scripts/Run-Tests.ps1` is 32 KB for this icon, which brings the suite back to 25 of 25. The open defect of the entry above is closed.

**Gallery 1.0.1, 2026-10-07.** The hut series (run `7e76`, `Tests/Pickle/Evidence/2026-10-07-hut-gallery-6`, exit 0, 3 scenarios) was opened and read against the shooting plan: the seer sits beside the ball, not behind it; no animals; name label hidden; the three pictures are in `Art/Gallery/` (1600 x 900, the first 1360 x 765, each under 2 MB, 6.4 MB in all). Waiting for Virginie's qualification; she uploads the gallery by hand. Pictures 1 and 2 are close (the roof keeps the interior independent of the hour); picture 3 differs by the pose and the darker outside.


**Sanctuary migration and root clean-up, 2026-10-08.** Place steps now use `Nelim's Sanctuary:` (SanctuaryBacklot); decor, camera, eclipse, presentation and `stands at` stay `Nelim's Pickle Tools:`. `wsl-deps.sanctuary.map` is the Backlot minimum map plus ColonistRace; AB seed in `Tests/Pickle/config/sanctuary/`. Runs on that map: `2292` (watchdog timeout, 2 of 3 scenarios, pictures 1 and 2 unchanged in look), `c738` red (Nelim 28 cells away after 90 s, cause not established), `1485` green after starting her in the hut: she sat south of the ball, seen from behind, so picture 3 stays the one of `7e76` (seat beside the ball, profile visible). Faces: no step sets eye colour or expression yet. `_tools/` became `scripts/`; build intermediates moved to `Tests/Pickle/.build/`; `.build/` removed from the root.


**Last code-review SHA:** `28a9acb536f5f84963ddbc6555069adaf66f95ab` (2026-10-05, from `0.1.0`); later commits are not reviewed yet. French description tweak (Virginie's reviewer, 2026-10-08): `on s’assied devant elle` replaces `on s’y assied`; ModIcon-source unchanged since the last render (outputs byte-identical after a re-render, only the .ico files differ). Gallery pictures renamed `<n>-candidate-<name>.png` until she qualifies them.


**French validated, 2026-10-08.** Virginie validated the translation with the `devant elle` wording (`CB_CrystalBall.description`, commit `17678e8`). `translation_fr` stays `complete`. A French in-game pass on this text is still to replay before the publish.


**Code review, 2026-10-08** (`/code-review` at low effort, from `28a9acb` to `f0bdfbb2bf1e0ad8e13211b121f056945cfcc57a`): three findings, not fixed yet: (1) `Tests/Pickle/README.md` still names the deleted `wsl-deps.workshop.map` and `.build/`; (2) the header of `Tests/Pickle/wsl-deps.sanctuary.map` says Venus is left out; (3) scenario 3 stands Nelim on the Daylily cell. **Last code-review SHA: `f0bdfbb2bf1e0ad8e13211b121f056945cfcc57a`.** State: stage `published`, version `1.0.1` in preparation (CHANGELOG section dated 2026-10-08, French validated, gallery candidates and the French in-game pass pending, run `bd3e` in queue).


**Gallery candidates, 2026-10-08.** Run `bd3e` (`Tests/Pickle/Evidence/2026-10-08-hut-gallery-venus-2`, Backlot map with Venus, EyeGenes and face kit; 3 of 3) was opened: Nelim sits east of the ball in picture 3, profile visible; the three pictures are in `Art/Gallery/` as `<n>-candidate-<name>.png` (1.9 to 2.0 MB each, 6.4 MB in all) and wait for Virginie's qualification. Review findings: README and map header fixed; the Daylily cell is kept (scenario 3 stood there and passed), `no_change_needed`.


**Gallery candidates replaced, 2026-10-08.** Run `8d29` (`Tests/Pickle/Evidence/2026-10-08-hut-gallery-venus-4`, map held at 20 degrees, expression `normal` before the shot, bookcase and two small sculptures added, one blocking the cell south of the ball) was opened: face less flushed, Nelim in profile beside the ball in picture 3. The candidates in `Art/Gallery/` are these; Virginie still qualifies.


**Gallery picture 4, 2026-10-08.** Run `bd93` (`Tests/Pickle/Evidence/2026-10-08-hut-glow-2`, feature `07-workshop-glow.feature`) was opened: the hut at 23:00 without torch, the ball's halo visible, Nelim as a mage (violet cape and hood, sleepy lids) seated east of the ball in profile. A psyfocus staff given by the carry step was dropped by the sitting job (run `b029`): dropped. Saved as `Art/Gallery/4-candidate-the-ball-glowing-in-the-dark.png` (1.46 MB; the gallery weighs 7.88 MB in all); Virginie qualifies it.


**Gallery qualified, 2026-10-08.** Virginie validated pictures 1, 3 and 4 (the ball by day, the colonist gazing, the ball glowing in the dark) and refused 2 (the same view as 1, closer). The gallery is now `0-preview`, `1-the-ball-by-day`, `2-a-colonist-gazing`, `3-the-ball-glowing-in-the-dark` (5.9 MB); she uploads it by hand. Scenario 2 of `05-workshop-captures.feature` stays as a photograph nobody uses.


**Evidence trimmed, 2026-10-08.** Kept in `Tests/Pickle/Evidence/`: `2026-10-08-hut-gallery-venus-4` (run `8d29`, pictures 1 and 2 of the gallery) and `2026-10-08-hut-glow-2` (run `bd93`, picture 3), plus the three 2026-10-02 folders. The folders cited above for runs `7e76` and `bd3e` and every other hut, probe and sanctuary run of 2026-10-05 to 2026-10-08 were deleted once newer runs replaced them (about 550 MB); their points are repointed to `8d29` and `bd93`.


**English wording, 2026-10-08** (review of the published texts): three sentences reworded in `PUBLICATION.md` and `Mod/About/About.xml` (`a colonist tires of ten chess tables exactly as quickly as of one`; `colonists sit down in front of the crystal ball instead of pulling up a dining chair`; `it takes a quality, so its beauty scales and a masterwork crystal ball receives a name`), the same chair line in `README.md`, and the opening of `PUBLICATION.md` in the past tense for 1.0.0. The French needs no change. The `About.xml` edit lands while the full passes `68c7` and `8acb` wait in the queue: text only, no def or asset touched.


**Gallery uploaded, 2026-10-08.** Virginie updated the Steam gallery by hand with `Art/Gallery/0-preview.png` to `3-the-ball-glowing-in-the-dark.png`.


**Dry-run 1.0.1, 2026-10-08:** run `37839358655` (https://github.com/vbardales/Rimworld-Crystal-Ball/actions/runs/37839358655), SHA `c090e2fa7a1cb64e7a19416e43e2e5443c0a333d`, version `1.0.1`, `update_preview` and `update_description` on: green. Log read: change note of section 1.0.1, preview 568,210 bytes (sha256 `56f01ec6…`, differs from the page), description 2,810 characters (the provenance sentence of the texture differs from the page), `DRY RUN: nothing was sent to Steam`. Fail fast chosen by Virginie: the full English and French passes (`8acb`, `68c7`) run after the publish. Rollback target `7d64a56491d7f131ec5770342f65875d993f8279` (v1.0.0).


**Publish 1.0.1 launched, 2026-10-08:** run `37839600085` (https://github.com/vbardales/Rimworld-Crystal-Ball/actions/runs/37839600085), SHA `c090e2fa7a1cb64e7a19416e43e2e5443c0a333d`, `--preview --description`, waiting for Virginie's approval of `steam-production`. Launched with `dispatch-publish.sh` run through `tr -d '\r'` (the script of Rimworld-Release-Admin has CRLF line endings on this checkout and fails under bash otherwise; the file was not modified).


**Code review, 2026-10-08 (second)** (`/code-review` at low effort, from `f0bdfbb` to `302e6d8593e3ae17bc191c3823819bbd5a033cfc`): four findings, all on test-side files, none on the shipped `Mod/`: stale pasted lines in `Tests/Pickle/wsl-deps.sanctuary.map`; scenario 2 of `05` plays a refused picture; `07` header says picture 4 (now 3); the seat side of the gazing pictures is not deterministic. Not fixed yet (the publish is waiting for approval; a test-side fix does not change `Mod/`). **Last code-review SHA: `302e6d8593e3ae17bc191c3823819bbd5a033cfc`.**


**PUBLICATION.md gallery section corrected, 2026-10-08:** it no longer says the hut feature was not played nor that no picture is final; it states that the pictures were qualified by Virginie and uploaded.


**Published 1.0.1, 2026-10-08:** publish workflow run `37839600085` (dry-run `37839358655`), SHA `c090e2fa7a1cb64e7a19416e43e2e5443c0a333d`, `update_preview` and `update_description` on, approved by Virginie; jobs `publish` and `tag-and-release` green; tag `v1.0.1` and GitHub release created by the CI (https://github.com/vbardales/Rimworld-Crystal-Ball/releases/tag/v1.0.1). Public page https://steamcommunity.com/sharedfiles/filedetails/?id=3806709786 read after the publish: it carries the reworded sentences (tires of ten chess tables, sit down in front, receives a name) and the texture provenance. Gallery uploaded by Virginie earlier the same day. Stage back to `published` (version 1.0.1); the full passes of fail fast are pending. Rollback target `7d64a56491d7f131ec5770342f65875d993f8279`.


**Code-review fixes, 2026-10-08 (second review):** the pasted Backlot lines were removed from `wsl-deps.sanctuary.map`; scenario 2 of `05-workshop-captures.feature` (refused picture) was removed and the scenarios renumbered 1 and 2 (the gazing screenshot is now named `workshop 2 - a colonist gazing`); the header of `07-workshop-glow.feature` now says picture 3. The seat side (west or east of the ball) stays random: fixing it would add a sculpture beside the ball and change the validated pictures, so it is documented in the headers (`skipped`). Test-side only; `Mod/` is untouched. The queued full passes `8acb` and `68c7` stage the working tree at play time and therefore play 16 scenarios, not 17.


**Seat side fixed, 2026-10-09.** New Pickle step `Crystal Ball: the joy giver sends {string} to the ball {string} to sit on its {west|east|north|south} side` (`Tests/Pickle/Source/CrystalBallSteps.cs`): it aims the sitting cell (`targetB`) of the giver's job at the side asked for and fails, naming why, if the cell is not free. Used in `05-workshop-captures.feature` (west) and `07-workshop-glow.feature` (east), the sides of the qualified pictures. Run `b3fb` (`Tests/Pickle/Evidence/2026-10-09-seat-west`, green, capture read): Nelim west of the ball, cell (140, 77), in profile as in picture 2. Run `3b46` was red on a vanilla NullReference of a far chicken (`Pawn_FlightTracker.Notify_JobStarted`, (159, 222)) during the 2500-tick wait, before the scene: the gazing scenario now sets the hour to 18 instead of waiting. The east side (`e7e1`) and the full passes (`8acb`, `68c7`) are queued. The second review's finding 4 (random seat side) is now fixed, not skipped.



**Second code review closed, passes queued, 2026-10-09.** The four findings of 2026-10-08 (second) are fixed on test-side files: map header, refused scenario removed, picture numbers (commit `5a88670`); seat side of the gazing picture made deterministic, west/east side and hour set by the scenario (commit `fdb8b05`). Pickle requests: `8acb` (English, no filter, label 1.0.1 English full pass 5f9715d, owner now this session) and `c525` (`sanctuary` pass, English, no filter, `-DepMap wsl-deps.sanctuary.map`, `-NoBatch`, evidence `Tests/Pickle/Evidence/2026-10-09-final-sanctuary`, commit `451f9a0`), both in queue. French pass `68c7` green. A red is a defect of the published 1.0.1.


**Review follow-up, 2026-10-09.** `FRENCH_REVIEW.md` regenerated by `scripts/Make-FrenchReview.ps1` (revision `17678e8`, the validated French; the review line stays empty, hers). `PUBLICATION.md` 1.0.1 wording put in the past tense (`Both were enabled for 1.0.1`, `1.0.1 went out`). No change to `Mod/`. Virginie's review of `PUBLICATION.md` and `CHANGELOG.md` as a whole is not recorded.


**Back to published[1.0.1], 2026-10-09.** No 1.0.2 material: `git diff v1.0.1..HEAD -- Mod` is empty (only test-side files, docs and STATUS changed since the tag), `CHANGELOG.md` `[Unreleased]` is empty, and the only idea in `BACKLOG.md` (a stronger night glow) is not started. New rule (Virginie, 2026-10-09): after `published`, the field carries the published version, `published[1.0.1]`.
