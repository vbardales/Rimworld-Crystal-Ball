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
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
upstream_mod_remotes: N/A
dependencies: none
showcase:     complete
tested_on:    2026-09-25, in game through Pickle in the WSL (RimWorld 1.6.4871): 11 scenarios of 11 played and green, English and French, revisions f72ecd6 (ten in the two full passes) and 8ecaf70 (the save scenario, corrected); plus the 3 Workshop-picture scenarios of `05-workshop-captures.feature`, a conditional feature (`@requires:nelim.pickletools.screenshotstudio`) played in its own pass `workshop` on PickleTools' zen studio, revision 768ae50, green; the info-card review scenario added and played green 2026-09-26 (run 145b); non-regression of the published 1.0.0 (commit 7d64a56) played 2026-09-26 in all three passes, English and workshop green outright, French green after replaying one flaky scenario (docs/runs/README.md, runs d421, dcd5+519c, 0f99)
workshop:     3806709786
published_on: 2026-09-26, version 1.0.0 by the publish workflow (run 36232486752, SHA 7d64a56491d7f131ec5770342f65875d993f8279, dry-run 36232421213, description sent), tag v1.0.0 and GitHub release created by the CI. Made public by Virginie on 2026-09-26; the gallery (Art/WorkshopScreenshots/) and the subscriptions are hers, by hand.
remaining:
  - none: nothing is pending on 1.0.0; ideas for a later patch are in BACKLOG.md
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
updated:      2026-09-28
---


# Crystal Ball — status

## Current position (2026-09-28)

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
workflow audits) are in `docs/STATUS-HISTORY.md`.

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

