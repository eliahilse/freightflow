# Introduction

Development of a constructivist learning game for teaching basic programming skills using a visual abstraction of control flow.

Team members:

- Freydank, Julius
- Hilse, Elia
- Kramp, Edwin
- Lochner, Jonas
- Sander, Lucas
- Schmidt, Jonathan
- Schneider, Jan Erik

Instructors:

- Kazimiers, Antje
- Rudolph, Michael

---

# Game Overview

## Game Concept

Title: **Freight Flow**

Story:

- A delivery order to supply various ports by ship
  - Goal: Improve logistics

Technology:

- Engine: Godot
- Operating System: Windows, (Multi-Platform via Web)
- Input Method: Multitouch

Gameplay:

- The level's objective is presented by a reference person
- Players place objects (ports, barriers, etc.)
  - Ports → Variable assignments & arithmetic operations
  - Barriers ++ branching → Condition
- Players shape the course of the river using river segments
  - Circular segment → Loop
  - Barrier + branching → Condition
- A ship sails along the river, thus playfully visualizing the flow of the program. For example, two containers are loaded at ports when the variable is summed with 2, etc. The ship has a trailer per variable
  - Trailers and ports are color-coded → Easy to understand operations due to their affiliation

→ Cooperative → Multiple players can work on the same problem simultaneously thanks to multitouch

- Flow:
  1. (Number of players is entered)
  2. Level is selected → Level 0 = Tutorial is displayed
  3. Level starts → see Gameplay
  4. next level is unlocked
- Progression:

  → Multiple levels, programming concepts build on each other (from one variable to several, without control flow to loops and branches (possibly from Integer to Float))
- Similar to:
  - Cosmic Express
  - Scratch

## Genre

- Puzzle game with a focus on using logic to solve basic algorithmic problems in the realm of programming skills
- Underlying theory: Constructivism

Optics:

- Top-Down "slanted" → 2D hybrid
- No realism → stylized
- Simple

---

# Analysis according to Addie

## Target Group:

- 6th-7th grade approx. (→ ~ from 12 years)
- Gender distribution irrelevant
- No prior knowledge

## Framework Conditions

- Framework Conditions:
- The teacher should have some basic knowledge to be able to help in case of emergency
- Appropriately capable hardware to ensure smooth use
- The teacher should accordingly plan time in the classroom

## Learning Object

- Development of logical skills in relation to problem-solving competencies in the area of programming skills
- Conceptual:
  - Students should develop an understanding of the use of branches and loops and the use of simple mathematical operations to solve problems.
- Procedural
  - Understanding of the cooperation of control flow elements and the resulting overall algorithm

## Prior Knowledge

- Operation of touch displays
- Auditory, visual, and motor skills at a level appropriate for the age
- (Good) Logical understanding at the level of 6th grade

## Resources

- A multitouch capable device with a sufficiently large display
- First-time application takes three-quarters of an hour → after introduction, levels can be solved much faster depending on skill

## Derivation of Broad Objectives

Students are capable after completing all levels to understand and work out basic algorithmic problems in an abstracted visual programming environment using the tools available to them. They master the application of branches, loops, and variables. The process to be learned is worked out in each level in the form of a puzzle, thus ensuring that the visualization of the concept facilitates the transmission of the idea.

---

# Conceptualization and Educational Design

### Learning Environment

- For the prototypical implementation of the learning game, the learning environment is set to Godot.

### Derivation of Detailed Objectives

- Students can understand the visual programming environment and build their own program flows
- Students can understand loops and apply them to solve problems
- Students can understand branches and apply them to solve problems
- Students can understand variables and apply them to solve problems

### Segmentation and Weighting

- Educational strategy:
  - Repetition: by repeating frequently, the learner will be able to remember the content better over time
  - Increasing difficulty: through levels that become more difficult as the game progresses, the mentioned repetition will not become too monotonous and furthermore, the learner will continue to be challenged, although the basic concept remains the same

### Search for (existing material)

Other games that pursue similar goals are Scratch and CodeCombat.

### Game Flow

- Game:
  - Movement in the game is very linear (level to level)
  - Controlled by touch
  - Placing building blocks from the menu onto the game area

### Look and Feel

![image (4).png](./attachments/image%20(4).png)

### Integration of Educational Scenario

- The game can be used in computer science classes
- Can be used there directly as a playful introduction to teaching for younger students to convey basic techniques
- Evaluation of learning success by progressing in the game or a short knowledge quiz in class

---

# Gameplay and Mechanics

### Gameplay

- Map is interactively shaped by user inputs
- Actions:
  - Placing of building blocks (ports, loops, conditions, river sections)
  - Interaction of different building blocks through ports where variables are changed
  - Balance:
    - 4 elementary actions
    - Actions are prerequisites for a functioning map
    - A main object with a manageable number of sub-objects
    - The object is closely related to elementary actions

### Game Mechanics

Game space:

- A river with branches where a boat moves, carrying different numbers of containers and taking various paths based on these to reach the destination

Time:

- Turn-based gameplay (first place blocks, then the boat travels the built route)
- No active time limit (assistance after repeated failure)
- Learners actively determine the duration of the game, a possible restriction would be class time
- The game does not force learners to finish the game in one sitting
- Levels build on each other with increasing difficulty and thus likely increasing solution duration for individual levels
- A time limit would make gameplay more exciting but would significantly reduce the learning effect and increase the stress level -> not a sensible function
- Time-independent game rounds (levels) that are independent of each other

Objects, Attributes, and Status Information:

- Objects in the game are the ship and the ports<br><br>
- Ship attributes:
  - Position on the river
  - Number of containers and trailers 

<div style="text-align: center;">
  <img src="./attachments/State Machine Schiff.png" alt="State Machine Ship">
</div>

- Port attributes:
  - Number of different available containers
  - Position in the river course
<div style="text-align: center">
  <img src="./attachments/State Machine Hafen.png" alt="State Machine Port">
</div>

- Status of position is the position (coordinate)
- Status of number is a number, which is in the range of positive natural numbers
- All information is accessible to all players

Core Mechanics:

- Players solve a given problem, depending on the level of freedom:
  - Configure operations at ports
  - Set conditions at barriers
  - Determine the course of the river via river sections / loops
  - Place ports
  - Place barriers

-> Problem can be, for example, reaching a goal, or correctly fulfilling the delivery requirements at several ports

Rules:

- Players only use the resources or options provided in the respective level (depending on the level of freedom, this can be, for example, configuring different operations at the provided ports, or placing ports/barriers themselves, etc.)
<div style="text-align: center; background-color: white;">
  <img src="./attachments/Ablaufdiagramm.drawio.png" alt="State Machine Port">
</div>

Game Goal:

- The ship should successfully reach the end of the level, any associated conditions, and possible objectives
- The goal and the path leading there are clearly and distinctly recognizable

### Game Options

- Place building blocks in various ways to successfully reach the goal
- Map can be independently designed to a small extent according to personal preference

### Restrictions

- The learner should reach the goal through logical thinking in the simplest and fastest way
- Sequential thinking is promoted and sequence in a fixed order
- Learners should avoid overly complex, non-targeted thinking

---

# Story, Setting, and Characters

### Story and Narrative

- No story, as it would be neither necessary nor conducive

### Game World

- The player is on a canal in the countryside with their ship.
- There are ports on this canal where cargo is loaded.
- The environment is rather quiet.
- The atmosphere of the game is calm, relaxed, and down-to-earth, which is promoted by the absence of a time limit.

### Characters/Educational Agents

- Captain, who explains the basic principles of the game step by step in text boxes
- The text boxes mostly contain information on how the game is played and what functionalities exist

---

# Level Design

### Practice Levels

- The game begins with tutorial levels in which the individual functions are shown and explained one by one
- The functions are the functionality of the ports, how branching works, and how loops are skillfully applied.

### Evaluation/Scoring/Reward

- The knowledge acquired in the tutorials should be used in increasingly difficult levels.

---

# Interface

### Design

![Draft Interface](./attachments/Interface.jpeg)


- Game Board:
  - The player should place river sections on which the ship moves.
  - The ship is loaded with goods at the ports, which it needs to reach the destination

### Physical System

- River sections, ports, and other elements can be placed by the learner via touch interactions on the map
- The interactions directly

 define the course of the game
- A sensibly usable additional output device besides the screen would be a sound output source, which gives the player sound feedback

### Visual System

- The player sees a menu from which tiles are chosen and placed
- The game is played from a top-down perspective in the style of a 2D-3D hybrid (see Look and Feel)

### Control System

- Very intuitive gameplay through Touch DragAndDrop
- Players get a great sense of influence over the game, as the concept of the game is based on interaction and design of the map
- The player has the opportunity to design and change the map to their liking

### Transparency

- The interface is very easy to understand and very clear, giving players an easy entry into the game
- The interface is very intuitive, as the functions used are also commonly used in everyday life with, for example, smartphones
- Since there is no time limit, learners can build levels at their own pace, thus no stressful situations arise
- If a player forgets what a tile does, tapping on a question mark next to it can bring up a text box again explaining the specific function

### Feedback

- Players only need to know the game's goal and the functionality of the tiles, which can be explained again and again
- The objective of the levels is defined by the marked goal, and learners receive visual as well as audio feedback on failed attempts

### Audio, Music, Sound Effects

- The game should contain background music, a win/fail sound, and optionally sounds that are audible at places like ports

### Help Systems

- As help systems, the tutorials as well as the question marks next to the tiles in the tile box are planned, which explain the functions of the individual tiles again
