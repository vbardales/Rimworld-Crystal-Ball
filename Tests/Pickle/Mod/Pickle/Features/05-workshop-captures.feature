# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. They are not the review captures of 01 and 03.
# Staged, not found (PUBLISHING.md, "Images": the owner's rules of 2026-10-02 and 2026-10-06): every picture is a posed photograph.
#
# THE STORY: the seer's hut. At the end of an afternoon, in the hut at the water's edge of Nelim's Sanctuary, a seer lights the torches one after the
# other and sits down to look into her crystal ball. The ball is the one thing she brought. One place, one corner, the light going down.
# The seer is Nelim, the one colonist of the map (Virginie herself), moved to the hut for the pictures: dressed in a robe of plain leather, tan against
# the violet of the ball; her hair and face are left as they are. The hut (`hut`, the tea room) is covered, so its light is the torches': the roof stays
# (PickleTools docs/GALERIE.md). The room is emptied, the set laid inside it, and taken down with the scenario. The save on disk is never touched.
#
# THE SHOOTING PLAN (one line per picture: place, time, subject, composition, the living thing, what it says).
#   1. hut, 17:00 (set hour 17, then only the set-up time). The ball in the middle of the room on the bare plank floor, the shelf on the west wall, the
#      two plants in the north and south corners. Wide enough to see the whole room (camera root size 7). Nelim stands beside the shelf, off centre, looking
#      at the ball. It says: here is what the mod adds, a ball to look into, in a room with nothing else in it.
#   2. hut, 17:30 (+30 minutes of game time, 1250 ticks). Closer (camera root size 5), the ball and the torchlight on it. Same corner, the three torches lit and the daylight gone from the doorway. Nelim has moved to the
#      east side, by the second door. It says: the glow is a landmark when the light goes down, and the violet of the ball answers the warm torches.
#   3. hut, 18:00 (+60 minutes, 2500 ticks). Closer (camera root size 5). Same corner, in the dusk. Two flower pots north and south of the ball leave only its west and east\n#      sides free, so that the seer sits beside it and not behind it (run e7f3: she sat on the north cell and hid it). Nelim sits on the cell beside the ball, no chair anywhere near (the room was emptied).
#      It says: they gaze into it on their own, as recreation, without a seat.
#   The pictures are cropped from 1920 x 1080 and compressed to under 2 MB each, under 8 MB in all; each is opened and read against this plan.
#
# Time passes in the series (2500 ticks per game hour): the hour is set once, to 17, in each scenario (each one reloads the save), then the scenario
# waits the cumulative time of its picture before it places what lives in the scene. Nothing asserts about a picture: a person opens each one, and a passing
# scenario says only that the route ran. The interior is x 135-145, z 69-77, doors at (140, 68) and (146, 73) (read on the photograph of the empty
# hut, run dd90). The ball is placed on its exact cell with Crystal Ball: a crystal ball ... stands at (x, z): the older step that searches for open ground refuses a roofed cell and put the ball outside the wall (run c4db). The animals are kept out of the hut for the whole scenario (	he animals are kept out of the sanctuary): they walked back in through the doors in run a7c4. The torches are three and not symmetrical, so that the picture is not a catalogue plate.
#
# `@requires:nelim.pickletools.screenshotstudio`: only a pass of `-DepMap wsl-deps.sanctuary.map` stages the Sanctuary and plays this feature; every other
# pass skips it. Aim at it with `-Filter '05-workshop-captures'`.
@requires:nelim.pickletools.screenshotstudio
@workshop @review
Feature: the pictures of the Workshop page

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: I am at the sanctuary "hut"
    And Nelim's Pickle Tools: the animals are removed from the sanctuary "hut"
    And Nelim's Pickle Tools: the animals are kept out of the sanctuary "hut"
    And Nelim's Pickle Tools: the sanctuary "hut" is emptied
    And I destroy the gear of "Nelim"
    And I dress "Nelim" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (137, 71)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 70)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (143, 76)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (137, 71) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 70) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (143, 76) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (136, 77)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (144, 77)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (136, 73)

  # 1. What it is, at 17:00.
  @timeout:240
  Scenario: the ball by day, close up
    Given I set the hour to 17
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "First" stands at (141, 73)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (138, 75) facing East
    And I draft "Nelim"
    When Crystal Ball: I put the camera on the ball "First"
    And Nelim's Pickle Tools: the camera root size is set to 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. The landmark the description promises, at 17:30: the torches against the going light.
  @timeout:300
  Scenario: the ball at night, close up
    Given I set the hour to 17
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Second" stands at (141, 73)
    And I wait 1250 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (144, 72) facing West
    And I draft "Nelim"
    When Crystal Ball: I put the camera on the ball "Second"
    And Nelim's Pickle Tools: the camera root size is set to 5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 2 - the ball at night"

  # 3. What it does, at 18:00: the seer sits beside it, no chair anywhere near.
  @timeout:360
  Scenario: a colonist gazing into the ball, close up
    Given I set the hour to 17
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Third" stands at (141, 73)
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (141, 74)
    And Nelim's Pickle Tools: I place the decor "PlantPot" at (141, 72)
    And I wait 2500 ticks
    And "Nelim" needs "Joy" is set to 10 percent
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Third"
    Then Crystal Ball: "Nelim" sits beside the ball "Third"
    When Crystal Ball: I put the camera on the ball "Third"
    And Nelim's Pickle Tools: the camera root size is set to 5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - a colonist gazing"
