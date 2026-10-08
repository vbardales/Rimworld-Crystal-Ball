# Publishing Crystal Ball

Publication sheet for Workshop item `3806709786`, created by the `0.1.0` prepublication on 2026-09-23 (private, as Steam
creates every item). The `1.0.0` goes out through the manual publish workflow `.github/workflows/publish-tag.yml` of this
repository, run by GitHub Actions: a dry-run of the exact commit first, then `publish` with its full SHA, approved by
Virginie alone. The workflow sends `Mod/` and the change note below; it sends the description only when
`update_description` is on and the header image only when `update_preview` is on. **Both are on for the `1.0.1`** (Virginie, 2026-10-07):
the description carries the corrected texture provenance, and `Mod/About/Preview.png` carries the new ModIcon badge. They are set at the
dry-run and again at the `publish`. For `1.0.0` only `update_description` was on. The item is public since 2026-09-26. The workflow never
sends the gallery or the visibility: both stay by hand, and Virginie's.

## 1. Steam description

`Mod/About/About.xml` holds the same words in plain text, since the game shows its description as it is and would print the BBCode tags. The workflow reads the fenced block below and, with
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

This mod's defs were written with Claude Code (Anthropic), its in-game texture generated with an AI image model, then cut out, outlined and resized under human direction, and its Workshop preview image generated with DALL-E (OpenAI), under human direction, review and testing. Stated openly: designing with these tools is my job.

[h2]THANKS[/h2]

Ludeon Studios, whose chess table and game of Ur carry every bit of this mod's behaviour: it ships no code of its own.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3791648678]Pickle[/url] and [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3733484696]RimLogging[/url] were used for development and testing only; neither is a dependency of the distributed mod.

Full attribution: [url=https://github.com/vbardales/Rimworld-Crystal-Ball/blob/main/ATTRIBUTION.md]ATTRIBUTION.md[/url]. This mod is MIT licensed: [url=https://github.com/vbardales/Rimworld-Crystal-Ball/blob/main/LICENSE]LICENSE[/url]

[url=https://github.com/vbardales/Rimworld-Crystal-Ball]Source code on GitHub[/url]
```

## 2. Images to upload

`Mod/About/Preview.png` is the header image. The workflow sends it only with `update_preview`, which is **on for the `1.0.1`**
(the Preview was regenerated with a new ModIcon badge); for `1.0.0` it was off, the image coming from the prepublication.
`Mod/About/ModIcon.png` ships inside `Mod/`.

The gallery is manual, on the Steam page, in the order below. `Art/Gallery/` is uploaded as it is (nothing
in it but the images, numbered `0-`, `1-`, `2-`, `3-` in upload order). The dry-run lists it as a reminder once it
exists.

Image `0`, new consigne from Virginie on 2026-09-29: the gallery now opens on a copy of `Mod/About/Preview.png`, the
finished vitrine (title, summary, version badge), so a browser sees the same picture as the store header before
scrolling. The shared `scripts/Render-Preview.cjs` renderer reads `Art/Preview.config.json`, then writes `Mod/About/Preview.png`. `Art/echo.png` is the final pre-sized transparent
line-art mask: it is consumed unchanged, tinted with the accent colour, shown above the panel treatment, flipped
horizontally, and limited to less than half of the text panel. `Art/ModIcon-source.png` is the high-resolution
transparent badge source. It is placed bottom-left at +15 degrees, without outline, over its local radial veil.
The placement is explicit in the config; it is not chosen from an "emptiest corner" rule. After rendering,
`Art/Gallery/0-preview.png` is copied byte-for-byte from `Mod/About/Preview.png`.

The three pictures come from the Pickle feature `05-workshop-captures.feature`, played on Nelim's Sanctuary (`-DepMap wsl-deps.sanctuary.map`,
the Sanctuary now has its own repository, SanctuaryBacklot (`docs/GALERIE.md`, `SANCTUAIRE-LIEUX.md`, `SANCTUAIRE-CASES.md`, generated `docs/steps.md`)). They are staged photographs, not catalogue plates (`PUBLISHING.md`, "Images"): the story is **the seer's corner**, in the
hut (`hut`, the tea room, emptied and lit by torches, roof kept), with Nelim, the map's one colonist, as the seer. A probe (`06-hut-probe.feature`)
lists and photographs the empty hut first, so that the set is laid on known cells. **The feature has not been played on the hut yet, so none of the three
pictures below is final.** The earlier pictures (meadow studio with Miel, then the podium) are discarded: the podium showed a bright green marking square.
A crop (the script that did it was removed from `Art/` on 2026-10-02; `git show 800b8aa:Art/Crop-WorkshopScreenshots.ps1`) and a re-compression keep each image
under 2 MB and the folder under 8 MB. Each image is opened and read against the shooting plan in the feature's header before it goes to `Art/Gallery/`.

Steps of the feature, by owner. **SanctuaryBacklot (SB), prefix `Nelim's Sanctuary:`**: `I am at the sanctuary`, `the animals are removed from the sanctuary`, `the animals are kept out of the sanctuary`, `the sanctuary "hut" is emptied`. **Nelim's Pickle Tools (NPT), prefix `Nelim's Pickle Tools:`**: `the eclipse of the map is ended`, `I place the decor` / `the decor ... is lit` (StageDecor), `I frame the cell ... at zoom` (CameraZoom), `studio presentation mode is enabled` (ScreenshotStudio), `"Nelim" stands at ... facing` (ColonistRace). The fixture `Nelims-tribe` lives in SanctuaryBacklot and is not copied or staged here. Nelim has brown eyes, given by EyeGenes (in the map).

Candidate pictures carry `candidate` in their name (`<index>-candidate-<name>.png`); accepted ones lose the word, refused ones are deleted (Virginie, 2026-10-08). Each stays under 2 MB, 8 MB in all.

| # | File | Shows |
| --- | --- | --- |
| 0 | `0-preview.png` | The finished vitrine: title, one-line summary, version badge, line-art echo, and ModIcon corner badge |
| 1 | `1-candidate-the-ball-by-day.png` | The sphere on its stand in the seer's hut, by day: what the mod adds |
| 2 | `2-candidate-the-ball-at-night.png` | The same hut by torchlight, the ball's violet against warm light: the landmark the description promises |
| 3 | `3-candidate-a-colonist-gazing.png` | Nelim, the seer, sitting on the cell beside it with no chair anywhere near, the room having been emptied |

Known limits, to say before she looks: the glow at night may stay discreet; the colonist's name label is hidden
by the presentation mode only if Harmony is loaded (to read in the game log). Picture 0 (badge included) was qualified by Virginie on 2026-09-29; the Preview has
been regenerated since from the new ModIcon source (2026-10-05), and `0-preview.png` is byte-identical to it.
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
- Visibility: public since 2026-09-26, switched by Virginie after her test of the subscribed item. The two things that follow are hers, by hand
  (`PUBLISHING.md`, "Mise en production d'une 1.0.0"): subscribe to the comments, and "Watch all activity" on the mod; it has no parent mod to watch.
  A new version does not change the visibility.

## 6. Rollback

Fail-fast policy (`PUBLISHING.md`, "À chaque mise à jour"; `AUDIT.md`, `prepublished → published`): the `1.0.1` goes out once no red is open, and the
rest of the non-regression runs just after. **Rollback target, chosen before publishing: commit `7d64a56491d7f131ec5770342f65875d993f8279`, the published
`1.0.0` (tag `v1.0.0`).** If the non-regression comes back red, the answer is a new publication, never a lower number: `ref` = that full SHA, the next patch
number (`1.0.2`) and a note "Reverts to 1.0.0, because ...", then, apart, a fix. The item is public, so a red version reaches players until the rollback is
published. As always: dry-run of the exact SHA first, `publish` with its 40 characters, `steam-production` approved by Virginie alone. The content of `0.1.0`, the
prepublication, is commit `3d1243e`; it was never tested and is not a rollback target.

## 7. Update notes

Steam change note for the `1.0.0`, uploaded by the manual workflow, which reads the fenced block under the `### <version>`
heading below. It begins with the version, alone on its line, as the Workshop page shows no version otherwise.

### 1.0.0

```text
[b]1.0.0[/b]

First version for RimWorld 1.6: the crystal ball, a buildable recreation source (40 jade and 5 gold, neolithic, no research) with a recreation type of its own, Divination. English and French.
```

### 1.0.1

```text
[b]1.0.1[/b]

New look for the crystal ball: redrawn in the style of the game's own buildings, with a dark outline and flat tones, so it reads at the size it is shown in game. The French description no longer uses masculine-only agreements. No gameplay change.
```
