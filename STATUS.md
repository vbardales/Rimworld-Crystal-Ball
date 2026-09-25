---
localization: complete
translation_en: complete
translation_fr: complete
mod:          Crystal Ball
packageId:    nelim.crystalball
repo:         Rimworld-Crystal-Ball
remote:       https://github.com/vbardales/Rimworld-Crystal-Ball.git
local_path:   C:\Users\nelim\Documents\rimworld\CrystalBall
visibility:   public
detached:     yes
stage:        tested
settings_audit: not_applicable
licence:      original
licence_at:   MIT; original mod according to repository provenance
license_spdx: MIT
dependencies: none
showcase:     complete
tested_on:    2026-09-25, in game through Pickle in the WSL (RimWorld 1.6.4871): 11 scenarios of 11 played and green, English and French, revisions f72ecd6 (ten in the two full passes) and 8ecaf70 (the save scenario, corrected); see docs/runs/README.md
workshop:     3806709786
remaining:
  - unverified: the description text on the game's info card: the inspect capture shows the name and the quality, not the description, so how it fits the card is not seen (its text is compared with the resources by the language scenario)
  - unverified: the 0.1.0 item was never subscribed to, so its page and showcase have not been seen in place
  - unverified: `tested -> prepublished` not started: the rollback target is not chosen and no `v0.1.0` tag exists (`PUBLISHING.md`, fail fast)
  - defect: the Steam description has no line pointing to ATTRIBUTION.md; SetItemDescription runs at creation only, so it is a by-hand edit on the Steam page (`tested -> prepublished`)
session:      01a09736-2cfc-72d3-8b3c-4ffe79ef572c
updated:      2026-09-25
---

# Crystal Ball — status

## Audit — 2026-09-25, third pass: tested (current decision)

Audited revision `8ecaf70` (`Mod/` unchanged since `3d1243e` except the `PublishedFileId.txt` line), read against the
current `../AUDIT.md`, step `done -> tested`. Offline suites re-run at that revision: `Run-Tests.ps1` 25/25,
`Run-Functional-Tests.ps1` 11/11.

**Previous stage: done. Retained stage: tested.** The suite was played in the game, headless in the WSL, in English and
in French, and every scenario has a green report; the history is one line per run in `docs/runs/README.md`.

| Criterion of `done -> tested` | Result | Evidence |
| --- | --- | --- |
| Functional scenarios played and green | Validated | Eleven scenarios in four features. Both full passes (`c70b` English, `3f8c` French, revision `f72ecd6`) passed ten of eleven; the eleventh, the save, failed in both for a fault of the suite (it asked a full ball for a third colonist), was corrected, and passed on its own run (`01c7`, `8ecaf70`). The other ten are unchanged in the suite since. |
| Pickle suites green, `exitReason` read first, played against discovered | Validated | Each summary read `exitReason` before the counts; eleven scenarios played of eleven in four features, `setName` `sans-facultatifs`, scenario names compared with the ones asked for. |
| `@review` captures opened | Validated, with a gap | Opened: the inspect pane in English ("Crystal ball (normal)", Quality: Normal) and in French ("Boule de cristal (normal)", "Qualité : Normal"), no raw key and no overflow; the ball at night, lit ("Lit (50%)"), the glow visible. The pane shows the name and the quality, not the description: that sits behind the info card and is not captured. The description's text is checked against the French resources by the language scenario; how it fits the card is not seen. |
| Logs | Validated | Only the fixture's warnings (a save from an older build, hidden ritual precepts) and the companion's known lines ("did not load any content", the same in JoyRescue's log). Nothing from the mod. |
| Interface in French and English | Validated | The four texts compared with the mod's own resources in each pass, and the step attached the language it found (`English`, `French (Français)`). |
| Options, MainButtons shortcut | Not applicable | `settings_audit: not_applicable`; the mod has no settings. |
| New game and existing save | Validated | Every run loads a fixture saved before the mod; the save scenario saves with two colonists gazing and reloads. |
| No `@wip`, no conditional scenario, no manual test left | Validated | None in the features; nothing is left to a person, the four scenarios not applicable and the one withdrawn are justified in `TESTING.md`. |
| Corrections followed by regression tests | Validated | The prefix fix of the language step and the save scenario were each replayed green. |

Not verified, and not blocking `tested`: the 0.1.0 item was never subscribed to, so its page and showcase have not been
seen in place; the description card in the game. `tested -> prepublished` is not started: the rollback target is not
chosen and no `v0.1.0` tag exists (`PUBLISHING.md`, fail fast).
## Audit — 2026-09-24, second pass: done (historical, superseded by the one above)

Audited revision `5924c85`, three commits on `5a8fc0b` (`8cc4d2d` the Pickle suite, `ec91a29` the offline
Core test, `5924c85` the documentation), read against the current `../AUDIT.md`, which had not changed
since the first pass. No tracked file differed from HEAD, and nothing under `Mod/` changed since `3d1243e`,
so the results below describe the delivered files.

**Previous stage: preTest. Retained stage: done.** The first pass stopped at `preTest -> done` for one
reason: the Pickle (Gherkin) tests were not written. They are now, with their scope justified in
`TESTING.md`, and every other criterion of the transition holds. `done` means ready for the final in-game
validation. It does not mean tested: **no scenario has been played**, and executing the suite is a
criterion of `done -> tested`, not of this step.

### The transition `preTest -> done`

| Criterion | Result | Evidence |
| --- | --- | --- |
| Functional scenarios written, with preconditions, actions and expected results | Validated | The fifteen scenarios of `TESTING.md`. Ten are written in Gherkin, one is withdrawn, four are not applicable. |
| Automated tests written, run and green | Validated | `Run-Tests.ps1` 25/25, `Run-Functional-Tests.ps1` 11/11, both re-run on `5924c85`. |
| Pickle (Gherkin) tests written, scope justified | Validated | `Tests/Pickle/`: four features, ten scenarios, twenty-two steps. The table "Which scenarios are written as Gherkin, and which are not" in `TESTING.md` says where each of the fifteen is settled. |
| XML tests written, run and green | Validated | `Run-Tests.ps1`, and `Check-DefInjected.ps1` at 4 keys, 0 errors. |
| Every non-applicability justified, no artificial test | Validated | Scenario 6 (the alert cannot name the ball), 10 to 13 (the game's reaction to a flag the mod declares), and the pieces of 8, 1 and 15 named in the table. Each gives its reason in the table, and 10 to 13 name the reader the offline scan finds. |
| Results match the delivered version | Validated | `Mod/` is unchanged since `3d1243e`. |
| No in-game test required for `done` | Noted | The explicit clarification of 2026-09-21. |

### What was done, and how each part was checked without a game

- **The suite compiles.** `dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`
  against the game and Pickle stubs: 0 warnings, 0 errors. The DLL is a build artefact and is ignored.
- **`Tests/Pickle/Check-Steps.ps1`** compiles the 22 step patterns with Pickle's own expression engine and
  resolves each of the 111 step lines to exactly one expression among the suite's, Pickle's 203 and the 746
  of 23 other suites. It passes, and each of its four checks was seen to fail on a broken copy: a pattern
  with an unknown parameter type, a feature line with a typo, a pattern declared twice, a pattern that
  collides with one of Pickle's.
- **A new offline test, 25th of `Run-Tests.ps1`**, proves the claim "no DLC required" statically: every def
  a field points at, every template the def inherits and every class it names must be one Core defines or
  names. Seen to fail on a cost paid in Bioferrite (Anomaly), a comp class only a Royalty def names, and a
  parent template only Odyssey defines; the unchanged copy stays green.
- **The passes fall from three to two**, English and French. The DLC-less pass declared earlier would not
  have played a guard, the mod has none, and it would have had to load a fixture saved with Royalty
  content. `TESTING.md` says so and the static proof replaces it.

### What has NOT been done, and is not a defect

- **No scenario was played.** Whether the spot the suite picks for the ball, the time the build takes,
  the seat a colonist takes, or the tolerance a sitting builds come out as the steps expect is what the
  first run will say. The suite has never touched a game.
- **The machine was not used.** No RimWorld was launched. The Pickle queue held 32 tickets at the last look,
  none for this mod, and the passes each take tens of minutes.
- **The `@review` captures do not exist yet**, so none was opened.

### Next work for the next transition

`done -> tested` needs, per `TESTING.md`: both passes played, English and then French, each as a request dropped with the ticket dispatcher's `Submit-PickleRun.ps1`, which runs `Run-PickleWsl.ps1` under the machine's lock while this session keeps no process and watches nothing (the dispatcher wakes it). The first requests are explorations of one scenario each, and only the two validation passes ask for every scenario; `exitReason`
read before the counts, and scenarios played compared with features discovered; the two `@review`
captures opened; no scenario in `@wip` (none exists) and no `@requires` scenario left unrun (none exists);
the logs read; and a correction followed by the regression run for whatever the first run turns up. Expect
the first run to find something: the suite is written against a fixture it has never loaded.

### Reservations and recommendations, separate from the blockers

- **A namesake on the Workshop**, `CrystalBall (Continued)`, item 2483367722, is unchanged from the first
  pass: no technical clash, a shared name in a search.
- **The description says *This mod is MIT licensed.* without pointing to `ATTRIBUTION.md`**, which the
  prepublished step asks for. Only a by-hand edit on the Steam page changes it now.
- **`v0.1.0` has no tag and no release.** The repository has no workflow, so the CI did not create the item;
  whether 0.1.0 gets a tag is Virginie's call.

## Audit — 2026-09-24, first pass: preTest (historical, superseded by the one above)

Audited revision `3d1243e824686edb5841addcfa72432f7b4e3c51`, equal to `origin/main` (zero ahead,
zero behind), read against the current `../AUDIT.md`. Two files were untracked at entry:
`Mod/About/PublishedFileId.txt`, written on 2026-09-23 at 14:31 by the 0.1.0 prepublication, and
`Mod/Textures/Things/Building/Joy/CrystalBall.dds`, RimWorld's texture cache, written at 14:13. No
tracked file differed from HEAD, so the offline results below describe the delivered files.

**Previous stage: done. Retained stage: preTest.** The 2026-09-13 audit recorded `done` on offline
readiness alone. The step `preTest -> done`, as now worded, also requires the Pickle (Gherkin) tests
to be **written**, with their scope justified. There is no `Tests/` directory in this repository.
Not applicable is not defensible either: what the mod does is a colonist walking over, sitting down
and getting up in a better mood, and every one of the fourteen applicable scenarios is behaviour that only a
running game shows. Every other criterion of the transition holds. Executing the suite is not a
criterion of `done`, only of `tested`.

This is a step back on a paper requirement, not a fault found in the mod: nothing shipped changed.

### Transitions, in order

| Transition | Result | What was checked now |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Validated | Git root is this folder, `origin` is the GitHub repository, PUBLIC, `origin/main` equals HEAD. STATUS, README, CHANGELOG, LICENSE and ATTRIBUTION exist in English. `Mod/LICENSE` and `Mod/ATTRIBUTION.md` are byte-identical to the root copies. Identity coherent. |
| horsMonoRepo -> ModIcon generated | Validated, build not applicable | Four defs, one texture, no assembly. `ModIcon.png` is 128 x 128, 21,171 bytes, opened: a winking amber crystal ball on a stand. Not generated, changed or requested by this audit. |
| ModIcon generated -> Preview generated | Validated | `Preview.png` is 896 x 504, 498,300 bytes, below 1 MB. Opened: title and 1.6 badge readable, subject identifiable, nothing clipped. |
| Preview generated -> preOptions | Validated | English description and title. Cyan accent against the blue-indigo scene, as opened above. No prefix, suffix or linking word to handle. |
| preOptions -> options | Not applicable, justified | No `MainButtonDef`, no settings class or storage in `Mod/`; the fixed values (cost, radius, duration, capacity) are balance choices, not a promised configuration. No empty page or shortcut is registered. The 2026-09-13 inventory below still holds. |
| options -> l10n | Validated | `Run-Tests.ps1` 24/24 with MustTranslate coverage, folder spelling and paragraph breaks; `Check-DefInjected.ps1` 4 keys, 0 errors. |
| l10n -> preTest | Validated | No dependency, DLC, patch or `LoadFolders`; `loadAfter` names only `Ludeon.RimWorld`. |
| preTest -> done | **Not established** | Scenarios written (14 applicable, the sixth withdrawn, with setup, steps, expected results). Automated and XML suites green today on HEAD: `Run-Tests.ps1` 24/24, `Run-Functional-Tests.ps1` 11/11. **The Pickle suite is absent.** |
| done -> tested | Not verified | Nothing played. See the criteria in `TESTING.md`, "What `tested` requires". |

### Prepublication of 0.1.0

The Workshop item exists, id `3806709786`, created by the prepublication Virginie made on
2026-09-23: its id file was written at 14:31. The anonymous Steam API does not return the item,
which fits a private one and proves nothing more.

Two things are not established. How it was sent is not recorded, and neither is whether the item
carries the `.dds` cache file that the game wrote next to the texture PNG at 14:13. An upload from
disk after that time would. The file is a per-machine cache and harmless, and it is now in
`.gitignore`, so it stays out of git whatever the answer.

The id file is committed and pushed (`b26a5ac`, `Add published Workshop file ID for 0.1.0`) and
`CHANGELOG.md` opens on `0.1.0`, with `1.0.0` kept `unreleased` above it. The repository has no tag
and no release, and `1.0.0` had been dated 2026-09-04 as though it had shipped, which it never did:
that is corrected. **Not done here:** a `v0.1.0` tag and release. `AGENTS.md` gives tags and
releases to the CI after an upload it made. This repository has no workflow, so the CI did not make
this one, and whether 0.1.0 gets a tag is Virginie's call.

### Game state, without a run

`nelim.crystalball` is now listed in `ModsConfig.xml`, so the mod is enabled in the game. The
`Player.log` last written on 2026-09-23 at 16:49 holds no line about this mod, and it is not
attributed to any run of it. Neither is evidence of a test, and `tested_on` stays empty. No RimWorld
was launched by this audit: the machine's Pickle queue held 23 tickets, none for this mod.

### Evidence and texture cache

No evidence folder exists on disk and none is in git (`git ls-files` holds no `Evidence` or
`evidence` path, and no run has been played), so nothing was deleted. The rules that will apply are
in place: `Tests/Pickle/Evidence/` and `evidence/` are in `.gitignore`, and `TESTING.md` says which
proofs to keep, where, and how to minify them. No `.dds` was tracked; `*.dds` is ignored so none can
be added by mistake.

### Corrected after a review of this audit, the same day

A code review of the work above found nine things wrong. Five were confirmed by running them and
fixed first, the four others afterwards, each proved on a copy of the mod that has the fault. None
changes what ships.

- **Scenario 6 tested an alert that cannot name the ball.** `Alert_JoyBuildingNoChairs` is abstract
  with two subclasses, chess table and poker table, watching `Play_Chess` and `Play_Poker`. The
  ball's giver is its own. The scenario is now recorded in `TESTING.md` as not applicable with that
  reason, keeping its number, and the `unverified` line that repeated the premise is gone. Fourteen
  scenarios remain applicable, not fifteen.
- **The reader scan of `Run-Functional-Tests.ps1` missed reads by address.** It matched `ldfld`
  only, so a struct field such as `startingHpRange` was reported as read by nothing. Seven of the
  fourteen fields called unread are in fact read. It matches `ldflda` too now, and the fault that
  showed it is the new row of the suite's mutation table.
- **The def-reference test ignored types.** With the JobDef deleted, the giver's reference found the
  giver, which carries the same defName. It now checks name and type, and fails on that copy.
- **Two texts were false.** The suite's header named a field as unread that the game reads, and gave
  timings three to four times too high. Both are corrected.
- **Nested DefInjected handles were split at the last dot.** A correct key such as
  `CB_CrystalBall.comps.0.label` was read as a def called `CB_CrystalBall.comps.0` and failed. A
  defName carries no dot, so the first dot ends it, and the first segment of the path is checked
  as a field. The nested key passes, and fails with `compz` in place of `comps`.
- **The three vanilla comparisons could not tell a decision from a fault.** The only jobs on the
  chess driver are chess and the game of Ur, both at 4000 ticks, so a duration of 3500 failed. The
  allowed range is now that of all vanilla recreation, 1500 to 8000 ticks, 1 to 8 participants and a
  pick chance of 2 to 4, with the values on the same driver named in the message. 3500 ticks and 5
  participants pass, 12000 ticks and 9 participants fail.
- **The cast test walked the templates a second time and only in one folder.** It reads the index
  the suite already builds over every Defs folder. A parent defined outside `ThingDefs_Buildings`,
  `ResourceBase`, is now found and reported as loading as `ThingWithComps`, where it said the def
  resolved to no class at all.
- **The upload path of 0.1.0 was written as fact.** `.gitignore`, this file and the changelog now
  say only what the timestamps show: the game wrote the `.dds` at 14:13, the id file appeared at
  14:31, and how the item was sent is not recorded.

The two suites are otherwise as they were, 24 and 11, both green.

### Next work for the next transition

Write the Pickle suite for the fourteen applicable scenarios, and justify its scope in `TESTING.md`. Start from
`../PickleTools/Authoring/README.md`. Everything above the running game (the defs, the readers of
each setting, the translation keys) is already proved offline by the two suites and does not belong
in Gherkin. That takes the mod to `done`. `tested` then needs the three passes declared in
`TESTING.md`, the fourteen applicable scenarios automated and green or explicitly not applicable, no scenario
left in `@wip`, every `@requires` scenario run (none exists for this mod), and every `@review`
capture opened.

### Reservations and recommendations, separate from the blockers

- **A namesake on the Workshop.** `CrystalBall (Continued)`, item 2483367722, `Mlie.CrystalBall`,
  is an incident-prediction mod with a Production bench, a Scry work type and Harmony. No technical
  clash: packageIds, defNames and texture paths all differ. But a search for "crystal ball" lists
  both, and nothing in this repository records that the name was checked. Worth a sentence in the
  future `PUBLICATION.md`.
- The description says *This mod is MIT licensed.* without pointing to `ATTRIBUTION.md`, which the
  prepublished step asks for. Only a by-hand edit on the Steam page changes it now.
- The icon is amber where the ball is violet. It is a mascot and only Virginie generates icons,
  so this is a remark and not a request.

## Description link fix — 2026-09-13 (historical decision before the audit above)

Committed attribution and audit documentation as
`8401071d250fc2f9258d3914c9c43cab8149be25`, then replaced the raw source URL and
SOURCE CODE heading in `Mod/About/About.xml` with the prescribed final
`[url=https://github.com/vbardales/Rimworld-Crystal-Ball]Source code on GitHub[/url]`
link. This follow-up is a local change to About.xml and STATUS.md only.

Stage: `Preview générée` -> `done`. The description convention defect is resolved;
all cumulative criteria through offline readiness are now established using the
independent validations recorded below. `done` means ready for final in-game
validation, not `tested`.

Verification: `powershell -NoProfile -ExecutionPolicy Bypass -File
_tools/Run-Tests.ps1` returned exit 0, **24/24 passing** after the edit. A separate
XML parse and exact description-suffix assertion passed. The previously verified
GitHub URL is unchanged. The 11 offline behaviour tests, translation-path checks,
settings audit and direct image inspections remain applicable: no behaviour,
Def, translation, settings or image changed. No game run or Workshop update was
performed. The 15 manual scenarios and associated logs/FR/EN/save checks remain
unverified and are required for `tested`.

## Attribution fix — 2026-09-13 (historical decision before description link fix)

Added English `ATTRIBUTION.md` and an identical distributed copy at
`Mod/ATTRIBUTION.md`, with a README link. The document records the existing author
and AI-tool credits, distinguishes vanilla behaviour references from redistributed
code, and preserves the existing MIT notice and continuation terms without
inventing third-party permissions or an icon-generation history.

Stage: `dansMonoRepo` -> `Preview générée` (literal workflow label). The first
gate's missing attribution is resolved; the independent icon and Preview
validations from the audit below remain applicable. The next transition to
`preOptions` still requires the prescribed Steam-formatted source link in
About.xml. Settings and translation validations remain unchanged; in-game
validation is still unverified.

Base revision remains `71ccca46075903ceb45dd2ac36de067c100c5a8d`, with the
pre-existing STATUS/TESTING edits preserved. This follow-up changes attribution
documentation, README and STATUS only. Verified identical attribution copies
and clean whitespace with `git diff --check`. No runtime files changed, so the
previous 35 passing tests and translation checks are not invalidated or rerun.

## Workflow audit — 2026-09-13 (historical decision before attribution fix)

Audited revision: `71ccca46075903ceb45dd2ac36de067c100c5a8d`, plus pre-existing
local edits to `STATUS.md` and `TESTING.md` (51 insertions, 2 deletions at audit
entry). No shipped file differed from HEAD. This audit edits only `STATUS.md`;
the existing edits and historical records below are preserved. The current
decision supersedes earlier claims of `done` and description-link compliance.

**Previous stage: done. Retained stage: dansMonoRepo.** Stage values here use the
user's literal workflow names. `dansMonoRepo` is the baseline before the first
fully satisfied gate, not a claim that the repository is physically still in a
monorepo. `detached: yes` remains correct. No remote needs restoring in the former
monorepo. The first transition is incomplete because the prompt explicitly
requires initialized English `ATTRIBUTION.md`, which is absent. README credits
and STATUS provenance exist but do not supply that named artifact. The prompt
takes precedence over PUBLISHING.md's narrower conditional attribution rule.

### Ordered transition results

Later rows report independent criteria; they do not bypass the cumulative block.

| Transition | Result | Evidence / remaining criterion |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Defect found | Missing root ATTRIBUTION.md. Own .git directory, Git root and empty superproject result verified. GitHub repository exists, is PUBLIC, and remote HEAD equals audited HEAD. STATUS, English README/CHANGELOG and both identical MIT licence copies exist. Identity is coherent: Crystal Ball / nelim.crystalball / Rimworld-Crystal-Ball / CrystalBall; literal identity is unnecessary. Original/public classification is consistent with documented original XML/vector art and AI-assisted imagery, and no redistributed third-party code or game assembly was found. |
| horsMonoRepo -> ModIcon generated | Independently validated; build not applicable | Four complete Defs, one runtime texture, no custom C# or compiled assembly. Both offline suites pass. Mod/About/ModIcon.png is a decoded 128 x 128 PNG, 21,171 bytes; directly inspected, one recognizable mascot and crystal-ball stand. No compilation or stale compiled artifact applies. |
| ModIcon generated -> Preview generated | Independently validated | Delivered PNG directly inspected: 896 x 504, 498,300 bytes, below 1 MB. Subject identifiable, overhead oblique scene with floor grid, no readable faces or concrete camera defect observed. No historical generation report or recorded screenshot comparison required. |
| Preview generated -> preOptions | Defect found in description convention; visual/name criteria validated | English description and title; no prefix, suffix or linking word needs special handling for this original public mod. Delivered Preview and Art/Preview-268.png inspected: cyan accent separates from blue-indigo surroundings/secondary palette, title/version readable, no clipping. About.xml still ends in a raw URL under SOURCE CODE, not the required [url=...]Source code on GitHub[/url] link. |
| preOptions -> options | Not applicable, justified | Settings inventory below establishes no relevant settings, empty settings page or MainButtons shortcut. |
| options -> l10n | Independently validated | Four owned strings, English in native Def fields and four nonempty French entries in the correct three DefInjected folders. Meaning, unique keys, paths and matching escaped paragraph breaks reviewed; no parameters, rich-text tags or grammar tokens to reconcile. Native vanilla UI is inherited; no mod-owned hardcoded UI or additional language loader exists. Fresh checks below pass. |
| l10n -> preTest | Independently validated | RimWorld 1.6 declared, loadAfter Ludeon.RimWorld. Referenced Defs/base template verified in installed Core, classes checked against vanilla assembly. No required external mod or DLC, optional integration, patch, version folder or LoadFolders file. No external dependency declaration is needed. |
| preTest -> done | Independently validated for offline readiness | 15 written scenarios with prerequisites, actions and expected outcomes in TESTING.md. Automated/XML suite 24/24 and offline behaviour suite 11/11 pass against the unchanged delivered files. No custom-code build/unit suite applies. Runtime expectations in scenarios remain expectations, not observations. |
| done -> tested | Not verified | No in-game scenario execution, FR/EN interface verification, log review tied to a played run, or new/existing-save validation performed. These are mandatory for tested, not defects or blockers to options/offline readiness. |

### Settings audit

Scope: all nine shipped files under `Mod/`, the four Defs in
`Mod/Defs/CrystalBall.xml`, inherited vanilla behaviour and README usage.
Cost (40 jade/5 gold), glow radius (3), quality, recreation duration (4000 ticks),
capacity (2), selection chance (2), sight requirement and chairless use are
fixed content/balance choices, not a promised configuration feature or an
existing XML-only settings interface. No concrete player configuration need was
identified that warrants turning these internal values into controls. This is
one recreation building and one recreation type, with no configurable subsystem.

Inventory verifies there is no source/assembly implementing a Mod settings page,
no settings storage, no MainButtonDef and no custom settings window or inherited
mod configuration to expose. Thus no empty page or shortcut is registered.
`settings_audit: not_applicable` is justified by that content review, not merely
by the absence of C#. Input boundaries, changes/apply timing, reset, migration,
settings persistence and shared access routes are not applicable. Def values
are read through the vanilla code paths checked by the 11-test suite; no live
behaviour is inferred from that scan. No RIMMSQOL or other customization mod was
tested or claimed compatible. The user's clarification permits this source and
offline verification without a game run for the options transition.

### Executed checks and evidence

Environment: Windows PowerShell, installed RimWorld `1.6.4871 rev590`, data and
managed assemblies under `C:\Program Files (x86)\Steam\steamapps\common\RimWorld`.

- `git status --short`, `git diff --stat`, `git diff -- Mod`,
  `git rev-parse HEAD`, `git rev-parse --show-toplevel --show-superproject-working-tree`,
  `git remote -v`: established repository, revision and local edit scope above.
- `gh repo view vbardales/Rimworld-Crystal-Ball --json name,visibility,url,defaultBranchRef`:
  PUBLIC, main, expected URL. `git ls-remote origin HEAD`: audited SHA above.
  Initial sandbox/network/config access failed; the read-only retry with expanded
  access succeeded. GitHub existence, visibility and pushed commit are verified.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1`:
  exit 0, **24/24 passing**, four Defs and 18 collected Def references.
- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1`:
  exit 0, **11/11 passing**, worker/driver construction, IL field readers and
  recreation accounting/vanilla value comparisons. This does not launch a colony.
- `powershell -NoProfile -ExecutionPolicy Bypass -File ../scripts/Check-DefInjected.ps1 -TransMod Mod`:
  exit 0, **4 keys, 0 errors** (11,589 indexed Defs; 29 patch operations in validator
  indexing, not patches shipped by this mod). Full text inventory separately reviewed.
- Read PUBLISHING.md, STYLE_RIMWORLD.md, MOD_SETTINGS.md and TRANSLATIONS.md;
  inspected shipped XML, translations, file inventory, licence copies, README,
  CHANGELOG, TESTING, Art/Preview.html and palette/QA artifacts.
- Direct image inspection: Mod/About/Preview.png, Mod/About/ModIcon.png and
  Art/Preview-268.png. Existing contrast/font QA remains historical evidence;
  no new browser render or font measurement was claimed or required to establish
  the observed visual result. No image generated or modified.
- `Get-FileHash LICENSE,Mod/LICENSE`: both SHA256
  `1A24DB0B016BF77E6D15FDA1BF27B20C76F9B14F1A21458BA36F2BB3A7D2C908`.

### Required next work and separate recommendations

To pass the immediate transition, initialize the missing English ATTRIBUTION.md
with the established provenance and credits, distinguishing original work and
vanilla references from any copied third-party material; do not invent a licence
or a permission. Include a distributed copy if its notices require distribution.
This audit does not create that artifact to improve the stage.

The later description gate requires the prescribed Steam-formatted source link.
Final `tested` requires executing and recording the 15 in-game scenarios, logs,
FR/EN display and new/existing-save coverage. None was executed by this audit.
Workshop publication is outside the requested chain and is not a stage blocker.

Optional repository hygiene: `.gitattributes` is absent; PUBLISHING.md recommends
text normalization and binary PNG/DLL attributes. This is not elevated to a
mandatory transition criterion. No concrete visual reservation remains.

## Historical records (preserved)

This file is maintained by the Codex task responsible for this repository. Update it after
changes, test runs and release decisions. It stays outside `Mod/` and is not shipped to Steam.

## Repository identity

Verified on 2026-09-12: the Git root is `C:\Users\nelim\Documents\rimworld\CrystalBall`,
with its own `.git` directory and no Git superproject. This task manages this single local
repository, no longer the former monorepo. Origin fetch and push both point to the remote above.
GitHub reports `PUBLIC` through `gh repo view --json name,visibility,url`.

The mod title is **Crystal Ball**, author **Nelim**, packageId **nelim.crystalball**.
No continuation or fork suffix is justified by the provenance documented here: this is presented
as an original mod, not a maintained copy of someone else's mod. Keep the title unchanged.
The GitHub link is present in both `About.xml`'s `url` and, after this audit, its description.

## Licence and justification

The actual licence is **MIT**, copyright (c) 2026 Nelim. `LICENSE` and `Mod/LICENSE` carry
that licence. `licence: original` is the status catalogue's provenance category, not a licence name.

The repository credits original defs and vector texture made with Claude Code and a preview made
with DALL-E under human direction. Its behaviour references vanilla RimWorld classes; it ships
no game assembly or third-party mod code. That documented provenance supports keeping the
existing MIT licence: it allows reuse and continuations while retaining the copyright and licence
notice. This audit confirms the files and credits, not an independent history of every asset.
No additional attribution file or third-party licence is present.

## Validation

Two relevant offline suites live in this repository and use the installed RimWorld data and
assembly, without relying on the former monorepo or launching a colony:

- `_tools/Run-Tests.ps1`: 24/24 passing on 2026-09-12 after the description edit.
  Covers metadata, images, all four defs, XML fields, class and def references, inheritance,
  recreation settings and French translation keys and values.
- `_tools/Run-Functional-Tests.ps1`: 11/11 passing on 2026-09-12.
  Checks vanilla worker/driver construction, Building compatibility, setting readers,
  recreation accounting and values against vanilla definitions. These are offline checks,
  not played functional scenarios.

Run with `powershell -NoProfile -ExecutionPolicy Bypass -File` followed by the script path.
The relevant XML is covered by the first suite, including About parsing, defs and translations.
There is no custom C# assembly requiring a separate mod-code unit-test suite.

`TESTING.md` contains **15 manual functional scenarios**, with setup, steps and expected results:
loading/building, appearance/glow, quality, autonomous recreation, chairless use, chair alerts,
capacity, tolerance/variety, sight, room ownership, moving, pathing, room role, French and saves.
They exist but have no recorded in-game execution result. Keep `tested_on` empty until an actual
run records the game version, scenarios, outcomes and relevant log evidence. Prior notes about
never having loaded the mod or Workshop publication are not fresh checks of external state.

`stage: done` means implementation complete, not in-game validation complete.
The remaining categories are `feature`, `defect` and `unverified`.

## Translation audit — 2026-09-13

Applied the mandatory gate in `../PUBLISHING.md` and `../TRANSLATIONS.md` to
revision `71ccca46075903ceb45dd2ac36de067c100c5a8d`. Audited all shipped files
under `Mod/`: one Def file, four Defs and three French language XML files.
There is no source code, assembly, patch, LoadFolders file, optional integration,
Keyed text or custom grammar resource. Behaviour and its remaining UI come from
vanilla classes; no dependency translation key is explicitly reused by this mod.

The complete inventory of owned player-facing text is:

| Def type | Injection path | English source | French resource |
|---|---|---|---|
| JoyKindDef | `CB_Divination.label` | divination | divination |
| ThingDef | `CB_CrystalBall.label` | crystal ball | boule de cristal |
| ThingDef | `CB_CrystalBall.description` | Full English description in Defs | Full French description in ThingDef/CrystalBall.xml |
| JobDef | `CB_GazeIntoCrystalBall.reportString` | gazing into the crystal ball. | scrute la boule de cristal. |

All four fields use native Def translation. English is supplied by nonempty Def
values; an English DefInjected copy is unnecessary. French has exactly four unique,
nonempty entries in the correct type folders, with no missing or orphan entry.
Reviewed meaning and terminology: identical `divination` is valid in both languages.
Both descriptions retain the two escaped line breaks. No parameter, grammar token
or rich-text tag is present. IDs, class names, paths and numeric settings are not
player text; About metadata, licences and repository documentation are outside
this gate. No engine limitation preventing localization was found.

Verification on 2026-09-13:

- `powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1`:
  **24/24 passing**, including MustTranslate coverage, fields, folder spelling,
  nonempty French values and paragraph breaks.
- `powershell -NoProfile -ExecutionPolicy Bypass -File ../scripts/Check-DefInjected.ps1 -TransMod Mod`:
  **4 keys checked, 0 errors**, exit 0; no unresolved target reported.

All three translation fields are `complete` for readiness before `preTest`.
The historical `stage: done` is preserved. No in-game language run was performed;
scenario 14 in `TESTING.md` now explicitly covers both English and French, and its
runtime verification remains `unverified` above. Reset affected translation fields
to `unchecked` after relevant text, Def, patch or language-resource changes.

## Preview overlay — 2026-09-12

Recomposed according to `../STYLE_RIMWORLD.md`, preserving the existing title and summary.
The existing text-free `Art/Preview-source.png` was visually inspected and copied unchanged to
`Art/Preview.png`. No illustration replacement or generation; the original remains at its
existing path. The delivered overlay is `Mod/About/Preview.png`.

- Composition and layout parameters: `Art/Preview.html`; render and verification script:
  `Art/render-preview.cjs` (Node.js with playwright, sharp and installed Chrome; run from any
  directory with those packages resolvable). Serve the repository over HTTP for manual viewing.
  The former `_tools/preview/Preview.html` now points to the maintained composition.
- Colour reference: `Art/preview-palette.json`, loaded directly by the HTML. The vivid accent
  comes from the cyan rim across the upper crystal ball, with saturation strengthened. This cyan-green accent separates clearly from the dominant blue-indigo atmosphere and secondary ink at both review sizes. The secondary ink uses
  the blue-indigo family spread across the stone wall and wooden floor, lightened while
  retaining its colour. The veil takes a dark, slightly desaturated shade of those surfaces.
  No tag is displayed: the mod is public and original.
- Typography verified through Chrome's platform-font API after `document.fonts.ready`:
  Segoe UI Semibold for the 46 px / 600 title, Segoe UI regular for the 21 px summary,
  Segoe UI Bold for the 26 px badge. No fallback. Title and summary use identical ink.
- Badge version read from the delivered About.xml: highest declared stable version, 1.6.
  Triangle and rotated text use the guide's coordinates. Dark-veil gradient and shadows
  follow the guide; no shadow on badge digits.
- Visual inspection passed at 896 x 504 and 268 px wide: title and version identifiable,
  rule visible, no overlapping or clipped text; the summary remains intended for full size.
- Contrast measured on `Art/preview-background.png`, rendered with text hidden. Minimum over
  every pixel of the title/summary rectangles (stronger than just four corner samples):
  title 14.71:1, summary 15.01:1; badge ink on opaque accent 10.91:1. All exceed 4.5:1.
  Tag contrast is not applicable because no tag is present.
- QA evidence: `Art/preview-qa.json` and `Art/Preview-268.png`. Final PNG: 498,300 bytes,
  below 900 KB. Nothing published.

The revised title hierarchy was checked: both words in Crystal Ball are essential title words,
so both retain 46 px / 600 in primary ink. There are no prefixes, suffixes or linking words
to reduce, and no status tag. Illustration, exact title and summary remain unchanged.
  - unverified: `tested -> prepublished` under way through the CI. Done: `PUBLICATION.md` (the private release and the rollback in its section 6), the manual publish workflow, the environments and their two secrets (set by Virginie on 2026-09-25 19:05 UTC, names seen with `gh secret list`), CHANGELOG 1.0.0 dated 2026-09-25, and a green dry-run of `e5337600ea474f30e8c7b9d1e11ec0f694845c1b` as 1.0.0 with `update_description` on: run 36180799559, nothing sent to Steam (description 2718 bytes, sha256 `e68b8797...9ffc`; no diff, the page of a private item is not readable). Still open: the gallery, three close-up candidates cropped to 480 x 270 from run `5abc` that Virginie has not yet judged (weak: the ball stays about 30 pixels wide, the game being at its closest zoom), which would change the SHA and need a new dry-run if they go up; the dispatch of `publish` and Virginie's approval of `steam-production`