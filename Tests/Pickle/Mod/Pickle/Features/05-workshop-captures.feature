# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. They are not the review captures of 01 and 03.
# Staged, not found (PUBLISHING.md, "Images": the owner's rules of 2026-10-02 and 2026-10-06): every picture is a posed photograph.
#
# THE STORY: the seer's evening. In the hut at the water's edge of Nelim's Sanctuary, a seer arrives at the end of an afternoon with the one thing she brought,
# her crystal ball. She lights the torches one after the other (picture 1: the first one, picture 2: all three), sits down beside the ball and looks into it,
# then the torches go out and only the ball's own glow is left (picture 3, feature 07). One place, one room, the light going down.
# The seer is Nelim, the one colonist of the map (Virginie herself), the protagonist of the series (GALLERY.md, 2026-10-14), moved to the hut for the pictures.
# What she carries is chosen, not left to the defaults: the long flowing hairstyle `Flowy` (a seer's hair, left in its own colour), a robe of plain leather,
# tan against the violet of the ball, brown eyes, and a face that changes from one picture to the next (her own smirk on arrival, a relaxed gaze while she looks
# into the ball, sleepy lids and a dreamy look at night). The hut (`hut`, the tea room) is covered, so its light is the torches' (PickleTools docs/GALERIE.md).
# The room is emptied, the set laid inside it, and taken down with the scenario. The save on disk is never touched.
#
# THE SHOOTING PLAN (one line per picture: place, time, subject, composition, the living thing, what it says).
#   1. hut, 17:00 (set hour 17, then only the set-up time). Wide enough to see the whole room (camera root size 7). The ball stands in the middle of the room on
#      the bare plank floor at (140, 74), a rose and a daylily in pots north and south of it, the shelf and the bookcase on the west wall, two small sculptures
#      in the corners. Only the first torch is lit: the seer has just arrived. Nelim stands beside the shelf, off centre, facing the ball, her own face on.
#      It says: here is what the mod adds, a ball to look into, in a room that is getting ready for it.
#   (Picture 2 of the first shooting, the ball at 17:30 closer, was refused by Virginie on 2026-10-08: it said nothing more than picture 1. Its scenario was removed.)
#   2. hut, 18:00 (the hour is set to 18: the 2500 ticks of waiting it replaced exposed the run to a vanilla NullReference on a far chicken, run 3b46). Closer
#      (camera root size 5), the same corner, in the dusk, the three torches now lit. The pots north and south of the ball leave only its west and east sides free,
#      so that the seer sits beside it and not behind it (run e7f3: she sat on the north cell and hid it). Nelim sits on the west cell, no chair anywhere near
#      (the room was emptied), her gaze relaxed. It says: they gaze into it on their own, as recreation, without a seat.
#   3. Feature 07: the same room at 23:00, no torch, the glow alone.
#   The pictures are cropped from 1920 x 1080 and compressed to under 2 MB each, under 8 MB in all; each is opened and read against this plan.
#   Each picture then gets its English subtitle (PUBLICATION.md, "Gallery subtitles"; GALLERY.md, "Sous-titres"), from the clean original in Art/Gallery-clean/.
#
# Time passes in the series (2500 ticks per game hour): the hour is set in each scenario (each one reloads the save), then the scenario
# waits before it places what lives in the scene. Nothing asserts about a picture: a person opens each one, and a passing
# scenario says only that the route ran. The interior is x 135-145, z 69-77, doors at (140, 68) and (146, 73) (read on the photograph of the empty
# hut, run dd90). The ball is placed on its exact cell with Crystal Ball: a crystal ball ... stands at (x, z): the older step that searches for open ground refuses a roofed cell and put the ball outside the wall (run c4db). The animals are kept out of the hut for the whole scenario (the animals are kept out of the sanctuary): they walked back in through the doors in run a7c4. The torches are three and not symmetrical, so that the picture is not a catalogue plate.
#
# `@requires:nelim.pickletools.screenshotstudio`: only a pass of `-DepMap wsl-deps.sanctuary.map` stages the Sanctuary and plays this feature; every other
# pass skips it. Aim at it with `-Filter '05-workshop-captures'`.
@requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.colonistrace
@workshop @review
Feature: the pictures of the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hut"
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "hut"
    And Nelim's Sanctuary: the sanctuary "hut" is emptied
    And I destroy the gear of "Nelim"
    And Nelim's Pickle Tools: "Nelim" eye colour is rgb (92, 58, 36)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Flowy"
    And I dress "Nelim" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (137, 71)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 70)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (143, 76)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (140, 75)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (140, 73)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (136, 73)
    And Nelim's Pickle Tools: I place the decor "Bookcase" at (138, 77)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (136, 70)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (144, 77)

  # 1. What it is, at 17:00: the seer arrives, the first torch is lit, the ball waits in the middle of the room.
  @timeout:240
  Scenario: the seer arrives at the ball, wide
    Given I set the hour to 17
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the decor "TorchLamp" at (137, 71) is lit
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "First" stands at (140, 74)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (137, 74) facing East
    And I draft "Nelim"
    When Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: I frame the cell (140, 73) at zoom 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. What it does, at 18:00: all torches lit, the seer sits beside the ball, no chair anywhere near.
  @timeout:360
  Scenario: a colonist gazing into the ball, close up
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the decor "TorchLamp" at (137, 71) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 70) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (143, 76) is lit
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Third" stands at (140, 74)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (143, 74) facing West
    And "Nelim" needs "Joy" is set to 10 percent
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Third" to sit on its west side
    Then Crystal Ball: "Nelim" sits beside the ball "Third"
    When Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" facial expression is "SocialRelax"
    And Nelim's Pickle Tools: I frame the cell (140, 74) at zoom 5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 2 - a colonist gazing"
