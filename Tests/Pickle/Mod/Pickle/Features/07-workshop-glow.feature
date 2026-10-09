# Picture 3 of the Workshop page (PUBLICATION.md, section 2): the glow itself, in the dark. Staged, not found (PUBLISHING.md, "Images").
#
# SHOOTING PLAN. 3. hut, 23:00. No torch: the only light of the room is the ball's own faint violet glow (radius 3, permanent), so that
# the picture says what the description promises, "glows faintly and permanently, a landmark at night". The same hut, set and seat as
# pictures 1 and 2 (bookcase, shelf, plants, small sculptures; the sculpture south of the ball keeps the seer from sitting in front of it; the seat side is fixed by the step `sends ... to sit on its east side`: east here, west in picture 2, as in the qualified pictures).
# Nelim sits beside the ball, dressed as in the other pictures but as a mage: the leather robe under a violet cape and a violet hood (a veil over the head; no staff: the carry step put it in her hands and the sitting job dropped it on the floor, run b029), her face turned dreamy: the calm kit with sleepy lids (a mystic look, owner's
# suggestion 2026-10-08), the expression set to normal just before the shot. Closer (camera root size 5), as for picture 2.
# The hour is set to 23 once. The room is roofed, so the daylight is out of it and the glow is the one thing that reads.
#
# Same rules as 05: only a pass of `-DepMap wsl-deps.sanctuary.map` plays it; a person opens the picture, a passing scenario says only that the route ran.
@requires:nelim.pickletools.screenshotstudio
@workshop @review
Feature: the glow of the crystal ball, in the dark

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hut"
    And Nelim's Sanctuary: the animals are kept out of the sanctuary "hut"
    And Nelim's Sanctuary: the sanctuary "hut" is emptied
    And I destroy the gear of "Nelim"
    And Nelim's Pickle Tools: "Nelim" eye colour is rgb (92, 58, 36)
    And I dress "Nelim" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Cape" dyed rgb (98, 52, 150)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_HatHood" dyed rgb (120, 70, 170)
    And Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (136, 77)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (144, 77)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (136, 73)
    And Nelim's Pickle Tools: I place the decor "Bookcase" at (138, 77)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (136, 70)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (141, 76)

  # 3. The glow, at 23:00.
  @timeout:360
  Scenario: the ball glowing in the dark, close up
    Given I set the hour to 23
    And I set the weather to "Clear"
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Fourth" stands at (141, 77)
    And I wait 60 ticks
    And Nelim's Pickle Tools: "Nelim" stands at (144, 77) facing West
    And "Nelim" needs "Joy" is set to 10 percent
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Fourth" to sit on its east side
    Then Crystal Ball: "Nelim" sits beside the ball "Fourth"
    When Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I frame the cell (141, 75) at zoom 5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - the ball glowing in the dark"
