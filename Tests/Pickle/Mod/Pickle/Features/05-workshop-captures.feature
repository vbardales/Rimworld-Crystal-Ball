# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. They are not the review captures of 01 and 03.
# Staged, not found (PUBLISHING.md, "Images": the owner's rules of 2026-10-02 and 2026-10-06): every picture is a posed photograph.
#
# THE STORY (shotlist v3, 2026-11-17, STATUS.md "Shotlist"): the seer's evening. One hut at the water's edge of Nelim's Sanctuary, the light going down.
# At 17:00 the seer walks in through the east door and crosses the room toward her crystal ball while the first torch burns (picture 1, wide); at 18:00
# all three torches are lit and she gazes into the ball (picture 2, medium); at 23:00 the torches have died and only the ball's own glow is left (picture 3,
# feature 07, close). The cue that changes in the three pictures: torches lit 1, then 3, then 0, and a violet cape at night. The seer is Nelim, the protagonist
# (GALLERY.md, 2026-10-14). What she carries is chosen: hairstyle `Roo_HD_Hair_Highpony` (her official canon hairstyle, Virginie 2026-11-17: "la coiffure officielle Nelim"; `Flowy` dropped) (validated by Virginie 2026-11-17: "ok pour la coiffure (pour faire mage)"), a robe of
# plain leather (tan against the violet ball), her CANON eyes `Eyes_DarkBrown` (no eye colour step: Virginie 2026-11-17, "pas pour les yeux"), and a face that
# changes from one picture to the next (her own canon smirk on arrival, a relaxed gaze while she looks, sleepy lids and a dreamy look at night). The hut (`hut`,
# the tea room) is roofed, so its light is the torches' and the ball's. The room is emptied, the set laid inside it, and taken down with the scenario.
#
# THE SHOOTING PLAN (one line per picture: place, time, subject, composition, the living thing, the instant, what it says).
#   1. `1-the-seer-arrives`: hut, 17:00, Clear. Wide (zoom 3.0, 6 cells tall, the ball about 23 px at 268 px) on (143, 74) (take 4, framed one cell higher, showed her already beside the ball at the far west edge, bare floor, no torch lit in frame): the east door (146, 73) in frame (the door stays shut: no open-door step), the ball at (140, 74),
#      a rose and a daylily in pots north and south of it, a small sculpture east of the ball, the lit torch above.
#      Only the torch (143, 76), north-east of the ball, is lit, the other two are put out (placed torches burn by default, first take showed three lit): she lit it as she came in. THE INSTANT: Nelim has just come through the east door (146, 73) and is walking
#      to the ball, caught mid-stride about three cells in (the game is paused after the room is set up, the job is given at the door, then 40 + 6 ticks are advanced: take 4 left the speed on ultrafast between steps, so the game kept running and she arrived; no
#      draft, no posed stance). It says: a seer walks in at dusk toward a violet ball in a half-lit room.
#   2. `2-a-colonist-gazing`: hut, 18:00, Clear. Medium (zoom 3.3, the ball about 20 px at 268 px) on (140, 73) (take 4 at zoom 2.6 showed one torch only): the three lit torches (137, 71), (144, 70), (143, 76) in frame, the east sculpture, the pots, the shelf edge: Nelim on the west cell beside the ball in the middle of the frame, in profile facing east, the torch
#      (137, 71) behind her and the other two lit around. The pots north and south leave only the west and east cells free: she takes the west one,
#      no chair anywhere (the room was emptied). THE INSTANT: the last torch has just caught, she has turned to the ball and gazes (the game's own sit-facing driver
#      draws her standing on the cell, gaze on the ball), calm kit and expression `SocialRelax` set after she arrives. It says: they gaze into it on their own, as recreation.
#   3. Feature 07: `3-the-ball-glowing-in-the-dark`, 23:00, no torch.
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
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
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
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (142, 72)

  # 1. The seer arrives, at 17:00: she walks in through the east door toward the ball, the first torch lit by the door (wide).
  @timeout:240
  Scenario: the seer walks in toward the ball, wide
    Given I set the hour to 17
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the decor "TorchLamp" at (143, 76) is lit
    And Nelim's Pickle Tools: the building "TorchLamp" at (137, 71) is put out
    And Nelim's Pickle Tools: the building "TorchLamp" at (144, 70) is put out
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "First" stands at (140, 74)
    And I wait 60 ticks
    And game speed is paused
    And Nelim's Pickle Tools: "Nelim" stands at (146, 73) facing West
    And "Nelim" needs "Joy" is set to 10 percent
    When Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Crystal Ball: the joy giver sends "Nelim" to the ball "First" to sit on its west side
    And Nelim's Pickle Tools: the movement of "Nelim" is written to the log
    And game speed is normal
    And I wait 70 ticks
    And game speed is paused
    And Nelim's Pickle Tools: the movement of "Nelim" is written to the log
    And Nelim's Pickle Tools: I frame the cell (143, 74) at zoom 3.0
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the game is advanced by 6 ticks
    And Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: the thermal state and thoughts of "Nelim" are logged
    Then I take a screenshot "workshop 1 - the seer arrives"

  # 2. What it does, at 18:00: all torches lit, she gazes into the ball, no chair anywhere near (medium).
  @timeout:360
  Scenario: a colonist gazing into the ball, medium
    Given I set the hour to 18
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the decor "TorchLamp" at (137, 71) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 70) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (143, 76) is lit
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Third" stands at (140, 74)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (139, 74) facing East
    And "Nelim" needs "Joy" is set to 10 percent
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Third" to sit on its west side
    Then Crystal Ball: "Nelim" sits beside the ball "Third"
    When Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" facial expression is "SocialRelax"
    And Nelim's Pickle Tools: I frame the cell (140, 73) at zoom 3.3
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 2 - a colonist gazing"
