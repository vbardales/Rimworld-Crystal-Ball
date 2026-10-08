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
stage:        published
workflow_stage: published
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    2026-09-25, in game through Pickle in the WSL (RimWorld 1.6.4871): 11 scenarios of 11 played and green, English and French, revisions f72ecd6 (ten in the two full passes) and 8ecaf70 (the save scenario, corrected); plus the 3 Workshop-picture scenarios of `05-workshop-captures.feature`, a conditional feature (`@requires:nelim.pickletools.screenshotstudio`) played in its own pass `workshop` on PickleTools' zen studio, revision 768ae50, green; the info-card review scenario added and played green 2026-09-26 (run 145b); non-regression of the published 1.0.0 (commit 7d64a56) played 2026-09-26 in all three passes, English and workshop green outright, French green after replaying one flaky scenario (docs/runs/README.md, runs d421, dcd5+519c, 0f99)
workshop:     3806709786
published_on: 2026-09-26, version 1.0.0 by the publish workflow (run 36232486752, SHA 7d64a56491d7f131ec5770342f65875d993f8279, dry-run 36232421213, description sent), tag v1.0.0 and GitHub release created by the CI. Made public by Virginie on 2026-09-26; the gallery (Art/Gallery/) and the subscriptions are hers, by hand.
remaining: []
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
updated:      2026-10-02
---


# Crystal Ball — status (2026-09-28)

**Stage `published`.** Version `1.0.0` was sent to Steam by the publish workflow on 2026-09-26 (run 36232486752, commit
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

