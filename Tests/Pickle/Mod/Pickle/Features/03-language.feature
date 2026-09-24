# The four texts the mod owns, in the language of the pass. TESTING.md scenario 14.
#
# The language is chosen when the game starts (Run-PickleWsl.ps1 -Language French) and is never switched inside a run:
# SelectLanguage reloads every def under the runner and the run dies with it. So the first scenario says something only
# in the language it runs in, and the suite is played once per language.
#
# The second is the picture of it, a @review capture: whether the name and the description fit the inspect pane, and
# whether any of it reads as a raw key. A green says the capture was taken, not that it is right; a person opens it.
Feature: the mod's own texts

  Background:
    Given the save "test-colony" is loaded

  @timeout:60
  Scenario: the four owned texts read in the language of the pass
    Then Crystal Ball: the four owned texts read in the language of the pass

  @review @timeout:90
  Scenario: the ball's name and description in the inspect pane
    Given Crystal Ball: a crystal ball "Words" stands on open ground with no seat within 6 cells
    When Crystal Ball: I put the camera on the ball "Words"
    And Crystal Ball: I select the ball "Words"
    And I wait 60 ticks
    And I take a screenshot "crystal-ball-inspect"
    Then no errors were logged
