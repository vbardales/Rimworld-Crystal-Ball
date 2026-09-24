# The crystal ball as an object: that the real loader accepts the mod's defs, that a colonist can build it, that
# quality reaches its beauty and its name, and that it glows on its own. TESTING.md scenarios 1, 2 and 3.
#
# What each scenario stands for, and what it does NOT stand for:
#
#   1  loads          - the defs as the game's OWN loader built them, and the config errors only it can raise ("is not
#                       minifiable yet has thing categories"). The XML and the fields are proved offline
#                       (_tools/Run-Tests.ps1); this is the same defs after the game read them.
#   1  built          - the real build designator, a colonist with the skill, jade and gold in a stockpile, no research.
#                       It does NOT show that the Architect menu lists the ball: the designator is used by defName, and
#                       the tab is the game's, driven by a designationCategory the offline suite resolves.
#   2  glow           - what lights the ground on the ball's cell at night with the sky left out. A violet sphere on a
#                       stand, drawn slightly larger than its cell with a shadow, is a judgement about a picture: it is
#                       the @review capture, which a person opens.
#   3  quality        - the vanilla quality StatPart reaching Beauty, and the name carrying the quality.
Feature: the crystal ball as an object

  Background:
    Given the save "test-colony" is loaded

  @timeout:60
  Scenario: the mod loads and the game holds its four defs
    Then mod "nelim.crystalball" is loaded
    And def "CB_CrystalBall" of type "ThingDef" exists
    And def "CB_Divination" of type "JoyKindDef" exists
    And def "CB_GazeIntoCrystalBall" of type "JobDef" exists
    And def "CB_GazeIntoCrystalBall" of type "JoyGiverDef" exists
    And no errors were logged
    And no warnings from mod "nelim.crystalball"

  # TESTING.md 1. Skill and priority are set as Pickle's own construction feature does it. 9000 units of work at
  # ultrafast speed still takes thousands of ticks, hence the long timeout.
  @slow @timeout:900
  Scenario: a colonist builds the ball from jade and gold, with no research
    Given a colonist "Builder" exists
    And "Builder" has childhood "ShopKid36"
    And "Builder" has backstory "Blacksmith7"
    Then "Builder" can do "Construction"
    Given "Builder" skill "Construction" is set to level 12
    When I create a stockpile from (150, 160) to (152, 162)
    And 40 "Jade" is spawned at the stockpile
    And 5 "Gold" is spawned at the stockpile
    And I set "Builder" priority "Construction" to 1
    And I use the build designator for "CB_CrystalBall" at (146, 157)
    Then a blueprint for "CB_CrystalBall" is at (146, 157)
    Given game speed is ultrafast
    When I wait for the "CB_CrystalBall" at (146, 157) to be built
    Then a "CB_CrystalBall" is at (146, 157)
    And no errors were logged

  # TESTING.md 3
  @timeout:60
  Scenario: quality scales the ball's beauty and shows in its name
    Given Crystal Ball: a legendary crystal ball "Best" stands on open ground with no seat within 6 cells
    And Crystal Ball: a poor crystal ball "Worst" stands on open ground with no seat within 6 cells
    Then Crystal Ball: the beauty of the ball "Best" is above that of the ball "Worst"
    And Crystal Ball: the ball "Best" is named for its quality
    And Crystal Ball: the ball "Worst" is named for its quality

  # TESTING.md 2. The claim is that the glow is there by itself, permanent, and not only while somebody gazes.
  @review @timeout:90
  Scenario: the ball glows on its own at night
    Given I set the hour to 2
    And Crystal Ball: a crystal ball "Night" stands on open ground with no seat within 6 cells
    Then Crystal Ball: the ball "Night" glows with a radius of 3
    And Crystal Ball: nobody is using the ball "Night"
    And Crystal Ball: the ground at the ball "Night" is lit by the ball alone
    When Crystal Ball: I put the camera on the ball "Night"
    And I wait 120 ticks
    And I take a screenshot "crystal-ball-night"
    Then no errors were logged
