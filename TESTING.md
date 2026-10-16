# Crystal Ball: in-game test scenarios

Two test suites run beside this file. Neither starts game. They check defs well formed, game still has every field and class they name, classes mod hands behaviour to still read settings it writes. None is single tick of play.
This file = list of what must be watched in running colony, and what counts as pass.
Most written as Gherkin in `Tests/Pickle/`: table "Which scenarios are written as Gherkin, and which are not" says where each settled.

Not shipped: lives beside `Mod/`, never inside, so Steam never receives it.

## Before starting

- RimWorld 1.6. **No DLC required**, proved offline by `scripts/Run-Tests.ps1` (see "No pass without a DLC"
  below), not by a run. Development mode on, so silent failures become red text.
- Log to read afterwards, attach to any report:
  `C:\Users\nelim\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`
- Materials: 40 jade and 5 gold per ball, jade not something colony has lying about.
  Debug actions → Spawn thing → `Jade` and `Gold`, or Debug → make map's resources generous.
- Colonist or two with recreation already low, schedule block set to Recreation. Debug
  actions → Needs → set recreation to zero faster than waiting.

Useful conversions: 60 ticks = one second at normal speed, 2500 ticks = one in-game hour. Full
gaze = 4000 ticks, about hour and half; glow radius 3 = three cells of light each direction.

## 1. It loads, and it is buildable from nothing

Mod = four defs and texture. If ThingDef failed config check, building simply absent from menu, nothing else here testable.

1. Start or load colony with mod active.
2. Open Architect menu, **Recreation** tab.

**Pass:** **crystal ball** there, no research prerequisite, costing 40 jade and 5 gold. Tooltip carries description, build icon is ball itself, not pink square.
**Fail:** absent from tab, or present with missing-texture icon.

Check log for any red line naming `CB_`, any `Could not resolve cross-reference`, and especially `is not minifiable yet has thing categories`: config error this def shaped to avoid, would take whole def down.

Try on **neolithic** start too: def says neolithic tech level, no research, so tribe must be able to build it day one, materials permitting.

## 2. It looks like what it is

1. Build one in open, look at it.

**Pass:** violet sphere on stand, drawn slightly larger than cell, with shadow. Glows
**at once, by itself**, no power, fuel or switch, glow violet not warm yellow of lamp.

2. Wait for night, or Debug actions → set hour to 2.

**Pass:** ball lights roughly three cells around itself. Landmark, not lamp: room lit only by it stays dim, game's lit/unlit indicator (Architect → Recreation → hover, or light overlay) shows small bright patch.

Glow deliberate and permanent, unlit crystal ball is paperweight. Must **not** happen: glow appearing only while colonist uses it.

## 3. Quality, beauty, and the name

1. Build several, or Debug actions → Spawn thing with quality set.
2. Read inspect pane and beauty figure at different qualities.

**Pass:** each ball carries quality. Beauty rises with it, def's base beauty 10, vanilla quality StatPart scales it. **Masterwork** or **legendary** one gets own name, like any quality furniture.

## 4. A colonist decides to gaze, on their own

This is the mod. No right-click order to gaze, by design: vanilla offers none for its own chess table either, recreation chosen by colonist.

1. Put colonist with low recreation on Recreation schedule block, near ball.
2. Let time run.

**Pass:** they walk over, **sit down on ground on cell beside it, facing it**, inspect line reads *gazing into the crystal ball.* Recreation rises while they sit. Left alone stay about hour and half.

**Fail, one to watch for:** walk over and stand there, or never come while other recreation available. Also watch for `InvalidCastException` in log the moment they sit: cast the driver makes, would mean def stopped being building.

## 5. No chair, anywhere

Most breakable thing in mod, breaks without word: you crouch in front of crystal ball, do not pull dining chair up to it.

1. Build ball in room with **no chair, stool or bench of any kind**, no sittable furniture in room next door either.
2. Send colonist on recreation.

**Pass:** they use it exactly as in scenario 4.
**Fail:** ignore it, or walk off to find chair. That is what def's `requireChair` guards against, fortune teller's caravan full of balls and no seating would stand idle.

## 6. The game must not ask for chairs: not applicable

Withdrawn 2026-09-24. Watched for RimWorld's alert about recreation buildings left without chair, asked it never name crystal ball. Alert cannot reach ball, nothing to watch.

What compiled game says: `Alert_JoyBuildingNoChairs` abstract, exactly two
subclasses. `Alert_ChessTableNoChairs` gets joy giver from `JoyGiverDefOf.Play_Chess`, `Alert_PokerTableNoChairs` from `JoyGiverDefOf.Play_Poker`. Alert lists buildings named by
that one giver's `thingDefs`, ball belongs to `CB_GazeIntoCrystalBall`, giver of its own.
No alert of game can list it, with or without chair beside it.

Slot keeps number so others do not move. Scenario wrong for reason `../AUDIT.md` gives for deleting one: asked running game for what is settled by reading it.
Premise written down without resolving which giver alert watches.

## 7. Two may share it, a third may not

Job allows two participants: read someone's future, or read your own. Not eight at once.

1. Send two colonists to gaze at same ball. Then third.

**Pass:** two sit at it, different cells. Third does something else: another ball, another kind of recreation, or nothing. Nobody stacks on occupied cell.

## 8. Divination is a type of its own

Reason mod exists. Tolerance counted per recreation type, expectations ask for number of **different** types.

1. Open colonist's Needs tab, hover Recreation bar.

**Pass:** **divination** listed among recreation types they have been getting, beside ten
vanilla ones. Tolerance rises as they use ball, falls while they do not.

2. Build three more balls, let colonist use them all.

**Pass:** tolerance still rises just as fast. Four balls tire colonist exactly as fast as one -
rule mod is built around, seeing it is the point.

3. Check colony's recreation variety, in Needs tab tooltip listing what is available
   on map.

**Pass:** divination counted there as one of types colony offers. That makes eleventh type worth more than tenth piece of furniture on type already served.

## 9. It is looked into, so it takes eyes

Job asks for sight, nothing else.

1. Blind colonist (Debug actions → add hediff destroying both eyes).

**Pass:** never gaze, recreation time sends them elsewhere.

2. Deafen colonist instead.

**Pass:** gaze normally. Hearing irrelevant.

## 10. Where it stands matters

Def sets `socialPropernessMatters`, as furniture meant for people who own the room.

1. Build one inside prison cell.

**Pass:** colonists do not walk into cell to use it. Prisoner in that cell does.

## 11. It moves house

1. Select ball, **Uninstall**. Let colonist carry it away.

**Pass:** becomes minified crystal ball, item that can be hauled and stored. Appears
under **Buildings** → recreation in stockpile's filter tree, keeps quality.

2. Re-install somewhere else.

**Pass:** goes up with same quality, glow comes back with it.

3. Deconstruct one instead.

**Pass:** returns part of jade and gold, as any building does.

## 12. Walking past it

Def is pass-through with high path cost: colonists may cross its cell but would rather not.

1. Put ball in middle of corridor, watch traffic.

**Pass:** corridor still works, nobody trapped, no red pathing error, but colonists step
around ball when room. Does not act as wall.

## 13. It is furniture in a recreation room

Room's role worked out from what stands in it, buildings joy giver names count.

1. Put ball in small closed room with nothing else of note.
2. Select room (or hover with inspect overlay).

**Pass:** room read as **recreation room**, impressiveness worked out as one.

## 14. English and French

First run scenarios 1, 4 and 8 in English. Check *crystal ball*, its full description,
job report *gazing into the crystal ball.* and recreation type *divination*.
In both languages, check raw keys, missing text, formatting errors, clipping.

Switch game to French, walk scenarios 1, 4 and 8 again.

**Pass:** building reads *boule de cristal* with French description in build menu and
inspect pane, job line reads *scrute la boule de cristal.*, recreation type
listed as *divination*. Nothing in English.

Description the one to read closely: carries paragraph break written as escape, French text that lost it shows as one solid block.

## 15. Saving, and a colony that never had it

Mod stores nothing of its own, claim worth testing rather than trusting.

1. Save while two colonists gazing. Reload.

**Pass:** save loads no red line, colonists carry on or pick new job cleanly, glow there, quality of each ball survived. Pair that was gazing still holds ball, so third colonist offered nothing.

2. Add mod to colony that never had it.

**Pass:** building appears in menu, nothing else changes, no error.

3. Remove it from colony that had balls built.

**Pass:** game warns about missing content, as for any removed mod, colony loads
and plays. Balls gone; nothing else.

## Which scenarios are written as Gherkin, and which are not

`Tests/Pickle/` holds suite Pickle plays in headless WSL game: five features (fifth takes pictures of Workshop page, settles none of fifteen scenarios), twenty-three steps of mod's own in `Source/`, and for everything else Pickle's own vocabulary. What goes to
Gherkin is what only running game can show. What two offline suites already prove not said
again there, because run takes whole machine for tens of minutes. Game's own reaction to flag mod merely declares not tested at all, following `../AUDIT.md` ("on ne
teste pas le jeu"): mod answers for what it declares, not for what engine does with it.

Joy giver asked directly, way game asks each giver during recreation time, instead of
waiting for recreation time to pick it. How often it picks it is `baseChance`, die roll base
game owns and mod only sets, so not measured.

| # | Scenario | Where it is settled |
| --- | --- | --- |
| 1 | It loads, and is buildable | `01-the-ball.feature`: defs after game's own loader, no error and no warning from mod, then colonist builds ball with real designator from jade and gold and no research. That Architect tab lists it is game's; `designationCategory` it names resolved offline. |
| 2 | It looks like what it is | `01`: glow radius, lit by itself, ground on ball's cell lit at night with sky left out, nobody gazing. Violet sphere, stand, size and shadow are judgement about picture: `@review` capture, opened by person. |
| 3 | Quality, beauty, name | `01`: legendary ball more beautiful than poor one, both names carry quality. |
| 4 | A colonist gazes | `02-the-gaze.feature`: giver sends colonist, who walks over, sits on cell beside ball with game's own sit-facing driver, joy rises. |
| 5 | No chair, anywhere | `02`, same scenario: spot chosen with no seat of any kind within six cells, so scenario 4 at stricter setting. |
| 6 | The chair alert | Withdrawn, see above. |
| 7 | Two may share it | `02`: two colonists sit at one ball, third offered nothing. |
| 8 | Divination is a type | `02`: sitting credits tolerance to kind mod added, map's recreation lists it. That four balls tire colonist as fast as one is `JoyToleranceSet` counting per kind, engine's rule not mod's, so not scenario. |
| 9 | It takes eyes | `02`: blind colonist offered nothing, deaf one sent and sits. |
| 10 | Prison cell | **Not applicable.** Mod declares `socialPropernessMatters`; what prison room does with it is `SocialProperness`. Offline, functional suite requires reader in game for every setting mod writes, scan names `SocialProperness` for this one. |
| 11 | It moves house | **Not applicable.** Mod declares `minifiedDef` and thing category; uninstalling and reinstalling is `MinifyUtility`, which scan names as reader. Pairing game's config check enforces tested offline, `01` fails on any error loader raises. |
| 12 | Walking past it | **Not applicable.** `passability` and `pathCost` declared, `Pathing` reads cost. |
| 13 | A recreation room | **Not applicable.** Ball named by giver's `thingDefs`, which `RoomRoleWorker_RecRoom` reads. What room is called is game's scoring. |
| 14 | English and French | `03-language.feature`, played once per language, and `@review` capture of inspect pane. |
| 15 | Saves | `04-save.feature`: save with two colonists gazing loads clean, ball keeps cell and quality, two colonists still gaze afterwards, third still offered nothing since ball full. Adding mod to colony that never had it is what every run does, since fixture predates mod. Removing it from save is change of modlist between two games and game's own missing-content warning: not applicable. |

Ten scenarios written in Gherkin, scenarios 4 and 5 by one of them. One withdrawn, four
not applicable, each for reason table gives. Parts of three of the ten not applicable
for same reason: Architect tab, four balls, removal. Nothing left for person: `@review`
captures were opened (inspect pane in each language, ball at night; info card again on `1.0.1`).

Suite built and checked without game: `dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`,
then shared `../scripts/Check-Steps.ps1 -ModRoot .` (local copy deleted 2026-10-11), which compiles every step pattern with Pickle's own expression
engine and checks each step line of features resolves to exactly one expression. On published `1.0.1`
suite played in English, French and `sanctuary` (2026-10-08 and 2026-10-09, `docs/runs/README.md`).

## What `playTests` requires

Scenarios above = what must be watched. This section = what must be true before
`STATUS.md` may leave `playTests`. Restates step 8 of `../AUDIT.md` for this mod,
with what each rule comes to here.

- **No scenario left in `@wip`.** Scenario set aside either repaired and replayed, or deleted
  with reason. One left standing is scenario waiting, not one passed. Suite has none.
- **Every conditional scenario has run.** Each `@requires:<packageId>` scenario, whether it needs
  optional mod, DLC or companion tool, gets own pass on map that mounts it, report read: `setName`, suite and scenario names checked before cited, since report folder shared by whole machine. Scenario skipped for want of condition not passed scenario. Mod names no optional mod and no DLC, so suite has no `@requires`
  scenario to run.
- **No manual test left to validate.** Each scenario written in Gherkin and green, or listed
  above as not applicable with reason. Nothing left to tick by hand. `@review` captures
  still have to be opened and looked at, but that is reading of image scenario already
  proved to be in intended state, not one more manual test.
- **A green run is not the proof.** Read `exitReason` before numbers, compare scenarios
  played with features discovered, open every `@review` capture. Green says path walked, not that image shows ball, colonist sitting, or tolerance bar.
- Logs read; interface checked in French and in English.

## Passes this mod needs

Mod whose `TESTING.md` does not say how many passes needed is tried, not tested. Two, each with
language fixed when game starts, never switched during run. Three, third is not language:

1. **Minimal set, English.** Core, DLCs, Harmony, RimLogging, Pickle and mod. Only
   pass where capture is clean.
2. **Same set, French.** `03-language.feature` says something only in language it runs in, and
   this is where interface read in French.
3. **`sanctuary`, English** (`-DepMap wsl-deps.sanctuary.map`, renamed from `workshop` on 2026-10-05). Same set plus (steps of two owners: place steps, prefix `Nelim's Sanctuary:`, come from SanctuaryBacklot, which also holds fixture and map's mod list; rest, prefix `Nelim's Pickle Tools:`, from PickleTools) PickleTools' screenshot
   studio loading Nelim's Sanctuary (fixed map, place `podium`), `camerazoom`, `stagedecor`, `colonistrace` and `clearscreen`, which stage posed photographs (rule of 2026-10-02). Plays `05-workshop-captures.feature` alone, three close-up pictures
   for Workshop gallery, `@requires:nelim.pickletools.screenshotstudio` feature that two
   other passes skip. Skipped scenario not passed one, so this pass settles them.

Each pass = one request dropped with ticket dispatcher's `Submit-PickleRun.ps1`, which starts worker that
calls `Run-PickleWsl.ps1` under machine's lock; session keeps no process and watches nothing, dispatcher
wakes it. Exploration or fix asks for fewest scenarios, `-Filter '::<scenario name>'`. Validation pass, initial
or final, asks for all: no `-Filter`, one request per language. `Tests/Pickle/README.md` lists first three
exploration requests.

**No pass without a DLC.** Earlier version of this file declared one, to play claim that no
DLC required. Not mod's guard or fallback that would be played: mod has none, it
simply never names anything DLC defines. Static fact, so proved as one, by
`scripts/Run-Tests.ps1`: every def a field points at, every template def inherits and every C#
class it names must be one Core defines or names, test fails on def, template and class that only DLC has. Run without DLCs would also have to load Pickle's `test-colony`
fixture, saved with Royalty content.

No pass with optional mods, because `loadAfter` names only game, no pass per
incompatibility, none declared. If any appears, this list changes first.

## Evidence to keep

Every run writes into report folder whole machine shares, next run overwrites
it. What kept decided at run, never left to next one.

**Keep**, per scenario, latest report for revision now in repository, nothing else
that newer report replaced:

- report's `exitReason` and played and discovered counts;
- `summary.md` and `junit.xml`;
- `@review` captures person actually opened, one per scenario needing one;
- `Player.log` of run.

**Keep older report** only when sole proof of check latest run did not repeat.
Report about superseded build proves nothing about current one, so goes as soon as
newer one replaces it.

**Where.** On disk, under `Tests/Pickle/Evidence/<run>/`, passed to launcher as
`-EvidenceDir`. Not in git: folder in `.gitignore`, because captures and logs make it
grow without limit and disk full. History = one text line per run in `docs/runs/`,
never folder, run worth citing gets short text summary there that `STATUS.md` points to.

**Minify what stays.** Crop captures to part that proves something, re-encode as
optimized PNG, or JPEG for full-screen shot; compress log. Drop `messages.ndjson` once
`exitReason` and counts read.

**Never** copy shared Pickle report folder whole into mod: keep only files of this
mod's own scenarios. Never delete report that `STATUS.md` field still points to, repoint that
field first. Before deleting, list what goes and what stays.

**Kept on disk** (`Tests/Pickle/Evidence/`, 14 MB, trimmed 2026-10-09): `2026-10-08-final-english` (`8acb`), `2026-10-08-final-french` (`68c7`) and `2026-10-09-final-sanctuary` (`c525`), latest run of each pass on published `1.0.1`. Each holds `summary.md`, `summary.json`, `junit.xml`, `evidence-complete.txt` and gzipped `Player.log`; `report.html` and `messages.ndjson` dropped. Captures kept: info card in English and French; four `workshop` pictures in `sanctuary` pass. Earlier runs one line each in `docs/runs/README.md`.