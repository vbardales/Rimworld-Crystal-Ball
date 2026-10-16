# Backlog

Ideas for later version, none started. Each change `Mod/` unless said otherwise, so ship as new patch
(`1.0.1` or later) with own non-regression, never edit published `1.0.0` (commit `7d64a56`).

## Stronger night glow

- **Why:** Workshop pictures of `1.0.0` (`Art/Gallery/2-the-ball-at-night.png` of 1.0.0, removed from gallery on 2026-10-08) show faint glow at
  night, while description promises landmark. Also, at game's closest zoom ball only about 30 pixels wide.
- **Idea:** raise glow radius or intensity a little, without turning ball into lamp (description says it
  does not replace one).
- **To check first:** how game and colony's light-dependent mechanics read glow value, so stronger
  glow does not change what colonists do, and whether stronger one still fits "faint" in text.
- **Then:** replay three passes and retake `Art/Gallery/2-` (`05-workshop-captures.feature`).
- **Origin:** Virginie's request, 2026-09-26.