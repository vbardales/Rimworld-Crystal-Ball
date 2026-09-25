# The pictures of the Workshop page, PUBLICATION.md section 2, in the order to upload them. They are not the review captures
# of 01 and 03: those show a whole colony around the ball at the game's default zoom, where the ball is a few dozen pixels
# wide, and a Workshop page sells nothing with that.
#
# Each scenario puts the ball on open ground of the fixture, frames it at the game's closest zoom and takes a picture.
# The interface is left as it is: at that zoom the ball is in the middle of the screen and the picture is cropped around
# it afterwards, which leaves the HUD out (Art/Crop-WorkshopScreenshots.ps1). Nothing asserts about the image: a person
# opens each one, and a passing scenario says only that the route ran.
@workshop @review
Feature: the pictures of the Workshop page

  Background:
    Given the save "test-colony" is loaded

  # 1. What it is: the sphere on its stand, in daylight, where the glow is not what carries the picture.
  @timeout:90
  Scenario: the ball by day, close up
    Given I set the hour to 12
    And I set the weather to "Clear"
    And Crystal Ball: a crystal ball "Day" stands on open ground with no seat within 6 cells
    When Crystal Ball: I put the camera on the ball "Day"
    And I zoom all the way in
    And I wait 60 ticks
    Then I take a screenshot "workshop 1 - the ball by day"

  # 2. The landmark the description promises: the same ball in the dark.
  @timeout:90
  Scenario: the ball at night, close up
    Given I set the hour to 2
    And I set the weather to "Clear"
    And Crystal Ball: a crystal ball "Night" stands on open ground with no seat within 6 cells
    When Crystal Ball: I put the camera on the ball "Night"
    And I zoom all the way in
    And I wait 60 ticks
    Then I take a screenshot "workshop 2 - the ball at night"

  # 3. What it does: a colonist sitting on the cell beside it, with no chair anywhere near.
  @timeout:180
  Scenario: a colonist gazing into the ball, close up
    Given I set the hour to 20
    And I set the weather to "Clear"
    And a colonist "Pictured" exists
    And "Pictured" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Gazed" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    When Crystal Ball: the joy giver sends "Pictured" to the ball "Gazed"
    Then Crystal Ball: "Pictured" sits beside the ball "Gazed"
    When Crystal Ball: I put the camera on the ball "Gazed"
    And I zoom all the way in
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - a colonist gazing"
