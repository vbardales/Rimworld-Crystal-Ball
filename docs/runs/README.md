# Pickle runs: one line per run

The reports are evidence kept **on disk** under `Tests/Pickle/Evidence/`, which is ignored by git: captures and
`Player.log` make it grow without limit, and the disk is nearly full. The root `AGENTS.md` ("Test evidence") asks for
the history as one text line per run in this folder, never as folders. `TESTING.md`, "Evidence to keep", says which
files stay and how they are trimmed.

A run is a request dropped with the ticket dispatcher's `Submit-PickleRun.ps1`. `exitReason` is read before the counts,
and the scenario played is compared with the one asked for.

| Request | Played | Pass | Asked for | Revision | exitReason | Scenarios | Verdict |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `20260926-221303-690-dcd5` | 2026-09-26 | French, all DLC, no optional mod (`sans-facultatifs`) | non-regression of the published 1.0.0, every scenario, no filter | `b400a22` (Mod as published `7d64a56`) | `failed` | 11 of 15, 1 failed, 3 skipped | **Red on one scenario, then green on replay.** `a colonist builds the ball from jade and gold with no research`: the blueprint at (146, 157) sat waiting for material for the full 180 s timeout, no exception. The other eleven scenarios pass, the info card one included, and the three skipped are the workshop ones (played in their own pass, `0f99`). Replayed alone (`519c`), green in 44 s: the same colonist, jade and gold, this time built. Read as flake, not a defect: nothing in `Mod/` or the step changed between the two runs, and the English pass of the same commit built cleanly in 38 s. Evidence in `2026-09-26-nonreg-french/` and `2026-09-26-replay-build-french/`, `report.html` and `messages.ndjson` dropped from both. |
