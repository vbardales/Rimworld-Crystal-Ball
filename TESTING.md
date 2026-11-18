# Crystal Ball: in-game test scenarios

Two test suites beside this file. Neither starts game. Check defs well formed, game still has every field/class named, classes mod hands behaviour to still read settings it writes. None = single tick of play.
This file = what must be watched in running colony + what counts as pass.
Most written as Gherkin in `Tests/Pickle/`: table "Which scenarios are written as Gherkin, and which are not" says where each settled.

Not shipped: lives beside `Mod/`, never inside → Steam never gets it.

## Before starting

- RimWorld 1.6. **No DLC required**, proved offline by `Tests/Rule-OwnValues.ps1` (see "No pass without a DLC"
  below), not by run. Dev mode on → silent failures become red text.
- Log to read after, attach to any report:
  `C:\Users\nelim\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`
- Materials: 40 jade + 5 gold per ball; colony rarely has jade.
  Debug actions → Spawn thing → `Jade` and `Gold`, or Debug → generous map resources.
- One or two colonists, recreation low, schedule block = Recreation. Debug
  actions → Needs → recreation to zero, faster than waiting.

Conversions: 60 ticks = 1 s normal speed, 2500 ticks = 1 in-game hour. Full
gaze = 4000 ticks ≈ 1.5 h; glow radius 3 = 3 cells light each direction.

## 1. It loads, and it is buildable from nothing

Mod = four defs + texture. ThingDef fails config check → building absent from menu, nothing else testable.

1. Start/load colony with mod active.
2. Open Architect menu, **Recreation** tab.

**Pass:** **crystal ball** there, no research prereq, cost 40 jade + 5 gold. Tooltip has description, build icon = ball, not pink square.
**Fail:** absent from tab, or missing-texture icon.

Check log for red line naming `CB_`, any `Could not resolve cross-reference`, esp. `is not minifiable yet has thing categories`: config error def shaped to avoid, kills whole def.

Try **neolithic** start too: def = neolithic tech, no research → tribe builds day one, materials permitting.

## 2. It looks like what it is

1. Build one in open, look.

**Pass:** violet sphere on stand, drawn slightly larger than cell, with shadow. Glows
**at once, by itself**, no power/fuel/switch, violet not lamp yellow.

2. Wait for night, or Debug actions → set hour to 2.

**Pass:** lights ~3 cells around. Landmark, not lamp: room lit only by it stays dim, lit/unlit indicator (Architect → Recreation → hover, or light overlay) shows small bright patch.

Glow deliberate + permanent; unlit ball = paperweight. Must **not** happen: glow only while colonist uses it.

## 3. Quality, beauty, and the name

1. Build several, or Debug actions → Spawn thing with quality.
2. Read inspect pane + beauty at different qualities.

**Pass:** each ball has quality. Beauty rises with it (base 10, vanilla quality StatPart scales). **Masterwork**/**legendary** gets own name, like any quality furniture.

## 4. A colonist decides to gaze, on their own

This = the mod. No right-click gaze order, by design: vanilla has none for chess table either; colonist picks recreation.

1. Colonist, low recreation, Recreation block, near ball.
2. Let time run.

**Pass:** walk over, **sit on ground on adjacent cell, facing it**, inspect line *gazing into the crystal ball.* Recreation rises while sitting. Left alone → ~1.5 h.

**Fail to watch:** walks over and stands, or never comes while other recreation available. Also `InvalidCastException` in log on sit: driver's cast → def stopped being building.

## 5. No chair, anywhere

Most breakable thing in mod, breaks silently: you crouch before crystal ball, no dining chair.

1. Build ball in room with **no chair, stool or bench of any kind**, none in next room either.
2. Send colonist on recreation.

**Pass:** uses it exactly as scenario 4.
**Fail:** ignores it, or leaves to find chair. Def's `requireChair` guards this; fortune teller's caravan of balls, no seating → idle.

## 6. The game must not ask for chairs: not applicable

Withdrawn 2026-09-24. Watched RimWorld's alert for recreation buildings without chair, required it never name ball. Alert can't reach ball → nothing to watch.

Compiled game: `Alert_JoyBuildingNoChairs` abstract, exactly two
subclasses. `Alert_ChessTableNoChairs` gets joy giver from `JoyGiverDefOf.Play_Chess`, `Alert_PokerTableNoChairs` from `JoyGiverDefOf.Play_Poker`. Alert lists buildings named by
that giver's `thingDefs`; ball belongs to `CB_GazeIntoCrystalBall`, own giver.
No game alert can list it, chair or not.

Slot keeps number so others don't shift. Wrong for reason `../AUDIT.md` gives for deletion: asked running game what reading settles.
Premise written without checking which giver alert watches.

## 7. Two may share it, a third may not

Job allows two: read someone's future, or own. Not eight.

1. Send two colonists to same ball. Then third.

**Pass:** two sit, different cells. Third does other thing: other ball, other recreation, or nothing. No stacking on occupied cell.

## 8. Divination is a type of its own

Why mod exists. Tolerance counted per recreation type; expectations want count of **different** types.

1. Colonist's Needs tab, hover Recreation bar.

**Pass:** **divination** listed among types received, beside ten
vanilla. Tolerance rises with use, falls without.

2. Build three more balls, colonist uses all.

**Pass:** tolerance rises just as fast. Four balls tire exactly as fast as one -
rule mod built around; seeing it = the point.

3. Check colony recreation variety, Needs tab tooltip listing what's available
   on map.

**Pass:** divination counted as one type colony offers. Eleventh type worth more than tenth furniture on served type.

## 9. It is looked into, so it takes eyes

Job needs sight only.

1. Blind colonist (Debug actions → hediff destroying both eyes).

**Pass:** never gazes, recreation sends elsewhere.

2. Deafen instead.

**Pass:** gazes normally. Hearing irrelevant.

## 10. Where it stands matters

Def sets `socialPropernessMatters`, furniture for room owners.

1. Build one in prison cell.

**Pass:** colonists don't enter cell to use it. Prisoner there does.

## 11. It moves house

1. Select ball, **Uninstall**. Colonist carries away.

**Pass:** becomes minified crystal ball, haulable/storable. Appears
under **Buildings** → recreation in stockpile filter tree, keeps quality.

2. Re-install elsewhere.

**Pass:** same quality, glow returns.

3. Deconstruct one instead.

**Pass:** returns part of jade + gold, like any building.

## 12. Walking past it

Def = pass-through, high path cost: colonists may cross, prefer not.

1. Ball mid-corridor, watch traffic.

**Pass:** corridor works, nobody trapped, no red pathing error, colonists step
around when room. Not wall.

## 13. It is furniture in a recreation room

Room role from contents; buildings joy giver names count.

1. Ball in small closed room, nothing else notable.
2. Select room (or hover with inspect overlay).

**Pass:** **recreation room**, impressiveness computed as one.

## 14. English and French

Run scenarios 1, 4, 8 in English. Check *crystal ball*, full description,
job report *gazing into the crystal ball.*, recreation type *divination*.
Both languages: raw keys, missing text, format errors, clipping.

Switch to French, redo 1, 4, 8.

**Pass:** building *boule de cristal*, French description in build menu +
inspect pane, job line *scrute la boule de cristal.*, recreation type
*divination*. No English.

Read description closely: paragraph break written as escape; French text losing it = one solid block.

## 15. Saving, and a colony that never had it

Mod stores nothing own; claim worth testing, not trusting.

1. Save while two gaze. Reload.

**Pass:** loads no red line, colonists continue or pick new job cleanly, glow there, each ball's quality survived. Gazing pair still holds ball → third offered nothing.

2. Add mod to colony that never had it.

**Pass:** building in menu, nothing else changes, no error.

3. Remove from colony with balls built.

**Pass:** game warns missing content, like any removed mod; colony loads
and plays. Balls gone; nothing else.

## Which scenarios are written as Gherkin, and which are not

`Tests/Pickle/` = suite Pickle plays in headless WSL game: five features (fifth takes Workshop page pictures, settles none of fifteen), twenty-three mod steps in `Source/`, Pickle's vocabulary for rest. Gherkin gets
only what running game alone shows. What two offline suites prove not repeated,
since run takes whole machine tens of minutes. Game's reaction to flag mod merely declares untested, per `../AUDIT.md` ("on ne
teste pas le jeu"): mod answers for what it declares, not engine's handling.

Joy giver asked directly, as game asks each giver at recreation time, not
waiting for pick. Pick frequency = `baseChance`, die roll base
game owns, mod only sets → not measured.

| # | Scenario | Where it is settled |
| --- | --- | --- |
| 1 | It loads, and is buildable | `01-the-ball.feature`: defs after game loader, no mod error/warning, colonist builds ball with real designator from jade + gold, no research. Architect tab listing = game's; `designationCategory` resolved offline. |
| 2 | It looks like what it is | `01`: glow radius, self-lit, ground on ball cell lit at night excluding sky, nobody gazing. Violet sphere, stand, size, shadow = picture judgement: `@review` capture, opened by person. |
| 3 | Quality, beauty, name | `01`: legendary more beautiful than poor, both names carry quality. |
| 4 | A colonist gazes | `02-the-gaze.feature`: giver sends colonist, walks over, sits adjacent with game's sit-facing driver, joy rises. |
| 5 | No chair, anywhere | `02`, same scenario: spot with no seat within six cells → scenario 4 stricter. |
| 6 | The chair alert | Withdrawn, see above. |
| 7 | Two may share it | `02`: two sit at one ball, third offered nothing. |
| 8 | Divination is a type | `02`: sitting credits tolerance to mod's kind, map recreation lists it. Four balls tiring as one = `JoyToleranceSet` per-kind counting, engine rule → not scenario. |
| 9 | It takes eyes | `02`: blind offered nothing, deaf sent and sits. |
| 10 | Prison cell | **Not applicable.** Mod declares `socialPropernessMatters`; prison handling = `SocialProperness`. Offline functional suite requires game reader per mod setting; scan names `SocialProperness` here. |
| 11 | It moves house | **Not applicable.** Mod declares `minifiedDef` + thing category; uninstall/reinstall = `MinifyUtility`, scan names it reader. Pairing enforced by config check tested offline; `01` fails on any loader error. |
| 12 | Walking past it | **Not applicable.** `passability` + `pathCost` declared, `Pathing` reads cost. |
| 13 | A recreation room | **Not applicable.** Ball named by giver's `thingDefs`, read by `RoomRoleWorker_RecRoom`. Room naming = game scoring. |
| 14 | English and French | `03-language.feature`, once per language, + `@review` capture of inspect pane. |
| 15 | Saves | `04-save.feature`: save with two gazing loads clean, ball keeps cell + quality, two still gaze after, third offered nothing (ball full). Adding mod to colony without it = every run, fixture predates mod. Removing from save = modlist change between games + game's missing-content warning: not applicable. |

Ten in Gherkin, 4 + 5 by one. One withdrawn, four
not applicable, reasons in table. Parts of three of ten not applicable,
same reason: Architect tab, four balls, removal. Nothing left for person: `@review`
captures opened (inspect pane each language, ball at night; info card again on `1.0.1`).

Suite built/checked without game: `dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`,
then shared `../scripts/Check-Steps.ps1 -ModRoot .` (local copy deleted 2026-10-11): compiles every step pattern with Pickle's expression
engine, checks each feature step line resolves to exactly one expression. On published `1.0.1`
suite played English, French, `sanctuary` (2026-10-08, 2026-10-09, `docs/runs/README.md`).

## What `playTests` requires

Scenarios above = what to watch. This section = what must hold before
`STATUS.md` leaves `playTests`. Restates step 8 of `../AUDIT.md` for this mod.

- **No scenario left in `@wip`.** Set-aside scenario repaired + replayed, or deleted
  with reason. One left = waiting, not passed. Suite has none.
- **Every conditional scenario has run.** Each `@requires:<packageId>` scenario (optional mod, DLC or companion tool) gets own pass on map mounting it, report read: `setName`, suite + scenario names checked before citing, since report folder machine-shared. Skipped for missing condition ≠ passed. Mod names no optional mod/DLC, but companion tools are conditions too: workshop captures (05, 06, 07) need sanctuary pass; scenarios 1 and 3 of `02-the-gaze.feature` (step `Nelim's Pickle Tools: the game is advanced by`) carry `@requires:nelim.pickletools.colonistrace` → skip on minimal pass, run on sanctuary + 1.7 passes.
- **No manual test left to validate.** Each scenario Gherkin + green, or listed
  above not applicable with reason. Nothing ticked by hand. `@review` captures
  still opened and viewed, but = reading image scenario already proved in intended state, not extra manual test.
- **A green run is not the proof.** Read `exitReason` before numbers, compare scenarios
  played vs features discovered, open every `@review` capture. Green = path walked, not that image shows ball, sitting colonist, or tolerance bar.
- Logs read; interface checked French + English.

## Passes this mod needs

Mod whose `TESTING.md` omits pass count = tried, not tested. Two, each
language fixed at game start, never switched mid-run. Three, third not language:

1. **Minimal set, English.** Core, DLCs, Harmony, RimLogging, Pickle, mod. Only
   pass with clean capture.
2. **Same set, French.** `03-language.feature` asserts only in its run language;
   French interface read here.
3. **`sanctuary`, English** (`-DepMap wsl-deps.sanctuary.map`, renamed from `workshop` 2026-10-05). Same set plus (steps from two owners: place steps, prefix `Nelim's Sanctuary:`, from SanctuaryBacklot, which also holds fixture + map mod list; rest, prefix `Nelim's Pickle Tools:`, from PickleTools) PickleTools screenshot
   studio loading Nelim's Sanctuary (fixed map, place `podium`), `camerazoom`, `stagedecor`, `colonistrace`, `clearscreen`, staging posed photos (rule 2026-10-02). Plays `05-workshop-captures.feature` alone, three close-ups
   for Workshop gallery, `@requires:nelim.pickletools.screenshotstudio` feature other two
   passes skip. Skipped ≠ passed → this pass settles them.

Each pass = one request via ticket dispatcher's `Submit-PickleRun.ps1`, starting worker that
calls `Run-PickleWsl.ps1` under machine lock; session keeps no process, watches nothing, dispatcher
wakes it. Exploration/fix → fewest scenarios, `-Filter '::<scenario name>'`. Validation pass, initial
or final → all: no `-Filter`, one request per language. `Tests/Pickle/README.md` lists first three
exploration requests.

**No pass without a DLC.** Earlier version declared one, to play claim no
DLC required. No mod guard/fallback to play: mod has none,
just never names DLC content. Static fact → proved statically by
`Tests/Rule-OwnValues.ps1`: every def a field points at, every inherited template def, every C#
class named must be Core-defined/named; test fails on DLC-only def, template, class. DLC-less run would also need Pickle's `test-colony`
fixture, saved with Royalty content.

No pass with optional mods: `loadAfter` names only game. No pass per
incompatibility, none declared. If any appears, list changes first.

## Out of the game

From mod folder, no RimWorld launched, two mod scripts (declared in protocols'
`scripts/LOCAL_SCRIPTS.md`):

```
powershell -NoProfile -ExecutionPolicy Bypass -File Tests/Test-Mod.ps1
```

`Tests/Rule-OwnValues.ps1`: 12 tests: mod identity, cost texts claim, `CB_` prefix, Core-only
references, eight underlying rules. `Tests/Rule-GameReflection.ps1`: 11 tests reading compiled
game by IL. Generic checks (XML, images, references, classes, field names, French) = shared
`Check-ModBasics`, `Check-DefRefs`, `Check-TypeRefs`, `Check-XmlFields`, `Check-Translations`,
`Check-DefInjected` in protocols' `scripts/`; `Check-HarmonyContract` n/a (no DLL).

## Evidence to keep

Every run writes to machine-shared report folder; next run overwrites.
Keep decision made at run, never deferred.

**Keep**, per scenario, latest report for revision in repo, nothing
newer report replaced:

- `exitReason` + played/discovered counts;
- `summary.md` and `junit.xml`;
- `@review` captures person actually opened, one per scenario needing one;
- run's `Player.log`.

**Keep older report** only if sole proof of check latest run didn't repeat.
Superseded-build report proves nothing about current → delete once
newer replaces it.

**Where.** Disk, `Tests/Pickle/Evidence/<run>/`, passed to launcher as
`-EvidenceDir`. Not git: folder in `.gitignore`, captures + logs grow
unbounded, fill disk. History = one text line per run in `docs/runs/`,
never folder; citable run gets short text summary there, `STATUS.md` points to it.

**Minify what stays.** Crop captures to proving part, re-encode
optimized PNG, or JPEG for full-screen; compress log. Drop `messages.ndjson` once
`exitReason` + counts read.

**Never** copy whole shared Pickle report folder into mod: only this
mod's scenario files. Never delete report a `STATUS.md` field points to; repoint
field first. Before deleting, list what goes and stays.

**Kept on disk** (`Tests/Pickle/Evidence/`, 14 MB, trimmed 2026-10-09): `2026-10-08-final-english` (`8acb`), `2026-10-08-final-french` (`68c7`), `2026-10-09-final-sanctuary` (`c525`), latest run per pass on published `1.0.1`. Each: `summary.md`, `summary.json`, `junit.xml`, `evidence-complete.txt`, gzipped `Player.log`; `report.html` + `messages.ndjson` dropped. Captures kept: info card English + French; four `workshop` pictures in `sanctuary` pass. Earlier runs one line each in `docs/runs/README.md`.