# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. Staged, not found: the owner's rule of 2026-10-02 makes every gallery picture a posed photograph. The story is "the seer's corner": a fortune teller reads the evening in a small corner of a camp. One set joins the three pictures (a carpet, a campfire and a torch lamp, two flowering plants, a shelf), and Miel is dressed for it in all three: a robe of plain leather, tan against the violet of the ball, a dark Cleopatra cut so that the face reads, the Oracle tattoo on her face. The set is laid by the scenario and taken down after it. They are not the review captures
# of 01 and 03: those show the test colony's plain ground with its zone tints and the game's interface, and a Workshop page
# sells nothing with that.
#
# Each scenario loads PickleTools' disposable screenshot fixture, the Nelim zen meadow studio, frames its open glade of
# flowers, puts the ball there, moves the camera onto it at the game's closest zoom and takes the picture with the studio's
# presentation mode on (the game's own screenshot mode, Pickle's panel taken out of it), which leaves the interface and the
# colonists' labels out. Nothing asserts about the image: a person opens each one, and a passing scenario says only that
# the route ran.
#
# `@requires:nelim.pickletools.screenshotstudio`: only the pass of `-DepMap wsl-deps.workshop.map` stages the studio and plays
# this feature; every other pass skips it. Aim at it with `-Filter '05-workshop-captures'`.
@requires:nelim.pickletools.screenshotstudio
@workshop @review
Feature: the pictures of the Workshop page

  # 1. What it is: the sphere on its stand, in daylight, in the seer's corner. Miel stands apart, drafted, at the shelf.
  Background:
    Given the save "nelim-zen-meadow-studio" is loaded
    And Nelim's Pickle Tools: I frame the studio "flowers"
    And game speed is ultrafast
    And I destroy the gear of "Miel"
    And "Miel" gender is female
    And Nelim's Pickle Tools: "Miel" hairstyle is "Cleopatra"
    And Nelim's Pickle Tools: "Miel" hair colour is rgb (35, 28, 40)
    And Nelim's Pickle Tools: "Miel" face tattoo is "Face_Oracle"
    And I dress "Miel" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: I lay the floor "Carpet" from (152, 96) to (156, 100)
    And Nelim's Pickle Tools: I place the decor "Campfire" at (157, 97)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (157, 100)
    And Nelim's Pickle Tools: the decor "Campfire" at (157, 97) is lit
    And Nelim's Pickle Tools: the decor "TorchLamp" at (157, 100) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (151, 101)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (156, 102)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (151, 98)
    And Nelim's Pickle Tools: the other colonists are out of frame

  @timeout:180
  Scenario: the ball by day, close up
    Given I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Miel" stands at (152, 99) facing East
    And I draft "Miel"
    And Crystal Ball: a crystal ball "Day" stands on open ground near (154, 98)
    When Crystal Ball: I put the camera on the ball "Day"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. The landmark the description promises: the same corner at night, the ball's violet against the fire's warmth.
  @timeout:180
  Scenario: the ball at night, close up
    Given I set the hour to 2
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: "Miel" stands at (152, 99) facing East
    And I draft "Miel"
    And Crystal Ball: a crystal ball "Night" stands on open ground near (154, 98)
    When Crystal Ball: I put the camera on the ball "Night"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 2 - the ball at night"

  # 3. What it does: the seer sits beside it, no chair anywhere near, in the evening light.
  @timeout:300
  Scenario: a colonist gazing into the ball, close up
    Given I set the hour to 20
    And I set the weather to "Clear"
    And "Miel" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Gazed" stands on open ground near (154, 98)
    When Crystal Ball: the joy giver sends "Miel" to the ball "Gazed"
    Then Crystal Ball: "Miel" sits beside the ball "Gazed"
    When Crystal Ball: I put the camera on the ball "Gazed"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - a colonist gazing"