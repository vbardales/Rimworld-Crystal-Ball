---
mod:          Crystal Ball
packageId:    nelim.crystalball
repo:         Rimworld-Crystal-Ball
remote:       https://github.com/vbardales/Rimworld-Crystal-Ball.git
local_path:   C:\Users\nelim\Documents\rimworld\CrystalBall
visibility:   public
detached:     yes
stage:        done
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
dependencies: none
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: the fifteen manual scenarios in TESTING.md have no recorded in-game pass
  - unverified: chairless use and the vanilla chair alert (scenarios 5 and 6)
  - unverified: Workshop publication and in-place showcase review
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
updated:      2026-09-12
---

# Crystal Ball — status

This file is maintained by the Codex task responsible for this repository. Update it after
changes, test runs and release decisions. It stays outside `Mod/` and is not shipped to Steam.

## Repository identity

Verified on 2026-09-12: the Git root is `C:\Users\nelim\Documents\rimworld\CrystalBall`,
with its own `.git` directory and no Git superproject. This task manages this single local
repository, no longer the former monorepo. Origin fetch and push both point to the remote above.
GitHub reports `PUBLIC` through `gh repo view --json name,visibility,url`.

The mod title is **Crystal Ball**, author **nelim**, packageId **nelim.crystalball**.
No continuation or fork suffix is justified by the provenance documented here: this is presented
as an original mod, not a maintained copy of someone else's mod. Keep the title unchanged.
The GitHub link is present in both `About.xml`'s `url` and, after this audit, its description.

## Licence and justification

The actual licence is **MIT**, copyright (c) 2026 nelim. `LICENSE` and `Mod/LICENSE` carry
that licence. `licence: original` is the status catalogue's provenance category, not a licence name.

The repository credits original defs and vector texture made with Claude Code and a preview made
with DALL-E under human direction. Its behaviour references vanilla RimWorld classes; it ships
no game assembly or third-party mod code. That documented provenance supports keeping the
existing MIT licence: it allows reuse and continuations while retaining the copyright and licence
notice. This audit confirms the files and credits, not an independent history of every asset.
No additional attribution file or third-party licence is present.

## Validation

Two relevant offline suites live in this repository and use the installed RimWorld data and
assembly, without relying on the former monorepo or launching a colony:

- `_tools/Run-Tests.ps1`: 24/24 passing on 2026-09-12 after the description edit.
  Covers metadata, images, all four defs, XML fields, class and def references, inheritance,
  recreation settings and French translation keys and values.
- `_tools/Run-Functional-Tests.ps1`: 11/11 passing on 2026-09-12.
  Checks vanilla worker/driver construction, Building compatibility, setting readers,
  recreation accounting and values against vanilla definitions. These are offline checks,
  not played functional scenarios.

Run with `powershell -NoProfile -ExecutionPolicy Bypass -File` followed by the script path.
The relevant XML is covered by the first suite, including About parsing, defs and translations.
There is no custom C# assembly requiring a separate mod-code unit-test suite.

`TESTING.md` contains **15 manual functional scenarios**, with setup, steps and expected results:
loading/building, appearance/glow, quality, autonomous recreation, chairless use, chair alerts,
capacity, tolerance/variety, sight, room ownership, moving, pathing, room role, French and saves.
They exist but have no recorded in-game execution result. Keep `tested_on` empty until an actual
run records the game version, scenarios, outcomes and relevant log evidence. Prior notes about
never having loaded the mod or Workshop publication are not fresh checks of external state.

`stage: done` means implementation complete, not in-game validation complete.
The remaining categories are `feature`, `defect` and `unverified`.

## Preview overlay — 2026-09-12

Recomposed according to `../STYLE_RIMWORLD.md`, preserving the existing title and summary.
The existing text-free `Art/Preview-source.png` was visually inspected and copied unchanged to
`Art/Preview.png`. No illustration replacement or generation; the original remains at its
existing path. The delivered overlay is `Mod/About/Preview.png`.

- Composition and layout parameters: `Art/Preview.html`; render and verification script:
  `Art/render-preview.cjs` (Node.js with playwright, sharp and installed Chrome; run from any
  directory with those packages resolvable). Serve the repository over HTTP for manual viewing.
  The former `_tools/preview/Preview.html` now points to the maintained composition.
- Colour reference: `Art/preview-palette.json`, loaded directly by the HTML. The vivid accent
  comes from the cyan rim across the upper crystal ball, with saturation strengthened. This cyan-green accent separates clearly from the dominant blue-indigo atmosphere and secondary ink at both review sizes. The secondary ink uses
  the blue-indigo family spread across the stone wall and wooden floor, lightened while
  retaining its colour. The veil takes a dark, slightly desaturated shade of those surfaces.
  No tag is displayed: the mod is public and original.
- Typography verified through Chrome's platform-font API after `document.fonts.ready`:
  Segoe UI Semibold for the 46 px / 600 title, Segoe UI regular for the 21 px summary,
  Segoe UI Bold for the 26 px badge. No fallback. Title and summary use identical ink.
- Badge version read from the delivered About.xml: highest declared stable version, 1.6.
  Triangle and rotated text use the guide's coordinates. Dark-veil gradient and shadows
  follow the guide; no shadow on badge digits.
- Visual inspection passed at 896 x 504 and 268 px wide: title and version identifiable,
  rule visible, no overlapping or clipped text; the summary remains intended for full size.
- Contrast measured on `Art/preview-background.png`, rendered with text hidden. Minimum over
  every pixel of the title/summary rectangles (stronger than just four corner samples):
  title 14.71:1, summary 15.01:1; badge ink on opaque accent 10.91:1. All exceed 4.5:1.
  Tag contrast is not applicable because no tag is present.
- QA evidence: `Art/preview-qa.json` and `Art/Preview-268.png`. Final PNG: 498,300 bytes,
  below 900 KB. Nothing published.

The revised title hierarchy was checked: both words in Crystal Ball are essential title words,
so both retain 46 px / 600 in primary ink. There are no prefixes, suffixes or linking words
to reduce, and no status tag. Illustration, exact title and summary remain unchanged.
