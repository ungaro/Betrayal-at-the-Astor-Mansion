# Betrayal at the Astor Mansion


![Poster for the game](./_assets/astor_mansion.png)
### [EXAMPLE GAMEPLAY](http://ec2-3-138-91-192.us-east-2.compute.amazonaws.com:3000/)

The Astor Mansion was a historic mansion in New York City, known for its opulence and intriguing history. It provides a sense of grandeur and mystery while not immediately revealing its New York connection.

Now, let's delve into the gameplay aspect. Betrayal at House on the Hill is known for its exploration and the eventual betrayal twist. 

## Here are some ideas for gameplay:

### Exploration: 
Players start in the lavish Astor Mansion, each with unique characters or roles. 
Each player has different levels of POWER, SANITY & SPEED

-- Players roll dice to choose their characters.
-- All characters enter Astor Mansion through a big hallway. 
-- Players roll dice to move.
-- There are 50 rooms connected to the hallway.
-- Players can choose which room to enter while they are in the hallway.
-- Each room has an event. There are 50 unique events in the mansion that affects players POWER, SANITY and SPEED.
-- Players roll dice in the room the counter the event.
-- During the game, an event will trigger a player to become traitor.
-- Players need to uncover the traitor, traitor should kill all other players to win.
-- Traiter can trigger hauntings.
-- Hauntings eventually lead to either uncovering the traitor or traitor killing everyone else.

All game state is on-chain, PlayerInfo (Power, Speed, Sanity) and traitor are private records.

### Events and Items:
There are 50 events in the game. For each of those 50 events, a set of 20 images have been created with Midjourney.

Deck of event cards are inspired by New York's history and supernatural tales. Similarly, have a deck of item cards with items related to the city's past.


| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/A_portrait_of_a_sinister_figure_hangs_on_the_wall__00001_01.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_come_across_a_garden_filled_with_ancient_statu_00006_00.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_stumble_upon_a_collection_of_cursed_artifacts__00042_02.png">|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_stumble_upon_an_old_theater_stage_An_otherworl_00047_03.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_discover_a_room_covered_in_eerie_ectoplasmic_r_00014_12.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_stumble_upon_a_room_set_up_for_a_séance_Candl_00044_00.png">|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_enter_a_room_with_a_swirling_otherworldly_vort_00032_16.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_enter_a_room_with_a_swirling_otherworldly_vort_00032_11.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/events/images/You_encounter_the_ghostly_presence_of_a_famous_pla_00026_14.png">|



[All Event Images](https://betrayal-at-astor-mansion.s3.amazonaws.com/events/index.html) 

[Events and Items Descriptions](./_docs/event_cards.md).

### Haunting Element:

There are 10 hauntings in the game. For each of those 10 hauntings, a set of 20 images have been created with Midjourney.

As players explore, certain events could trigger hauntings. These hauntings could be based on actual New York legends or myths, adding a unique twist to the game.


| | | |
|:-------------------------:|:-------------------------:|:-------------------------:|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/A_chilling_echo_reverberates_through_the_mansion_r_00000_04.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Ghostly_animals_once_pets_of_the_mansions_resident_00005_16.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Players_encounter_a_séance_in_progress_led_by_gho_00006_03.png">|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/A_chilling_echo_reverberates_through_the_mansion_r_00000_13.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Players_encounter_a_séance_in_progress_led_by_gho_00006_00.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Ectoplasmic_residue_appears_forming_cryptic_symbol_00004_02.png">|
|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/A_mirror_in_a_dimly_lit_room_reflects_a_distorted__00002_16.png">  |  <img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Suddenly_the_mansions_grand_hall_fills_with_ghostl_00008_16.png">|<img width="1604" alt="" src="https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/images/Suddenly_the_mansions_grand_hall_fills_with_ghostl_00008_14.png">|



[All Haunting Images](https://betrayal-at-astor-mansion.s3.amazonaws.com/hauntings/index.html) 

[Haunting Element Descriptions](./_docs/haunting_element.md).


### [Betrayal Mechanic:](./_docs/betrayal_mechanic.md).

As players progress, one player may eventually trigger the betrayal, turning against the others. The nature of the betrayal could be tied to the Astor Mansion's dark history or a secret motive related to New York's past.

### [Win Conditions:](./_docs/win_conditions.md).

Hauntings eventually lead to either uncovering the traitor or traitor killing everyone else.


### Hidden Information: 
Aleo's privacy features are used to keep certain game information hidden until revealed, enhancing the mystery element.

Disclaimer:
Uses some of the code from [ZK Gaming Toolkit](https://github.com/Kryha/zk-gaming-toolkit)  which Aleo has open sourced. All of these contracts have been modified & updated.


