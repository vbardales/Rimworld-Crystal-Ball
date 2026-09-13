# Crystal Ball — in-game test scenarios

Two test suites run beside this file and neither of them starts the game. They check that the defs
are well formed, that the game still has every field and class they name, and that the classes this
mod hands its behaviour to still read the settings it writes. None of that is a single tick of play.
This file is the list of what has to be watched in a running colony, and what counts as a pass.

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

## 6. The game must not ask for chairs

RimWorld has an alert for recreation buildings left without a chair beside them. It inspects the
buildings of one joy giver and looks for a sittable thing in the four cardinal cells.

1. Leave the chairless ball of scenario 5 standing for a while, with colonists using it.

**Pass:** no alert in the top-right corner naming the crystal ball.
**Fail:** an alert asking for chairs around something that needs none — a nag with no cure, since
adding a chair would change nothing about how the ball is used.

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
glow is there, and the quality of each ball survived.

2. Add the mod to a colony that never had it.

**Pass:** the building appears in the menu, nothing else changes, no error.

3. Remove it from a colony that had balls built.

**Pass:** the game warns about missing content, as it does for any removed mod, and the colony loads
and plays. The balls are gone; nothing else is.
