# Publishing Crystal Ball

Publication sheet for Workshop item `3806709786`, created by the `0.1.0` prepublication on 2026-09-23 (private, as Steam
creates every item). The `1.0.0` goes out through the manual publish workflow `.github/workflows/publish-tag.yml` of this
repository, run by GitHub Actions: a dry-run of the exact commit first, then `publish` with its full SHA, approved by
Virginie alone. The workflow sends `Mod/` and the change note below; it sends the description only when
`update_description` is on, which it must be for this version, since the page still lacks the `ATTRIBUTION.md` line
(`STATUS.md`, `remaining`). It never sends the gallery or the visibility. Both stay by hand, and Virginie's.

## 1. Steam description

Kept in sync with `Mod/About/About.xml`, which holds the same text. The workflow reads the fenced block below and, with
`update_description` on, replaces the page's description with it; the dry-run prints the converted text and its SHA-256.
The public Steam API returns nothing for a private item, so the dry-run cannot diff it with the page: the description on
the page has to be read by hand before the approval.

```text
A polished sphere on a clawed stand, glowing faintly violet from within. Colonists sit down in front of it, gaze for a while, and get up in a better mood - a recreation source with a recreation type of its own.

[h2]WHY THE TYPE MATTERS MORE THAN THE FURNITURE[/h2]

The base game has ten recreation types, and only four of them come from a building. Expectations ask for up to six different types, and tolerance is counted per type, not per building: ten chess tables tire a colonist exactly as fast as one. An eleventh type is therefore worth far more than a tenth piece of furniture on a type you already had.

Divination did not have to be invented for the occasion either. A crystal ball carries its own use, which avoids the usual trap of a recreation type bolted on for the count and justified by nothing in play.

[h2]WHAT IT IS[/h2]

[list]
[*] Built from jade and a little gold, at neolithic tech. A luxury for an established colony, not a starting bench.
[*] No chair needed. You crouch in front of a crystal ball; you do not pull up a dining chair.
[*] Takes a quality, so beauty scales and a masterwork one gets its name.
[*] Glows faintly and permanently, which makes it a landmark at night without replacing a lamp.
[*] Minifiable, so it moves house with you.
[/list]

No DLC required. No assembly: the walking, sitting and gazing are the base game's own chess-table logic, which works here because a crystal ball is a building.

No save data of its own.

[h2]IF I GO QUIET[/h2]

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

[h2]AI-GENERATED[/h2]

This mod's defs were written with Claude Code (Anthropic), its in-game texture drawn as vector art with the same tool, and its Workshop preview image generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

[h2]THANKS[/h2]

Ludeon Studios, whose chess table and game of Ur carry every bit of this mod's behaviour: it ships no code of its own.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url] and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3733484696]RimLogging[/url] were used for development and testing only; neither is a dependency of the distributed mod.

Full attribution: [url=https://github.com/vbardales/Rimworld-Crystal-Ball/blob/main/ATTRIBUTION.md]ATTRIBUTION.md[/url]. This mod is MIT licensed: [url=https://github.com/vbardales/Rimworld-Crystal-Ball/blob/main/LICENSE]LICENSE[/url]

[url=https://github.com/vbardales/Rimworld-Crystal-Ball]Source code on GitHub[/url]
```

## 2. Images to upload

`Mod/About/Preview.png` is the header image, already on the item from the prepublication; the workflow does not send it
(`update_preview` stays off). `Mod/About/ModIcon.png` ships inside `Mod/`.

The gallery is manual, on the Steam page, in the order below. **The images do not exist yet**: the two `@review` captures
of the Pickle suite are 1920 x 1080 screenshots of a whole colony in which the ball is a few dozen pixels wide, so they
prove the mod works but do not sell it. They have to be produced, cropped to the ball, and opened by Virginie before any
of them goes up. The folder that will hold them, and be given to the dry-run as `--gallery-dir`, is `Art/WorkshopScreenshots/`
(nothing in it but the images, numbered `01-`, `02-`, `03-` in upload order, nothing else).

| # | Intended file | Shows |
| --- | --- | --- |
| 1 | `01-the-ball-at-night.png` | The ball's violet glow on a dark ground, colonists near it: the landmark the description promises |
| 2 | `02-gazing.png` | A colonist sitting on the cell beside the ball, no chair anywhere near |
| 3 | `03-in-the-inspect-pane.png` | The name, the quality and the recreation type in the game's own pane, in English |

## 3. Dependencies to declare on Steam

None. The mod needs no DLC and no other mod, and its `About.xml` declares none. `loadAfter` names `Ludeon.RimWorld` only.
Do not declare Pickle, RimLogging or Harmony: the first two are development tools, and the mod uses Harmony nowhere.

## 4. Steam comments to post

None to prepare. The people and projects thanked are Ludeon Studios, who have no Workshop page to comment on, and Pickle and
RimLogging, whose pages already hold a posted thank-you in the global register (`WORKSHOP_COMMENTS.md`, `posted` since
2026-09-22); Crystal Ball is added to their `Covers`. Claude Code and DALL-E are tools with no page.

## 5. Other Steam fields

- Adult-content questionnaire: **No**. The mod is a violet glass sphere on a stand; nothing mature is depicted. The
  texture and the preview were opened and looked at.
- Tags: none by hand; the game and the workflow send `Mod` and `1.6`.
- Incompatible item: none.
- Visibility: private since creation. Virginie switches it to public herself, after subscribing to the item and testing it,
  and does the two things that follow, by hand (`PUBLISHING.md`, "Mise en production d'une 1.0.0"): subscribe to the
  comments, and "Watch all activity" on the mod; it has no parent mod to watch.

## 6. Rollback

Decided by Virginie on 2026-09-25: the `1.0.0` goes out **privately**. The item stays private after the upload and only she
makes it public, after subscribing to it and testing it, so no player is exposed to a red regression run after the
publication, and there is no target to pick beforehand. If the non-regression comes back red before the switch, it is a
defect of the published version and the answer is a new publication, `ref` the full SHA of the last good commit and the next
patch number (`1.0.1`), never a lower one. The content of `0.1.0`, the prepublication, is commit `3d1243e`; it was never
tested and carries no tag, so it is not a rollback target.

## 7. Update notes

Steam change note for the `1.0.0`, uploaded by the manual workflow, which reads the fenced block under the `### <version>`
heading below. It begins with the version, alone on its line, as the Workshop page shows no version otherwise.

### 1.0.0

```text
[b]1.0.0[/b]

First version for RimWorld 1.6: the crystal ball, a buildable recreation source (40 jade and 5 gold, neolithic, no research) with a recreation type of its own, Divination. English and French.
```
