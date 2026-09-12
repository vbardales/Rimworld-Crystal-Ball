---
mod:          Crystal Ball
packageId:    nelim.crystalball
repo:         Rimworld-Crystal-Ball
visibility:   public
detached:     yes
stage:        done
licence:      original
licence_at:   an original creation, MIT
dependencies: none
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: the fifteen scenarios of TESTING.md, none played
  - unverified: does a colonist use the ball in a room with no chair at all (scenario 5)
  - unverified: does the vanilla alert for chairless recreation buildings name the ball (scenario 6)
  - unverified: never uploaded to the Workshop, so the showcase has never been seen in place
session:      local_f3be24f6-fe14-4195-bd8c-b3dc8946784c
updated:      2026-09-12, the mod's own session
---

# Crystal Ball — status

Status card, read by a pass over every mod rather than by asking each thread one at a time. It
lives at the root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. The ones the pass could not read were
filled the same day:

- **`stage`** — `done`, confirmed. Released as 1.0.0 on 2026-09-04, public, a repository of its
  own since 2026-09-11, covered by thirty-five offline tests that pass. What is left is not
  development.
- **`licence`** — `original`, where the pass had left a question mark for want of an
  `ATTRIBUTION.md`. There is none because there is nothing to attribute: four defs, a texture
  drawn for it, MIT. The behaviour is Core's chess table, which is a use of the game rather than a
  borrowing from a mod.
- **`dependencies`** — `none`. No DLC, no framework, no assembly. The About declares one
  `loadAfter`, on `Ludeon.RimWorld`, which is vanilla and nothing to declare.
- **`tested_on`** — left empty, and that is exact: nobody has ever seen this ball run. No colony
  has loaded it, and the packageId is in no `ModsConfig.xml`. The junction into `RimWorld/Mods` is
  in place, though.
- **`workshop`** — empty, and exact too: no `PublishedFileId.txt` in `Mod/`, so nothing has ever
  been uploaded. The showcase is ready for it all the same, preview image included.
- **`remaining`** — the catch-all line the sweep leaves there is replaced by four. The middle two
  are the mod's only real unknowns. Scenario 5 is the setting that fails silently: `requireChair`
  has exactly one reader in the whole game, and when it does not bite, the symptom is a colonist
  who simply never comes. Scenario 6 is the opposite risk, an alert that could name a building
  needing no chair at all — it inspects one joy giver's buildings and looks for something sittable
  in the four cardinal cells, and whether the ball falls within its reach takes a running colony to
  settle.

So the first run in a colony will empty most of that list at once.

The `remaining` categories: `feature` for something missing from the first pass, `defect` for a
known fault left unfixed, `unverified` for what could not be checked.

The `session` field was not touched: it comes from the sweep.

The `licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` nothing reused.

The `dependencies` vocabulary: `declared` when every mod this one needs is named in the About's
`modDependencies`, `to check` when a non-vanilla `loadAfter` suggests one that is not declared,
`none` when the mod needs nothing. An undeclared dependency is not cosmetic: on 2026-09-11
Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because the class it
injects belongs to a mod that was neither declared nor loaded.
