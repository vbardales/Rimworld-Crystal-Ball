# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it in game.

## [Unreleased]

### Added

- A test suite, `_tools/Run-Tests.ps1`: twenty-four tests, no RimWorld launched. Nothing a player
  sees changes. It reads the game's own classes and data to check what the mod assumes rather
  than what its prose claims, and every test in it has been seen to fail against a deliberately
  broken copy.

## [1.0.0] — 2026-09-04

First release, for RimWorld 1.6.

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
