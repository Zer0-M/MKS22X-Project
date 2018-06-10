# MKS22X-Project
## Description
We plan to create a clone of the Light Cycle sub-game from the TRON arcade game. In the original game there were multiple light cycles in an arena, these cycles left a trail that acted as a wall for all of the cycles in the arena. The players goal was to make the enemy light cycles(other player or computer) crash into the wall. We will include additional obstacles like a walls that pop-up in random locations.

## Features
There is a 1 player mode where one can play againt a computer driven cycle

There's two player mode where each person control a cycle

A player has three lives in each game

There are obstacles to make the game more difficult

Players have the ability to use a speed boost.

## Features added since Demo
Walls that pop up in random locations on the map

Speed boost

Sprites

## Instructions
The game is run via processing and requires the importation of the sound library

## Troubles
The "Draw" detection is a bit off because of the timing and how the game actually updates. 
It checks the spaces ahead and sometimes one cycle checks before the other checks. 

For obstacles, you need to hit it directly head on for it to "kill" you. This is due to
how the cycles checks what is ahead of it. Since the arena is 750 by 550 and the cycles are 
20 by 10. The cycle checks for things ahead of it from one point. 
