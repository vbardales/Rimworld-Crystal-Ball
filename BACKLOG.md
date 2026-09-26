# Backlog

Ideas for a later version, none started. Each one changes `Mod/` unless said otherwise, so it goes out as a new patch
(`1.0.1` or later) with its own non-regression, never as an edit of the published `1.0.0` (commit `7d64a56`).

## Stronger night glow

- **Why:** the Workshop pictures of `1.0.0` (`Art/WorkshopScreenshots/02-the-ball-at-night.png`) show a faint glow at
  night, while the description promises a landmark. Also, at the game's closest zoom the ball is only about 30 pixels wide.
- **Idea:** raise the glow's radius or intensity a little, without turning the ball into a lamp (the description says it
  does not replace one).
- **To check first:** how the glow value is read by the game and by the colony's light-dependent mechanics, so a stronger
  glow does not change what the colonists do, and whether a stronger one still fits "faint" in the text.
- **Then:** replay the three passes and retake `Art/WorkshopScreenshots/02-` (`05-workshop-captures.feature`).
- **Origin:** Virginie's request, 2026-09-26.
