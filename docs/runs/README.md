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
