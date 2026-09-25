# A save taken while two colonists are gazing loads clean, and the ball is still what it was. TESTING.md scenario 15.
#
# The mod stores nothing of its own, so what this checks is that the game's own save handles a ball in use: no error at
# the reload, the ball where it was with the quality it had, the two colonists still gazing at it, and a third still
# offered nothing since the ball is full: the giver was first read as sending the third one, which the first full passes
# refused, both languages, "CanBeGivenTo holds but TryGiveJob returned no job", because the saved pair still held the
# ball. That the giver sends a colonist to a free ball is scenario 4. The balls are found again by their cell, since a
# reload replaces every object of the map.
#
# Adding the mod to a colony that never had it is what every run does, the fixture predating the mod. Removing it from
# a save is a change of modlist between two games and the game's own warning: it is not a scenario (TESTING.md).
Feature: a save with the ball in use

  Background:
    Given the save "test-colony" is loaded

  @timeout:300
  Scenario: a save taken with two colonists gazing loads clean and the ball is still a masterwork
    Given a colonist "Save-1" exists
    And a colonist "Save-2" exists
    And "Save-1" needs "Joy" is set to 10 percent
    And "Save-2" needs "Joy" is set to 10 percent
    And Crystal Ball: a masterwork crystal ball "Kept" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    When Crystal Ball: the joy giver sends "Save-1" to the ball "Kept"
    And Crystal Ball: the joy giver sends "Save-2" to the ball "Kept"
    Then Crystal Ball: "Save-1" sits beside the ball "Kept"
    And Crystal Ball: "Save-2" sits beside the ball "Kept"
    When I save and reload
    Then no errors were logged
    And Crystal Ball: the ball "Kept" stands where it was, with the quality it had
    And Crystal Ball: "Save-1" sits beside the ball "Kept"
    And Crystal Ball: "Save-2" sits beside the ball "Kept"
    Given a colonist "Save-3" exists
    And "Save-3" needs "Joy" is set to 10 percent
    Then Crystal Ball: the joy giver offers "Save-3" nothing
