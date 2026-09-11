# Crystal Ball

A RimWorld 1.6 mod that adds a violet-glowing crystal ball colonists gaze into as recreation — and,
with it, a recreation type the base game does not have.

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

## Tests

```
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Tests.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File _tools/Run-Functional-Tests.ps1
```

Thirty-five tests in two suites, no RimWorld launched, half a minute for both. They read the
installed game — its `Data` folder and `Assembly-CSharp` — so they check what this mod assumes
rather than what this page claims. Every test in both has been seen to fail against a
deliberately broken copy.

The first suite is about the defs: well formed, every element a field 1.6 still has, every class
and def reference resolving, translations complete and correctly spelt. The three sentences above
about the ten recreation types, the four that come from a building, and the `Building` the driver
casts to are computed from the game at every run, so a RimWorld release that moves one of those
numbers is reported rather than quietly ageing this page.

What neither suite does is play. [TESTING.md](TESTING.md) holds the fifteen scenarios that have to
be watched in a running colony — the gaze itself, the chairless room, the tolerance that is counted
per type — with what counts as a pass for each.

The second is about behaviour. The mod hands its whole conduct to vanilla classes, so that suite
asks whether those classes still do what it hands it to them for. It reads the IL of
`JobDriver_SitFacingBuilding.Building` to find the `castclass` this mod rests on, instantiates the
giver through the game's own `Worker` accessor, and scans every method body in the game to find
out who reads each setting these defs write. That last one catches a fault nothing else does: a
setting the mod writes that no code on its path ever reads. Point the def at another joy giver and
`requireChair` goes inert — no error, no log line, colonists refusing to use the building for want
of a chair that is not there — and only that scan notices.

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
