# Picture 3 of the Workshop page (PUBLICATION.md, section 2): the glow itself, in the dark. Staged, not found (PUBLISHING.md, "Images").
#
# SHOOTING PLAN (shotlist v3, 2026-11-17). 3. `3-the-ball-glowing-in-the-dark`: hut, 23:00, Clear, no torch: the only light of the room is the ball's own faint
# violet glow (radius 3, permanent), so that the picture says what the description promises, "glows faintly and permanently, a landmark at night". Close (zoom 4)
# on (139, 74): Nelim sits on the east cell (141, 74) right of centre, the darkness to the west, the lit disc (ball, pots, Nelim) about half the frame, the unlit
# torches placed then put out (first take had none in frame, and a chicken walked in: animals removed again after the wait) so that "the torches have died" reads. Same hut, same set as pictures 1 and 2 (feature 05). Nelim, in the robe of the
# other pictures but as a mage for the night: a violet cape (no hood: her `Flowy` hair shows, lit violet by the ball; no staff, the sitting job drops it, run b029),
# her canon eyes (no eye colour step), the calm kit with sleepy lids (a mystic look, owner's suggestion 2026-10-08), the expression set to normal just before the shot.
# THE INSTANT: she came back to the ball after the torches died and has been gazing for 600 ticks of the joy job, paused there. The hour is set to 23 once; the room
# is roofed, so the daylight is out of it and the glow is the one thing that reads. The story: the seer's torches have died, and she stays with the ball in the dark.
#
# Same rules as 05: only a pass of `-DepMap wsl-deps.sanctuary.map` plays it; a person opens the picture, a passing scenario says only that the route ran.
@requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.colonistrace
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
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Flowy"
    And I dress "Nelim" in "Apparel_Robe" made of "Leather_Plain"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Cape" dyed rgb (98, 52, 150)
    And Nelim's Pickle Tools: "Nelim" face kit is "calm"
    And Nelim's Pickle Tools: "Nelim" lids are "LidSleepy"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (137, 71)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (144, 70)
    And Nelim's Pickle Tools: I place the decor "TorchLamp" at (143, 76)
    And Nelim's Pickle Tools: I place the decor "Plant_Rose" at (140, 75)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (140, 73)
    And Nelim's Pickle Tools: I place the decor "Shelf" at (136, 73)
    And Nelim's Pickle Tools: I place the decor "Bookcase" at (138, 77)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (136, 70)
    And Nelim's Pickle Tools: I place the decor "SculptureSmall" at (144, 77)

  # 3. The glow, at 23:00.
  @timeout:360
  Scenario: the ball glowing in the dark, close up
    Given I set the hour to 23
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the building "TorchLamp" at (137, 71) is put out
    And Nelim's Pickle Tools: the building "TorchLamp" at (144, 70) is put out
    And Nelim's Pickle Tools: the building "TorchLamp" at (143, 76) is put out
    And game speed is ultrafast
    And Crystal Ball: a crystal ball "Fourth" stands at (140, 74)
    And I wait 60 ticks
    And Nelim's Sanctuary: the animals are removed from the sanctuary "hut"
    And Nelim's Pickle Tools: "Nelim" stands at (143, 74) facing West
    And "Nelim" needs "Joy" is set to 10 percent
    When Crystal Ball: the joy giver sends "Nelim" to the ball "Fourth" to sit on its east side
    Then Crystal Ball: "Nelim" sits beside the ball "Fourth"
    When Nelim's Pickle Tools: the game is advanced by 600 ticks
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I frame the cell (139, 74) at zoom 4
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And I wait 30 ticks
    Then I take a screenshot "workshop 3 - the ball glowing in the dark"
