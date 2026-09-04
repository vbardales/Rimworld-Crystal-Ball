# Crystal Ball

A RimWorld 1.6 mod that adds a jade crystal ball colonists gaze into as recreation — and, with it,
a recreation type the base game does not have.

No DLC required. No assembly: the mod is defs, one texture, and nothing else.

## Why the type matters more than the furniture

The base game has ten recreation types — Meditative, Social, Gaming_Dexterity, Gaming_Cerebral,
Television, Telescope, HighCulture, Chemical, Gluttonous, Reading — and only four of them come
from a building.

Two rules make that scarcity bite:

- **Expectations ask for up to six different types**, not six pieces of furniture.
- **Tolerance is counted per type.** Ten chess tables tire a colonist exactly as fast as one does.

So an eleventh type is worth more than a tenth piece of furniture on a type you already had. That
is the whole point of this mod; the object is the excuse.

Divination did not have to be invented for the occasion either. A crystal ball carries its own
use, which avoids the usual trap of a recreation type bolted on for the count and justified by
nothing in play.

## What it is

| | |
|---|---|
| **Cost** | 40 jade, 5 gold — a luxury for an established colony, not a starting bench |
| **Tech level** | Neolithic, no research |
| **Recreation type** | `CB_Divination`, its own |
| **Chair** | Not needed. You crouch in front of a crystal ball |
| **Quality** | Yes, so beauty scales and a masterwork one earns its name |
| **Glow** | Faint, violet, permanent, radius 3 — a landmark at night, not a lamp |
| **Minifiable** | Yes |
| **Save data** | None of its own |

## How it works

The walking, sitting and gazing are the base game's own chess-table logic:
`JoyGiver_InteractBuildingSitAdjacent` driving `JobDriver_SitFacingBuilding`, exactly as the game
of Ur uses them, `requireChair` included.

They work here unmodified because a crystal ball is a `Building`. That is not a given: the same
driver raises an `InvalidCastException` on a `Plant`, which is why an anima tree cannot be wired
up this way. Being a building is what lets this mod ship no code at all.

## Languages

English and French.

## Credits

Written with Claude Code (Anthropic); the in-game texture drawn as vector art with the same tool,
the Workshop preview image generated with DALL-E (OpenAI) — under human direction, review and
testing.

Thanks to Ludeon Studios, whose chess table and game of Ur carry every bit of this mod's
behaviour.

## If I go quiet

If I do not answer within a reasonable time after being contacted, anyone may freely update this
or any other of my mods, including publishing a continuation of it. All credit must be preserved.

## Licence

MIT. See [LICENSE](LICENSE).
