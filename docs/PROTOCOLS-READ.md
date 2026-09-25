# Workflow documents read, and at which revision

Written by the Crystal Ball session on 2026-09-25, after a compaction of its context, as `WELCOME.md` (point 5) asks:
for each document, the last commit that touched it (`git log -1 --format='%h %ad' -- <file>`), and whether it was
modified and not committed (`git status --short`). When a document has moved since, this is the line that says which rule
the session leaned on. Documents that were of no use are marked, so that they are not read again until they change.

Repositories: `rimworld` is the collection's root (`Documents\rimworld`, HEAD `9afdc758` when this was written); the
others are repositories of their own inside it.

## Read, and useful

| Document | Repository | Version read | Why it matters here |
| --- | --- | --- | --- |
| `AGENTS.md` | rimworld | `90d51374` 2026-09-25 | The evidence rules (keep the latest report per scenario, one text line per run in `docs/runs/`, delete a run's archive afterwards) and the CI publishing rules. |
| `AUDIT.md` | rimworld | `90d51374` 2026-09-25 | The chain and its transitions (steps 9 to 11), the fail-fast policy, reading a translated interface, and the session title `<mod> / <stage>`. |
| `PUBLISHING.md` | rimworld | `90d51374` 2026-09-25 | What `prepublished` needs: description, `PUBLICATION.md`, licence copies compared, `.gitattributes`, thanks, the change note that starts with the version number, the CI section. |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | Rimworld-Release-Admin | `d403592` 2026-09-25 | The manual publish workflow for a mod that already has an item: `generate-publish-workflow.sh ... --require Defs --forbid Assemblies --description-file PUBLICATION.md`, the dry-run, and that the gallery stays manual. |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | Rimworld-Ticket-Dispatcher | `79668cc` 2026-09-25 | Small tickets, no watcher, the request carries no SHA (put it in `-Label`, freeze the tree), how to delete an archive. |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | Rimworld-Ticket-Dispatcher | `79668cc` 2026-09-25 | Every option of `Submit-PickleRun.ps1`, the exit codes (0 is not a verdict), what happens after a request. |
| `PickleTools/Headless/README.md` | PickleTools | `b2712fc` 2026-09-25 | Filter terms, one pass per request, `-EvidenceDir`, the traps (report timestamps in UTC, screenshot names past MAX_PATH). The launcher's internals are not mine to act on. |

## Read, and not useful for this mod (do not reread unless it changes)

| Document | Repository | Version read | Why not |
| --- | --- | --- | --- |
| `TRANSLATIONS.md` | rimworld | `90d51374` 2026-09-25 (file dated 2026-09-13) | Its gate is passed (`localization`, `translation_en`, `translation_fr` are `complete`); it matters again only if a text changes. |
| `STYLE_RIMWORLD.md` | rimworld | `90d51374` 2026-09-25 | About the Preview and the ModIcon, which only the owner generates. Read it again if the preview has to be regenerated or checked. |
| `scripts/SEARCHING.md` | rimworld | `90d51374` 2026-09-25 | Searching the whole Workshop corpus; this mod is original and has no port to check. |
| `PickleTools/README.md` | PickleTools | `2b7b6d0` 2026-09-25 | The table of shared step tools; this suite uses none, its steps are its own and prefixed `Crystal Ball:`. |
| `PickleTools/docs/steps.md` | PickleTools | `d6d8db1` 2026-09-25 | The catalogue of PickleTools' steps. Of possible use only for publication captures (`ScreenshotMode`, `InspectTabs`). |

## In this repository

| File | State when read |
| --- | --- |
| `STATUS.md` | Mine, `stage: tested` since 2026-09-25 (third audit). |
| `README.md`, `CHANGELOG.md`, `Tests/Pickle/README.md` | Read, and three sentences that still said "none has been played" corrected. |
| `TESTING.md` | Mine; every scenario settled and played, see "What `tested` requires". |
| `ATTRIBUTION.md`, `LICENSE` | Read; identical (same SHA-256) to the copies in `Mod/`. |
| `Mod/About/About.xml` | Read; the description lacks the line pointing to `ATTRIBUTION.md` (a defect already in `STATUS.md`). The test companion's `About.xml` read as well. |
| `docs/runs/` | One line per run, up to the corrective rerun of the save scenario. |
| `PUBLICATION.md`, `BACKLOG.md`, `NOTES.md`, `BUGS.md` | **Do not exist.** `PUBLICATION.md` is required by `tested -> prepublished`. |
