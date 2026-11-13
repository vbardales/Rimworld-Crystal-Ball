# 1.7 control (ticket after 553e): does ANY construction freeze on 1.7? NPT's step lays a wood plank floor on one cell with
# a colonist, no crystal ball involved. Frozen: construction or hauling AI on 1.7, not the mod. Green: the ball scenario differs.
Feature: 1.7 construction control

  Background:
    Given the save "test-colony" is loaded

  @timeout:300
  Scenario: a colonist builds one plank floor cell
    When Nelim's Pickle Tools: a colonist builds the floor "WoodPlankFloor" from (146, 157) to (146, 157)
    Then Nelim's Pickle Tools: the terrain of the cell (146, 157) is "WoodPlankFloor"
    And no errors were logged
