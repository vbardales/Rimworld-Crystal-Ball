# A probe, not a test of the mod: the empty hut of Nelim's Sanctuary, photographed before anything is laid in it. A listing step (cells, walls, doors)
# was announced by Pickle Tools but is not in the source on 2026-10-07: until it exists the photograph is the only reading. The torches and the set of
# 05-workshop-captures.feature are placed on cells known to be free and not on the hypothesis x 135-145, z 69-77. Nothing asserts about the
# photograph: a person opens it. Pass: `-DepMap wsl-deps.sanctuary.map -Filter '06-hut-probe'`.
@requires:nelim.pickletools.screenshotstudio
@workshop @review
Feature: the hut of the Sanctuary, empty

  @timeout:120
  Scenario: the empty hut, listed and photographed
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 17
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: I am at the sanctuary "hut"
    And Nelim's Pickle Tools: the animals are removed from the sanctuary "hut"
    And Nelim's Pickle Tools: the sanctuary "hut" is emptied
    When Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "hut probe - the empty hut"
