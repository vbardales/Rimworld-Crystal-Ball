# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [1.0.0] — unreleased

On release: create the `v1.0.0` tag and the matching GitHub release.

First version, for RimWorld 1.6. It has been played in a real game through Pickle, in English and in
French, with every scenario green (`docs/runs/README.md`).

### Added

- **Crystal ball**, a buildable recreation source costing 40 jade and 5 gold, at neolithic tech
  level and with no research prerequisite. Takes a quality, is minifiable, and glows faintly and
  permanently at radius 3.
- **Divination**, a recreation type of its own — the point of the mod. Tolerance is counted per
  type and expectations ask for up to six different ones, so an eleventh type is worth more than
  another piece of furniture on a type the colony already has.
- French translation.

### Notes

- No assembly. The behaviour is the base game's own chess-table pair,
  `JoyGiver_InteractBuildingSitAdjacent` and `JobDriver_SitFacingBuilding`, which apply unmodified
  because a crystal ball is a `Building`.
- `requireChair` is false, as for the vanilla game of stones and campfire storytelling.

### Repository only

Nothing here reaches a player.

- A test suite, `_tools/Run-Tests.ps1`: twenty-five tests, no RimWorld launched. It reads the
  game's own classes and data to check what the mod assumes rather than what its prose claims, and
  every test in it has been seen to fail against a deliberately broken copy.
- A second suite, `_tools/Run-Functional-Tests.ps1`: eleven tests on what the game does with
  these defs rather than on their shape. It reads the IL of the vanilla driver, builds the joy
  giver through the game's own accessor, and scans every method body in the game to find which
  class reads each setting the mod writes — which is how an inert setting, one nothing on its
  code path ever reads, gets caught.
- `TESTING.md`, the fifteen scenarios only a running colony can settle, and where each one is settled.
- A Pickle suite, `Tests/Pickle/`: four features and a step assembly, eleven scenarios for a real
  game, with a checker that compiles every step pattern with Pickle's own engine. Played in English
  and in French on 2026-09-25, all green. The claim that no DLC is required is proved offline instead,
  by a test of `_tools/Run-Tests.ps1` that fails on any def, template or class only a DLC defines.
- `docs/runs/README.md`, one line per Pickle run, and `docs/PROTOCOLS-READ.md`, which workflow
  documents were read and at which revision.

## [0.1.0] — 2026-09-23

- Creation of the `PublishedFileId.txt` file (`Mod/About/PublishedFileId.txt`): the Workshop item
  exists, id `3806709786`. It was created by the prepublication and Steam keeps it private until
  it is switched by hand.

The content of this version is `Mod/` as it stood at commit `3d1243e`, the last commit before the
item was created, and nothing tracked in it has changed since: it is the first version described
above. On release of 1.0.0, the tag and the GitHub release are created from that section, not from
this one.
