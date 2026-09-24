# Pickle runs: one line per run

The reports are evidence kept **on disk** under `Tests/Pickle/Evidence/`, which is ignored by git: captures and
`Player.log` make it grow without limit, and the disk is nearly full. The root `AGENTS.md` ("Test evidence") asks for
the history as one text line per run in this folder, never as folders. `TESTING.md`, "Evidence to keep", says which
files stay and how they are trimmed.

A run is a request dropped with the ticket dispatcher's `Submit-PickleRun.ps1`. `exitReason` is read before the counts,
and the scenario played is compared with the one asked for.

| Request | Played | Pass | Asked for | Revision | exitReason | Scenarios | Verdict |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `20260924-164920-299-ce54` | 2026-09-24 23:12 | English, all DLCs, no optional mod (`sans-facultatifs`) | exploration 1: `::the mod loads and the game holds its four defs` | `bb3c924` | `passed` | 1 of 1, 20.7 s | **Green.** The mod loaded, its four defs were in the game, no error and no warning from the mod. The startup log holds two lines about the test companion and none about the mod: a warning that its dependency on `nelim.crystalball` has no download URL, now fixed, and an error that it "did not load any content", which JoyRescue's log holds in the same form. Evidence in `2026-09-24-explore-1-smoke/`, `messages.ndjson` and `report.html` dropped once read. |
