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
| Offline suites | 25 of 25 and 11 of 11, re-run 2026-09-26 | `_tools/Run-Tests.ps1`, `_tools/Run-Functional-Tests.ps1` |
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
  `Art/Preview.png`, `Art/preview-copy.json`, `Art/preview-palette.json`, `Art/echo.png`, and the transparent
  `Art/ModIcon-cutout.png`; `Mod/About/Preview.png` is byte-identical to `Art/Gallery/0-preview.png`.
- Offline suites replayed today: `_tools/Run-Tests.ps1` 25 of 25, `_tools/Run-Functional-Tests.ps1` 11 of 11. No game launched.
- `.dds`: not in git (ignored by `*.dds`, never tracked). The cache file the game wrote at
  `Mod/Textures/Things/Building/Joy/CrystalBall.dds` was deleted from disk; the game regenerates it.
- `PublishedFileId.txt` exists and is committed (item 3806709786), so `CHANGELOG.md` already opens on `1.0.0` over `0.1.0`
  (append-only, not touched).
- Original mod: `upstream_mod_remotes: N/A`, `licence: original`. No upstream repository, so no pull request is owed.
- Gallery folder renamed to the current rule (single digit, `0-` = copy of the Preview): `PUBLICATION.md`,
  `BACKLOG.md` and `Art/Crop-WorkshopScreenshots.ps1` follow. `publish.config.json` points at the folder, not at names.
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

Stage stays `published`: `1.0.0` is unchanged on Steam. Commit `5c0b282` replaces `Mod/Textures/Things/Building/Joy/CrystalBall.png` with Virginie's hand-painted texture (source `Art/CrystalBall-source.png`). Offline suites 25/25 and 11/11 green on it. Pickle requests dropped on `5c0b282`: `20261002-093456-420-41eb` (`workshop` pass, new gallery captures) and `20261002-093457-974-d5fe` (full English pass); results not read yet. Still to do before a `publish`: read both reports, upload the new gallery pictures by hand, `CHANGELOG.md` `[Unreleased]` dated and versioned, dry-run of the exact SHA, rollback target `7d64a56`.

**Preview and gallery, Virginie, 2026-10-02.** She regenerated `Mod/About/Preview.png` and `ModIcon.png` (`Art/echo.png`, `Art/preview-copy.json`, `Art/Preview-layout.html`) and moved the gallery to `Art/Gallery/` (`0-preview.png` a copy of the Preview, `.github/publish.config.json` `galleryDir` follows). These landed in commits `17283c4` and `800b8aa` under unrelated messages (swept in by `git add -A`); the work is hers. Reference revision for the two Pickle requests is therefore `800b8aa` or later, not `5c0b282`: `Mod/About/` images differ, nothing else in `Mod/`. She is still iterating on the Preview, so `Art/Gallery/0-preview.png` must be re-copied from `Mod/About/Preview.png` before any publish.

**French corrected, 2026-10-02**, on Virginie's review: the description had two masculine agreements (`d'eux-mêmes`, `on ne s'est assis`), now reworded with none (`de leur propre initiative`, `pour se divertir`, `on s'y assied`). Her proposed text, verbatim. `translation_fr` stays `partial` until she validates the corrected text in `FRENCH_REVIEW.md`; the French file changed, so the tickets `41eb` and `d5fe` (staged before this edit if already played) do not cover it, and a French pass is owed.

**French review line, 2026-10-02** (recorded from Virginie's message in chat; the review line of `FRENCH_REVIEW.md` is hers and stays empty): reviewer Virginie, revision reviewed `fb1adb2`, corrections requested earlier the same day (two masculine agreements, `en loisir`), applied verbatim; verdict: validated, neutral, natural and faithful. `translation_fr` is `complete`.

**French pass, 2026-10-02** (ticket `afe0`, no optional mods, French): `exitReason: passed`, 12 of 15 passed, 0 failed, 3 skipped (the three `workshop` captures, a conditional feature played in the `workshop` pass). The info-card capture was opened: the corrected description reads in French with no masculine agreement. Evidence `Tests/Pickle/Evidence/2026-10-02-texture-french`. The `workshop` pass for the RimWorld-style texture is ticket `1462`; `41eb`, `d5fe` cover the previous texture.
