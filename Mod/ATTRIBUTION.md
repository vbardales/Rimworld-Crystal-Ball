# Crystal Ball — attribution

Crystal Ball is an original mod by **Nelim**, package ID `nelim.crystalball`.
Repository: https://github.com/vbardales/Rimworld-Crystal-Ball

## Original work and tools

The repository documents the following contributions, made under human direction
and review:

- The mod's XML definitions were written with Claude Code (Anthropic).
- The in-game crystal ball texture was generated with an AI image model, then cut out, given a dark outline and resized to 256 x 256 under human direction. The generated image is kept in the repository at `Art/CrystalBall-original.png` and the cut-out at `Art/RWBall-cutout.png`. The first version, drawn as vector art with Claude Code, is superseded; its source stays at `scripts/svg/CrystalBall.svg` for history only.
- The Workshop preview illustration was generated with DALL-E (OpenAI).
  Illustration sources and the text-overlay composition are kept under `Art/`.

These credits describe the provenance recorded in the README and mod description.
They do not imply that Anthropic or OpenAI endorses this mod. The available credits
do not identify a separate generation tool for `About/ModIcon.png`.

## RimWorld references, not redistributed game code

Thanks to **Ludeon Studios**, creators of RimWorld. The mod uses the game's existing
recreation behaviour, referring to its chess-table and game-of-Ur implementations:
`JoyGiver_InteractBuildingSitAdjacent` and `JobDriver_SitFacingBuilding`.
Its building definition inherits the vanilla `BuildingBase` template and refers
to vanilla materials, stats and other definitions.

These are references to functionality supplied by the player's RimWorld
installation. This mod ships no game assembly, copied game implementation or
third-party mod code. RimWorld and its content remain the work of Ludeon Studios;
this document grants no rights to redistribute them.

## Licence and continuation

The repository's existing licence is MIT, copyright (c) 2026 Nelim. See `LICENSE`,
included beside this document both in the repository and in the distributed mod.
The licence notice must accompany distributions as required by its terms; it does
not relicense RimWorld or any third-party material.

The author's continuation statement, as recorded in the README, is:

> If I do not answer within a reasonable time after being contacted, anyone may freely update
> this or any other of my mods, including publishing a continuation of it. All credit must be
> preserved.

An identical copy of this attribution accompanies the distributed mod so that
these credits remain available to players and continuation authors.
