# In-game scenarios, run by Pickle

The scenarios of [TESTING.md](../../TESTING.md) that a running game is needed for, and only those. `Mod/` is a
companion mod, **Crystal Ball - Pickle tests**, never published: it lives beside the mod's own `Mod/`, outside the
folder Steam receives. TESTING.md carries the table that says, scenario by scenario, where each one is settled and why
four of them are not applicable.

**Read `_tools/Run-Functional-Tests.ps1` and `_tools/Run-Tests.ps1` first.** Thirty-six checks against the installed
game's own assembly and def files, in a few seconds, needing no RimWorld: the defs, the fields, who reads each setting,
the numbers against vanilla, that nothing the mod points at needs a DLC. A Pickle run takes the machine for tens of
minutes. Nothing here restates any of it.

## What is here

| File | What it holds |
| --- | --- |
| `Mod/Pickle/Features/01-the-ball.feature` | the four defs after the game's loader, a colonist building the ball, quality and beauty, the glow at night and its capture |
| `Mod/Pickle/Features/02-the-gaze.feature` | a colonist sent to the ball sits beside it, two may share it and a third may not, the recreation type, sight |
| `Mod/Pickle/Features/03-language.feature` | the four owned texts in the language of the pass, and a capture of the inspect pane |
| `Mod/Pickle/Features/04-save.feature` | a save taken with two colonists gazing, reloaded |
| `Mod/Pickle/Features/05-workshop-captures.feature` | three close-up pictures for the Workshop gallery, on PickleTools' zen meadow studio; only the `workshop` pass plays it |
| `wsl-deps.workshop.map` | the pass map of that pass: the screenshot studio and nothing else |
| `Source/` | the step assembly, `CrystalBall.PickleSteps.dll` |
| `Check-Steps.ps1` | compiles every step pattern with Pickle's own engine and checks each feature line resolves to exactly one |

The mod ships no assembly, so the steps reference none of the mod's own: a crystal ball is a plain `Building` that the
game's chess-table joy giver and sit-facing driver put to use, and every step reaches it through those types and the
mod's defNames. Everything a Pickle step already does (loading the save, making a colonist, setting a need, waiting,
the screenshots, the log assertions, saving and reloading) is left to Pickle.

**Every step text starts with `Crystal Ball:`.** Pickle loads the steps of every active suite into one namespace, and two
suites declaring the same text produce "Ambiguous step" on scenarios that are perfectly healthy. `Check-Steps.ps1`
compares this suite's lines with Pickle's vocabulary and, when the collection is around, with every other suite's.

## Three passes: two languages, and the pictures

`AUDIT.md` asks for the interface to be read in French and in English, and for a pass without the optional mods and one
with them. This mod names no optional mod, so the passes are the two languages, and a third for the Workshop pictures. The language is fixed at staging and never
switched inside a run: `SelectLanguage` reloads every def under the runner and the run dies with it.

```powershell
powershell.exe -ExecutionPolicy Bypass -File Rimworld-Ticket-Dispatcher/scripts/Submit-PickleRun.ps1 `
  -Mod CrystalBall -Owner local_<session id> -Label "validation English" `
  -EvidenceDir CrystalBall/Tests/Pickle/Evidence/<run>
# the same with -Language French, as a second request
```

The two language passes need no `wsl-deps` map: nothing has to be staged beside the mod. The Workshop pictures are taken
in a third pass, `-DepMap wsl-deps.workshop.map -Filter '05-workshop-captures'`, which stages PickleTools' screenshot studio;
the other two passes skip that feature. There is no pass without the DLCs; the claim that none is required is proved
offline, and `TESTING.md` says why.

## What to run, and when

Runs are not started from a session: a request is dropped with the ticket dispatcher's `Submit-PickleRun.ps1`, one pass
per request, and the dispatcher wakes the session. Its `WELCOME.md` sets the sizes.

- **Exploration or a fix**: the fewest scenarios, one request per scenario: `-Filter '::<scenario name>'`.
- **An initial or a final validation pass**: every scenario, no `-Filter`, one request per language.

A filter is one string whose terms are separated by commas, and `::text` picks the scenarios whose name contains `text`.
**A scenario name therefore carries no comma**, or the filter would read it as two terms. Examples, the first
exploration requests of this suite:

| What it settles | Filter | Language |
| --- | --- | --- |
| the fixture loads with the mod, its four defs are in the game, no error | `'::the mod loads and the game holds its four defs'` | English |
| the whole gaze: the spot for the ball, the giver, the walk, the seat, joy rising | `'::sent to the ball and sits beside it'` | English |
| the texts in French, and the language machinery | `'::the four owned texts read in the language of the pass'` | French |

## The fixture, and where the ball goes

The suite loads Pickle's own `test-colony`. Its construction and map features place walls, stockpiles and stones between
x 140..152 and z 150..165, so that patch is open ground. A step looks for a spot from (146, 156) outward: a cell the game
agrees a ball can be placed on, with at least four open neighbours to sit on, unroofed, and **no seat of any kind within
the radius the scenario asks for**. The chairless scenario is the same scenario as the gaze, only with that radius set to
six, so a giver that still wanted a chair would offer nothing.

The building scenario uses fixed cells, (146, 157) for the ball and (150..152, 160..162) for the stockpile, as Pickle's
own feature does for its walls. If either is not free in a given build of the fixture, the scenario says which cell holds
what.

## The step assembly

Build it with:

```powershell
dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release
```

The DLL is a build artefact: it lands in `Mod/Pickle/Assemblies/` and stays out of git, and the intermediates go to
`.build/`. Pickle loads step DLLs when the game starts, so a report produced without a restart after a rebuild does not
test what was just changed. Then:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
```

## Status

Written on 2026-09-24 and played on 2026-09-25: eleven scenarios, English and French, all green (one scenario, the
save, was corrected after both full passes had asked a full ball for a third colonist, then replayed green). Every run is
one line of [docs/runs/README.md](../../docs/runs/README.md). The spots the suite guessed held, the ball at (146, 156),
the build at (146, 157) with its stockpile, and the build takes about 30 s. Not seen: the description on the game's info
card, which the inspect capture does not show.

Put the revision to test in `-Label` when a request is filed: a request carries no SHA, the mod is staged from the working
tree when its turn comes, and the tree must not change until the run is done.
