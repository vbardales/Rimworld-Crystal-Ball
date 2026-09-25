# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. They are not the review captures
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

  # 1. What it is: the sphere on its stand, in daylight, where the glow is not what carries the picture.
  @timeout:120
  Scenario: the ball by day, close up
    Given the save "nelim-zen-meadow-studio" is loaded
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I frame the studio "flowers"
    And game speed is ultrafast
    And I destroy the gear of "Miel"
    And I dress "Miel" in "Apparel_Robe"
    And "Miel" is wearing "Apparel_Robe"
    And I draft "Miel"
    And Crystal Ball: a crystal ball "Day" stands on open ground near (154, 98)
    When Crystal Ball: I put the camera on the ball "Day"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. The landmark the description promises: the same ball in the dark.
  @timeout:120
  Scenario: the ball at night, close up
    Given the save "nelim-zen-meadow-studio" is loaded
    And I set the hour to 2
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I frame the studio "flowers"
    And game speed is ultrafast
    And I destroy the gear of "Miel"
    And I dress "Miel" in "Apparel_Robe"
    And "Miel" is wearing "Apparel_Robe"
    And I draft "Miel"
    And Crystal Ball: a crystal ball "Night" stands on open ground near (154, 98)
    When Crystal Ball: I put the camera on the ball "Night"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 60 ticks
    Then I take a screenshot "workshop 2 - the ball at night"

  # 3. What it does: a colonist sitting on the cell beside it, with no chair anywhere near. Miel is the studio's own colonist
  # of the flower glade. In all three pictures she is dressed in a robe first, the studio's colonists standing there without
  # clothes to be seen, and drafted in the first two so that she stays where she stands.
  @timeout:240
  Scenario: a colonist gazing into the ball, close up
    Given the save "nelim-zen-meadow-studio" is loaded
    And I set the hour to 20
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I frame the studio "flowers"
    And game speed is ultrafast
    And I destroy the gear of "Miel"
    And I dress "Miel" in "Apparel_Robe"
    And "Miel" is wearing "Apparel_Robe"
    And "Miel" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Gazed" stands on open ground near (154, 98)
    When Crystal Ball: the joy giver sends "Miel" to the ball "Gazed"
    Then Crystal Ball: "Miel" sits beside the ball "Gazed"
    When Crystal Ball: I put the camera on the ball "Gazed"
    And I zoom all the way in
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - a colonist gazing"
