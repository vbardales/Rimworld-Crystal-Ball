# Pickle runs: one line per run

The reports are evidence kept **on disk** under `Tests/Pickle/Evidence/`, which is ignored by git: captures and
`Player.log` make it grow without limit, and the disk is nearly full. The root `AGENTS.md` ("Test evidence") asks for
the history as one text line per run in this folder, never as folders. `TESTING.md`, "Evidence to keep", says which
files stay and how they are trimmed.

A run is a request dropped with the ticket dispatcher's `Submit-PickleRun.ps1`. `exitReason` is read before the counts,
and the scenario played is compared with the one asked for.

| Request | Played | Pass | Asked for | Revision | exitReason | Scenarios | Verdict |
| --- | --- | --- | --- | --- | --- | --- | --- |
| — | — | — | **Base for this log: `1.0.0` published**, commit `7d64a56491d7f131ec5770342f65875d993f8279`, tag `v1.0.0`. Full non-regression (English, French, `workshop`) was green on this commit on 2026-09-26; that history is in git before this line (commit `65e22bb` and earlier). Runs from here on start a fresh log. | `7d64a56` | — | — | — |
| — | — | — | Evidence trim 2026-10-02: the 2026-09-25 French pass (revision `f72ecd6`, one scenario red there) removed from disk, superseded by the 2026-09-26 runs; logs of the three kept runs gzipped. No new run. | `7d64a56` | — | — | — |
| `68c7` | 2026-10-08, French, `sans-facultatifs` | 12 of 16 passed, 0 failed, 4 skipped (the four `workshop` captures) | full French pass of `1.0.1` | commit after `5a88670` (run started 22:50 local, `Mod/` unchanged since the publish) | `passed` | 12 of 12 played | green; evidence `Tests/Pickle/Evidence/2026-10-08-final-french` |
| `8acb` | 2026-10-08, English, minimal set | 12 of 16 passed, 0 failed, 4 skipped (the four `workshop` captures) | full English pass of `1.0.1` | commit `5f9715d` (label), `Mod/` unchanged since | `passed` | 12 of 12 played | green; evidence `Tests/Pickle/Evidence/2026-10-08-final-english` |
| `c525` | 2026-10-09, English, `sanctuary` | 15 of 16 passed, 1 failed, 0 skipped | full `sanctuary` pass of `1.0.1`, no filter | commit `451f9a0` | `failed` | the four `workshop` captures green; red: `a save taken with two colonists gazing loads clean...` (`the joy giver offered Save-1 nothing: CanBeGivenTo holds but TryGiveJob returned no job`) | the save scenario belongs to the minimal passes (green in `8acb`, `68c7`); `TESTING.md` plays only `05` in this pass; cause on the Sanctuary map not established; evidence `Tests/Pickle/Evidence/2026-10-09-final-sanctuary` |
