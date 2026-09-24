# The mod's behaviour: a colonist gazes, and what that does to recreation. TESTING.md scenarios 4, 5, 7, 8 and 9.
#
# The joy giver is asked directly, the way JobGiver_GetJoy asks each giver (CanBeGivenTo, then TryGiveJob), instead of
# waiting for recreation time to pick it. How often recreation time picks the giver is baseChance, a die roll the base
# game owns and this mod only sets: it is not measured. Everything the giver decides once picked is decided here, and
# the job it hands out is started as the game starts it.
#
# What each scenario stands for:
#
#   4 and 5  a colonist is sent to the ball, walks over and sits on the ground on a cell beside it, and joy rises. The
#            spot is chosen with NO seat of any kind within six cells, so this one scenario is the chairless one as
#            well: requireChair is false, and a giver that still wanted a chair would offer nothing here. The two
#            scenarios of TESTING.md are the same scenario at its stricter setting.
#   7        two may gaze at one ball and a third is offered nothing (joyMaxParticipants is 2).
#   8        the kind the mod added is credited by a sitting, and the colony's recreation lists it. That tolerance is
#            counted per KIND, so that four balls tire a colonist as fast as one, is the base game's rule and not the
#            mod's: it is not a scenario (TESTING.md says why).
#   9        the ball asks for sight and nothing else: a blind colonist is offered nothing, a deaf one is sent and sits.
Feature: a colonist gazes into the ball

  Background:
    Given the save "test-colony" is loaded

  @timeout:180
  Scenario: a colonist with low joy is sent to the ball and sits beside it with no seat anywhere near
    Given a colonist "Gazer" exists
    And "Gazer" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Bare" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    When Crystal Ball: the joy giver sends "Gazer" to the ball "Bare"
    Then Crystal Ball: "Gazer" sits beside the ball "Bare"
    When I wait 600 ticks
    Then Crystal Ball: "Gazer"'s joy has risen since the giver sent them
    And "Gazer" has job "CB_GazeIntoCrystalBall"
    And no errors were logged

  @timeout:240
  Scenario: two colonists may share the ball and a third is offered nothing
    Given a colonist "Share-1" exists
    And a colonist "Share-2" exists
    And a colonist "Share-3" exists
    And "Share-1" needs "Joy" is set to 10 percent
    And "Share-2" needs "Joy" is set to 10 percent
    And "Share-3" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Pair" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    When Crystal Ball: the joy giver sends "Share-1" to the ball "Pair"
    And Crystal Ball: the joy giver sends "Share-2" to the ball "Pair"
    Then Crystal Ball: "Share-1" sits beside the ball "Pair"
    And Crystal Ball: "Share-2" sits beside the ball "Pair"
    And Crystal Ball: the joy giver offers "Share-3" nothing

  @timeout:300
  Scenario: a sitting builds tolerance for divination and the recreation on the map lists it
    Given a colonist "Tired" exists
    And "Tired" needs "Joy" is set to 10 percent
    Then Crystal Ball: "Tired" has no tolerance for divination
    And Crystal Ball: the recreation on the map does not list divination
    Given Crystal Ball: a crystal ball "Kind" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    Then Crystal Ball: the recreation on the map lists divination
    When Crystal Ball: the joy giver sends "Tired" to the ball "Kind"
    Then Crystal Ball: "Tired" sits beside the ball "Kind"
    When I wait 1500 ticks
    Then Crystal Ball: "Tired" has built up tolerance for divination

  @timeout:240
  Scenario: a colonist who cannot see is offered nothing and one who cannot hear is sent and sits
    Given a colonist "Blind" exists
    And a colonist "Deaf" exists
    And Crystal Ball: "Blind" is made blind
    And Crystal Ball: "Deaf" is made deaf
    And "Blind" needs "Joy" is set to 10 percent
    And "Deaf" needs "Joy" is set to 10 percent
    And Crystal Ball: a crystal ball "Eyes" stands on open ground with no seat within 6 cells
    And game speed is ultrafast
    Then Crystal Ball: the joy giver offers "Blind" nothing
    And Crystal Ball: the joy giver offers "Deaf" a gaze
    When Crystal Ball: the joy giver sends "Deaf" to the ball "Eyes"
    Then Crystal Ball: "Deaf" sits beside the ball "Eyes"
