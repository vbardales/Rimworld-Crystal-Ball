# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. Staged, not found: the owner's rule of 2026-10-02 makes every gallery picture a posed photograph. The story is "the seer's corner": a fortune teller reads the evening in a small corner of a camp. One set joins the three pictures (torch lamps all around, two flowering plants, a shelf), and Nelim, the one colonist of the map (Virginie herself), is the seer: dressed in a robe of plain leather, tan against the violet of the ball. Her own hair and face are left as they are. The set is laid by the scenario and taken down after it. They are not the review captures
# of 01 and 03: those show the test colony's plain ground with its zone tints and the game's interface, and a Workshop page
# sells nothing with that.
#
# Each scenario loads Nelim's Sanctuary (PickleTools' fixed 250 x 250 map, the save "Nelims-tribe"), goes to its named place "hut" (the tea room: a covered wooden cabin at the water's edge, 60 cells from the house), empties it, and frames the
# flowers, puts the ball there, moves the camera onto it at the game's closest zoom and takes the picture with the studio's
# presentation mode on (the game's own screenshot mode, Pickle's panel taken out of it), which leaves the interface and the
# colonists' labels out. Nothing asserts about the image: a person opens each one, and a passing scenario says only that
# the route ran.
#
# `@requires:nelim.pickletools.screenshotstudio`: only the pass of `-DepMap wsl-deps.sanctuary.map` stages the Sanctuary and plays
# this feature; every other pass skips it. Aim at it with `-Filter '05-workshop-captures'`.
@requires:nelim.pickletools.screenshotstudio
@workshop @review
Feature: the pictures of the Workshop page

  # 1. What it is: the sphere on its stand, in daylight, in the seer's hut. The hut is covered, so the light inside is the torches': the
  # roof stays (docs/GALERIE.md, "Éclairer un lieu sombre"). The room is emptied and the set laid inside it (x 135-145, z 69-77 inside the
  # walls). Nelim, the one colonist of the map, is moved from her house, 60 cells away, to the hut for the pictures; the name label of a colonist is hidden\n  # by the presentation mode. The save on disk is never touched.
  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: I frame the sanctuary "hut"
    And Nelim's Pickle Tools: the animals are removed from the sanctuary "hut"
    And Nelim's Pickle Tools: the sanctuary "hut" is emptied
    And I destroy the gear of "Nelim"
    And I dress "Nelim" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (136, 70)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 70)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (136, 76)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 76)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (136, 70) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 70) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (136, 76) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (144, 76) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (136, 77)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (144, 77)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (136, 73)

  @timeout:180
  Scenario: the ball by day, close up
    Given I set the hour to 12
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Nelim's Pickle Tools: "Nelim" stands at (139, 73) facing East
    And I draft "Nelim"
    And Crystal Ball: a crystal ball "Day" stands on open ground near (141, 73)
    When Crystal Ball: I put the camera on the ball "Day"
    And Nelim's Pickle Tools: the camera root size is set to 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. The landmark the description promises: the same hut at night, the ball's violet against the warm torchlight.
  @timeout:180
  Scenario: the ball at night, close up
    Given I set the hour to 2
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Nelim's Pickle Tools: "Nelim" stands at (139, 73) facing East
    And I draft "Nelim"
    And Crystal Ball: a crystal ball "Night" stands on open ground near (141, 73)
    When Crystal Ball: I put the camera on the ball "Night"
    And Nelim's Pickle Tools: the camera root size is set to 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 2 - the ball at night"

  # 3. What it does: the seer sits beside it, no chair anywhere near (the room was emptied), in the evening.
  @timeout:300
  Scenario: a colonist gazing into the ball, close up
    Given I set the hour to 20
    And I set the weather to "Clear"
    And game speed is ultrafast
    And "Nelim" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Gazed" stands on open ground near (141, 73)
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Gazed"
    Then Crystal Ball: "Nelim" sits beside the ball "Gazed"
    When Crystal Ball: I put the camera on the ball "Gazed"
    And Nelim's Pickle Tools: the camera root size is set to 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - a colonist gazing"