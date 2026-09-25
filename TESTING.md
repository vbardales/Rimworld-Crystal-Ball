# Crystal Ball — in-game test scenarios

Two test suites run beside this file and neither of them starts the game. They check that the defs
are well formed, that the game still has every field and class they name, and that the classes this
mod hands its behaviour to still read the settings it writes. None of that is a single tick of play.
This file is the list of what has to be watched in a running colony, and what counts as a pass.
Most of it is written as Gherkin in `Tests/Pickle/`: the table "Which scenarios are written as
Gherkin, and which are not" says where each one is settled.

It is not shipped: it lives beside `Mod/`, never inside it, so Steam never receives it.

## Before starting

- RimWorld 1.6. **No DLC required** — and the first pass is worth doing with every DLC disabled,
  since the mod claims to need none. Development mode on, so that silent failures become red text.
- The log to read afterwards, and to attach to any report:
  `C:\Users\nelim\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log`
- Materials: 40 jade and 5 gold per ball, and jade is not something a colony has lying about.
  Debug actions → Spawn thing → `Jade` and `Gold`, or Debug → make the map's resources generous.
- A colonist or two with recreation already low, and a schedule block set to Recreation. Debug
  actions → Needs → set recreation to zero is faster than waiting.

Useful conversions: 60 ticks is one second at normal speed, 2500 ticks is one in-game hour. A full
gaze is 4000 ticks, so about an hour and a half; the glow's radius of 3 is three cells of light in
each direction.

## 1. It loads, and it is buildable from nothing

The mod is four defs and a texture. If the ThingDef failed its config check, the building is simply
absent from the menu and nothing else in this file can be tested.

1. Start or load a colony with the mod active.
2. Open the Architect menu, **Recreation** tab.

**Pass:** **crystal ball** is there, with no research prerequisite, costing 40 jade and 5 gold. Its
tooltip carries the description, and the build icon is the ball itself rather than a pink square.
**Fail:** absent from the tab, or present with a missing-texture icon.

Check the log for any red line naming `CB_`, any `Could not resolve cross-reference`, and in
particular `is not minifiable yet has thing categories` — that one is a config error this def is
shaped to avoid, and it would take the whole def down.

Try it on a **neolithic** start too: the def says neolithic tech level and no research, so a tribe
must be able to build it on day one, materials permitting.

## 2. It looks like what it is

1. Build one in the open and look at it.

**Pass:** a violet sphere on a stand, drawn slightly larger than its cell, with a shadow. It glows
**at once, by itself**, with no power, no fuel and no switch, and the glow is violet rather than the
warm yellow of a lamp.

2. Wait for night, or Debug actions → set the hour to 2.

**Pass:** the ball lights roughly three cells around itself. It is a landmark, not a lamp: a room
lit only by it stays dim, and the game's lit/unlit indicator (Architect → Recreation → hover, or the
light overlay) shows a small bright patch.

The glow is deliberate and permanent — an unlit crystal ball is a paperweight. What must **not**
happen is the glow appearing only while a colonist uses it.

## 3. Quality, beauty, and the name

1. Build several, or Debug actions → Spawn thing with quality set.
2. Read the inspect pane and the beauty figure at different qualities.

**Pass:** each ball carries a quality. Beauty rises with it — the def's base beauty is 10 and the
vanilla quality StatPart scales it. A **masterwork** or **legendary** one gets its own name, the way
any quality furniture does.

## 4. A colonist decides to gaze, on their own

This is the mod. There is no right-click order to gaze, by design: vanilla offers none for its own
chess table either, and recreation is chosen by the colonist.

1. Put a colonist with low recreation on a Recreation schedule block, near the ball.
2. Let time run.

**Pass:** they walk over, **sit down on the ground on a cell beside it, facing it**, and their
inspect line reads *gazing into the crystal ball.* Recreation rises while they sit. Left alone they
stay about an hour and a half.

**Fail, and the one to watch for:** they walk over and stand there, or they never come at all while
other recreation is available. Also watch for an `InvalidCastException` in the log the moment they
sit — that is the cast the driver makes, and it would mean the def stopped being a building.

## 5. No chair, anywhere

The single most breakable thing in the mod, and the one that breaks without a word: you crouch in
front of a crystal ball, you do not pull a dining chair up to it.

1. Build a ball in a room with **no chair, stool or bench of any kind**, and no sittable furniture
   in the room next door either.
2. Send a colonist on recreation.

**Pass:** they use it exactly as in scenario 4.
**Fail:** they ignore it, or they walk off to find a chair. That is what the def's `requireChair`
guards against, and a fortune teller's caravan full of balls and no seating would stand idle.

## 6. The game must not ask for chairs — not applicable

Withdrawn on 2026-09-24. It watched for RimWorld's alert about recreation buildings left without a
chair, and asked that it never name the crystal ball. That alert cannot reach the ball, so there is
nothing to watch.

What the compiled game says: `Alert_JoyBuildingNoChairs` is abstract, and it has exactly two
subclasses. `Alert_ChessTableNoChairs` gets its joy giver from `JoyGiverDefOf.Play_Chess` and
`Alert_PokerTableNoChairs` from `JoyGiverDefOf.Play_Poker`. The alert lists the buildings named by
that one giver's `thingDefs`, and the ball belongs to `CB_GazeIntoCrystalBall`, a giver of its own.
No alert of the game can list it, with or without a chair beside it.

The slot keeps its number so that the others do not move. The scenario was wrong for the reason
`../AUDIT.md` gives for deleting one: it asked a running game for what is settled by reading it.
The premise had been written down without resolving which giver the alert watches.

## 7. Two may share it, a third may not

The job allows two participants: you read someone's future, or you read your own. Not eight at once.

1. Send two colonists to gaze at the same ball. Then a third.

**Pass:** two sit at it, on different cells. The third does something else — another ball, another
kind of recreation, or nothing. Nobody stacks on an occupied cell.

## 8. Divination is a type of its own

The reason the mod exists. Tolerance is counted per recreation type, and expectations ask for a
number of **different** types.

1. Open a colonist's Needs tab and hover the Recreation bar.

**Pass:** **divination** is listed among the recreation types they have been getting, beside the ten
vanilla ones. Its tolerance rises as they use the ball and falls while they do not.

2. Build three more balls and let a colonist use them all.

**Pass:** tolerance still rises just as fast. Four balls tire a colonist exactly as fast as one —
that is the rule the mod is built around, and seeing it is the point.

3. Check the colony's recreation variety, in the Needs tab tooltip that lists what is available on
   the map.

**Pass:** divination is counted there as one of the types the colony offers. That is what makes an
eleventh type worth more than a tenth piece of furniture on a type already served.

## 9. It is looked into, so it takes eyes

The job asks for sight and nothing else.

1. Blind a colonist (Debug actions → add a hediff destroying both eyes).

**Pass:** they never gaze, and recreation time sends them elsewhere.

2. Deafen a colonist instead.

**Pass:** they gaze normally. Hearing has nothing to do with it.

## 10. Where it stands matters

The def sets `socialPropernessMatters`, as furniture meant for the people who own the room.

1. Build one inside a prison cell.

**Pass:** colonists do not walk into the cell to use it. The prisoner in that cell does.

## 11. It moves house

1. Select the ball, **Uninstall**. Let a colonist carry it away.

**Pass:** it becomes a minified crystal ball, an item that can be hauled and stored. It appears
under **Buildings** → recreation in a stockpile's filter tree, and it keeps its quality.

2. Re-install it somewhere else.

**Pass:** it goes up with the same quality, and the glow comes back with it.

3. Deconstruct one instead.

**Pass:** it returns part of its jade and gold, as any building does.

## 12. Walking past it

The def is pass-through with a high path cost: colonists may cross its cell but would rather not.

1. Put the ball in the middle of a corridor and watch the traffic.

**Pass:** the corridor still works — nobody is trapped, no red pathing error — but colonists step
around the ball when there is room. It does not act as a wall.

## 13. It is furniture in a recreation room

A room's role is worked out from what stands in it, and the buildings a joy giver names count.

1. Put a ball in a small closed room with nothing else of note.
2. Select the room (or hover it with the inspect overlay).

**Pass:** the room is read as a **recreation room**, and its impressiveness is worked out as one.

## 14. English and French

First run scenarios 1, 4 and 8 in English. Check *crystal ball*, its full description,
the job report *gazing into the crystal ball.* and the recreation type *divination*.
In both languages, check for raw keys, missing text, formatting errors and clipping.

Switch the game to French and walk scenarios 1, 4 and 8 again.

**Pass:** the building reads *boule de cristal* with its French description in the build menu and in
the inspect pane, the job line reads *scrute la boule de cristal.*, and the recreation type is
listed as *divination*. Nothing appears in English.

The description is the one to read closely: it carries a paragraph break written as an escape, and a
French text that lost it shows as one solid block.

## 15. Saving, and a colony that never had it

The mod stores nothing of its own, which is a claim worth testing rather than trusting.

1. Save while two colonists are gazing. Reload.

**Pass:** the save loads with no red line, the colonists carry on or pick a new job cleanly, the
glow is there, and the quality of each ball survived. A pair that was gazing still holds the ball, so a third colonist is offered nothing.

2. Add the mod to a colony that never had it.

**Pass:** the building appears in the menu, nothing else changes, no error.

3. Remove it from a colony that had balls built.

**Pass:** the game warns about missing content, as it does for any removed mod, and the colony loads
and plays. The balls are gone; nothing else is.

## Which scenarios are written as Gherkin, and which are not

`Tests/Pickle/` holds the suite Pickle plays in the headless WSL game: four features, twenty-two
steps of the mod's own in `Source/`, and for everything else Pickle's own vocabulary. What goes to
Gherkin is what only a running game can show. What the two offline suites already prove is not said
again there, because a run takes the whole machine for tens of minutes. What is the game's own
reaction to a flag this mod merely declares is not tested at all, following `../AUDIT.md` ("on ne
teste pas le jeu"): the mod answers for what it declares, not for what the engine does with it.

The joy giver is asked directly, the way the game asks each giver during recreation time, instead of
waiting for recreation time to pick it. How often it picks it is `baseChance`, a die roll the base
game owns and this mod only sets, so it is not measured.

| # | Scenario | Where it is settled |
| --- | --- | --- |
| 1 | It loads, and is buildable | `01-the-ball.feature`: the defs after the game's own loader, with no error and no warning from the mod, then a colonist builds the ball with the real designator from jade and gold and no research. That the Architect tab lists it is the game's; the `designationCategory` it names is resolved offline. |
| 2 | It looks like what it is | `01`: the glow radius, lit by itself, the ground on the ball's cell lit at night with the sky left out, nobody gazing. The violet sphere, the stand, the size and the shadow are a judgement about a picture: a `@review` capture, opened by a person. |
| 3 | Quality, beauty, name | `01`: a legendary ball is more beautiful than a poor one, and both names carry their quality. |
| 4 | A colonist gazes | `02-the-gaze.feature`: the giver sends a colonist, who walks over, sits on a cell beside the ball with the game's own sit-facing driver, and whose joy rises. |
| 5 | No chair, anywhere | `02`, the same scenario: the spot is chosen with no seat of any kind within six cells, so this is scenario 4 at its stricter setting. |
| 6 | The chair alert | Withdrawn, see above. |
| 7 | Two may share it | `02`: two colonists sit at one ball, a third is offered nothing. |
| 8 | Divination is a type | `02`: a sitting credits tolerance to the kind the mod added, and the map's recreation lists it. That four balls tire a colonist as fast as one is `JoyToleranceSet` counting per kind, the engine's rule and not the mod's, so it is not a scenario. |
| 9 | It takes eyes | `02`: a blind colonist is offered nothing, a deaf one is sent and sits. |
| 10 | Prison cell | **Not applicable.** The mod declares `socialPropernessMatters`; what a prison room does with it is `SocialProperness`. Offline, the functional suite requires a reader in the game for every setting the mod writes, and the scan names `SocialProperness` for this one. |
| 11 | It moves house | **Not applicable.** The mod declares `minifiedDef` and a thing category; uninstalling and reinstalling is `MinifyUtility`, which the scan names as the reader. The pairing the game's config check enforces is tested offline, and `01` fails on any error the loader raises. |
| 12 | Walking past it | **Not applicable.** `passability` and `pathCost` are declared, and `Pathing` reads the cost. |
| 13 | A recreation room | **Not applicable.** The ball is named by the giver's `thingDefs`, which `RoomRoleWorker_RecRoom` reads. What the room is called is the game's scoring. |
| 14 | English and French | `03-language.feature`, played once per language, and a `@review` capture of the inspect pane. |
| 15 | Saves | `04-save.feature`: a save with two colonists gazing loads clean, the ball keeps its cell and its quality, and the two colonists still gaze afterwards, and a third is still offered nothing since the ball is full. Adding the mod to a colony that never had it is what every run does, since the fixture predates the mod. Removing it from a save is a change of modlist between two games and the game's own missing-content warning: not applicable. |

Ten scenarios are written in Gherkin, scenarios 4 and 5 by one of them. One is withdrawn and four are
not applicable, each for a reason the table gives. Parts of three of the ten are not applicable for
the same reason: the Architect tab, four balls, and removal. Nothing is left for a person except to
open the `@review` captures.

The suite is built and checked without a game: `dotnet build Tests/Pickle/Source/CrystalBall.PickleSteps.csproj -c Release`,
then `Tests/Pickle/Check-Steps.ps1`, which compiles every step pattern with Pickle's own expression
engine and checks that each step line of the features resolves to exactly one expression. A run has
not been played yet.

## What `tested` requires

The scenarios above are what has to be watched. This section is what has to be true before
`STATUS.md` may say `tested`. It restates the step `done -> tested` of `../AUDIT.md` for this mod,
with what each rule comes to here.

- **No scenario left in `@wip`.** A scenario set aside is either repaired and replayed, or deleted
  with its reason. One left standing is a scenario waiting, not one passed. The suite has none.
- **Every conditional scenario has run.** Each `@requires:<packageId>` scenario, whether it needs
  an optional mod, a DLC or a companion tool, gets its own pass on a map that mounts it, and its
  report is read: `setName`, suite and scenario names are checked before it is cited, since the
  report folder is shared by the whole machine. A scenario skipped for want of its condition is not
  a passed scenario. This mod names no optional mod and no DLC, so the suite has no `@requires`
  scenario to run.
- **No manual test left to validate.** Each scenario is written in Gherkin and green, or listed
  above as not applicable with its reason. Nothing is left to tick by hand. The `@review` captures
  still have to be opened and looked at, but that is the reading of an image a scenario has already
  proved to be in the intended state, not one more manual test.
- **A green run is not the proof.** Read `exitReason` before the numbers, compare the scenarios
  played with the features discovered, and open every `@review` capture. A green says the path was
  walked, not that the image shows a ball, a colonist sitting, or a tolerance bar.
- Logs read; interface checked in French and in English.

## Passes this mod needs

A mod whose `TESTING.md` does not say how many passes it needs is tried, not tested. Two, each with
the language fixed when the game starts and never switched during a run:

1. **Minimal set, English.** Core, the DLCs, Harmony, RimLogging, Pickle and the mod. The only pass
   where a capture is clean.
2. **Same set, French.** `03-language.feature` says something only in the language it runs in, and
   this is where the interface is read in French.

Each pass is one request dropped with the ticket dispatcher's `Submit-PickleRun.ps1`, which starts the worker that
calls `Run-PickleWsl.ps1` under the machine's lock; the session keeps no process and watches nothing, and the dispatcher
wakes it. An exploration or a fix asks for the fewest scenarios, `-Filter '::<scenario name>'`. A validation pass, initial
or final, asks for all of them: no `-Filter`, one request per language. `Tests/Pickle/README.md` lists the first three
exploration requests.

**No pass without a DLC.** An earlier version of this file declared one, to play the claim that no
DLC is required. It is not the mod's guard or fallback that would be played: the mod has none, it
simply never names anything a DLC defines. That is a static fact, so it is proved as one, by
`_tools/Run-Tests.ps1`: every def a field points at, every template the def inherits and every C#
class it names must be one Core defines or names, and the test fails on a def, a template and a
class that only a DLC has. A run without the DLCs would also have to load Pickle's `test-colony`
fixture, which was saved with Royalty content.

There is no pass with optional mods, because `loadAfter` names only the game, and no pass per
incompatibility, because none is declared. If any of them appears, this list changes first.

## Evidence to keep

Every run writes into a report folder that the whole machine shares, and the next run overwrites
it. What is kept is decided at the run, never left to the next one.

**Keep**, per scenario, the latest report for the revision now in the repository, and nothing else
that a newer report has replaced:

- the report's `exitReason` and its played and discovered counts;
- `summary.md` and `junit.xml`;
- the `@review` captures a person has actually opened, one per scenario that needs one;
- the `Player.log` of the run.

**Keep an older report** only when it is the sole proof of a check the latest run did not repeat.
A report about a superseded build proves nothing about the current one, so it goes as soon as a
newer one replaces it.

**Where.** On disk, under `Tests/Pickle/Evidence/<run>/`, passed to the launcher as
`-EvidenceDir`. It is not in git: the folder is in `.gitignore`, because captures and logs make it
grow without limit and the disk is full. The history is one text line per run in `docs/runs/`,
never a folder, and a run worth citing gets a short text summary there that `STATUS.md` points to.

**Minify what stays.** Crop captures to the part that proves something and re-encode them as
optimized PNG, or JPEG for a full-screen shot; compress the log. Drop `messages.ndjson` once
`exitReason` and the counts are read.

**Never** copy the shared Pickle report folder whole into the mod: keep only the files of this
mod's own scenarios. Never delete a report that a `STATUS.md` field still points to, repoint that
field first. Before deleting, list what goes and what stays.

Nothing exists to trim yet: no run has been played, so there is no evidence folder on disk and none
in git.
