# 🍄 Super Mario Bros: x86 Assembly Edition 🍄
## 🎮 A Comprehensive Recreation in x86 Assembly
### 👨‍💻 Developed by: Muhammad Idrees | Roll No: 23I-0582

![Language](https://img.shields.io/badge/Language-x86_Assembly-blue.svg)
![Assembler](https://img.shields.io/badge/Assembler-MASM-red.svg)
![Library](https://img.shields.io/badge/Library-Irvine32-orange.svg)
![Architecture](https://img.shields.io/badge/Architecture-Intel_80x86-lightgrey.svg)
![Status](https://img.shields.io/badge/Status-Completed-success.svg)

---

## 📜 Table of Contents
1. [Introduction](#introduction)
2. [Project Philosophy](#project-philosophy)
3. [Core Gameplay Features](#core-gameplay-features)
4. [The Legend of Speed Racer Mario](#the-legend-of-speed-racer-mario)
5. [Difficulty Systems](#difficulty-systems)
6. [World & Level Design](#world--level-design)
    - [World 1-1: Grassland Adventure](#world-1-1-grassland-adventure)
    - [World 1-2: Underground Challenge](#world-1-2-underground-challenge)
    - [World 1-3: Sky High Platforms](#world-1-3-sky-high-platforms)
    - [World 1-4: Bowser's Castle Fortress](#world-1-4-bowsers-castle-fortress)
7. [The Power-up Compendium](#the-power-up-compendium)
8. [Bestiary (Enemy AI)](#bestiary-enemy-ai)
9. [Technical Architecture](#technical-architecture)
    - [The Main Game Loop](#the-main-game-loop)
    - [Physics Engine & Kinematics](#physics-engine--kinematics)
    - [Collision Detection Algorithms](#collision-detection-algorithms)
    - [Rendering Pipeline](#rendering-pipeline)
    - [Audio Integration](#audio-integration)
    - [File I/O & Persistence](#file-io--persistence)
10. [Advanced Creative Features](#advanced-creative-features)
11. [Source Code Breakdown](#source-code-breakdown)
12. [Installation & Build Guide](#installation--build-guide)
13. [Controls Reference](#controls-reference)
14. [Developer Log & Learning Outcomes](#developer-log--learning-outcomes)
15. [Troubleshooting & FAQ](#troubleshooting--faq)
16. [Future Enhancements](#future-enhancements)
17. [License & Acknowledgments](#license--acknowledgments)

---

## 📖 Introduction
Welcome to the most ambitious recreation of **Super Mario Bros** ever developed for the x86 Assembly platform. This project showcases low-level programming techniques, real-time game physics, and console-based graphics.

Unlike modern high-level languages where physics and rendering are handled by engines like Unity or Unreal, every single pixel (character), every gravitational pull, and every collision in this game was manually calculated and implemented using **Intel x86 Assembly**.

---

## 🧠 Project Philosophy
The primary goal of this project was to explore the limits of the **Irvine32 library** and the **Windows Console API**. The development focused on:
1.  **Instruction Efficiency**: Utilizing the most efficient opcodes for real-time performance.
2.  **Memory Management**: Direct manipulation of the `.data` and `.code` segments to handle complex game states.
3.  **User Experience**: Bridging the gap between the rigid console environment and the fluid movement of a side-scrolling platformer.

---

## 🎮 Core Gameplay Features
- **Dynamic Physics**: Implementation of real-time gravity, velocity, and inertia.
- **Save/Load System**: Persistence of high scores and level progress using binary file handling.
- **Multi-Level Adventure**: Four distinct worlds with increasing complexity.
- **Interactive Environment**: Destructible bricks, hidden blocks, and interactive pipes.
- **Score Multipliers**: Combo systems for consecutive enemy defeats.
- **Bullet Time**: A custom creative feature allowing players to slow down time for precise platforming.

---

## ⚡ The Legend of Speed Racer Mario
A unique feature of this implementation (linked to the developer's Roll Number `23I-0582`) is the **Speed Racer Mario** class. 
- **Base Speed Boost**: Mario moves 25% faster than standard implementations.
- **Turbo Star**: A specialized power-up that doubles movement speed for 8 seconds.
- **Dynamic HUD**: The timer and HUD elements change color (Blue) when the speed boost is active, providing visual feedback of the "Speed State".

---

## 📈 Difficulty Systems
The game features three tailored difficulty modes that adjust the internal constants of the game engine:

### 🟢 Easy Mode
- **Lives**: 5
- **Enemy Speed**: 0.5x
- **Spawn Rate**: Reduced
- **Power-ups**: High frequency in question blocks.

### 🟡 Medium Mode
- **Lives**: 3
- **Enemy Speed**: 1.0x (Standard)
- **Spawn Rate**: Authentic World 1-1 layout.
- **Power-ups**: Standard distribution.

### 🔴 Hard Mode
- **Lives**: 1
- **Enemy Speed**: 1.5x
- **Spawn Rate**: Aggressive (additional Goombas and Koopas).
- **Power-ups**: Only 10% chance in blocks.

---

## 🌍 World & Level Design

### 🌿 World 1-1: Grassland Adventure
The introductory level designed to teach the player the basic mechanics.
- **Focus**: Basic jumping and enemy stomping.
- **Elements**: 3 Pipes, 5 Goombas, and the iconic flagpole finish.
- **Secret**: A hidden 1-UP mushroom located near the second pipe.

### 🧱 World 1-2: Underground Challenge
A claustrophobic level with ceiling-based mechanics.
- **Focus**: Precision jumping and Piranha Plant avoidance.
- **Elements**: Moving platforms and horizontal elevators.
- **Aesthetics**: Dark blue/gray color palette using `SetTextColor`.

### ☁️ World 1-3: Sky High Platforms
A test of verticality and timing.
- **Focus**: Falling mechanics and "Leap of Faith" jumps.
- **Elements**: Floating bridge segments and flying Koopas.
- **Physics**: Increased wind resistance (simulated via horizontal deceleration).

### 🏰 World 1-4: Bowser's Castle Fortress
The ultimate challenge.
- **Focus**: Boss battle and hazard avoidance.
- **Elements**: Lava pits, fire bars (rotating ASCII symbols), and Bowser.
- **Boss**: Bowser breathes fireballs that the player must jump over to reach the bridge axe.

---

## 🍄 The Power-up Compendium
Power-ups are implemented via a state-machine that modifies Mario's sprite and capabilities.

| Power-up | Visual | Effect |
| :--- | :--- | :--- |
| **Mushroom** | `M+` | Mario becomes "Super Mario" (3 chars tall). Can break bricks. |
| **Fire Flower** | `F` | Allows shooting fireballs using the `F` key. |
| **Star** | `*` | Invincibility. Mario flickers colors. One-hit kills enemies. |
| **1-UP** | `1+` | Grants an additional life. |
| **Turbo Star** | `S` | Special Speed Racer boost. Double speed. |

---

## 👾 Bestiary (Enemy AI)
Each enemy has a unique logic loop within the `.code` segment:

- **Goomba (`@@`)**: 
  - *Logic*: Moves in a straight line until it hits a wall or pipe, then reverses.
  - *Interaction*: Jump on top to kill (100 pts). Touch the side to take damage.
- **Koopa (`{}`)**:
  - *Logic*: Moves slightly faster than Goombas.
  - *Interaction*: Jump once to turn into a shell (`()`). Jump again or walk into the shell to kick it.
- **Piranha Plant (`}|{`)**:
  - *Logic*: Emerges from pipes on a timer.
  - *Interaction*: Cannot be killed by jumping. Must be avoided or hit with fireballs.
- **Bowser (`/M\`)**:
  - *Logic*: Stationary boss that moves vertically. Shoots fireballs at random intervals.

---

## 🏗️ Technical Architecture

### 🔄 The Main Game Loop
The heart of the game is a high-performance loop that handles input, physics, and rendering sequentially to maintain a steady frame rate.

```assembly
GameLoop:
    call UpdateTimer        ; Decrement game time
    call CheckInput         ; Poll keyboard state (GetKeyState)
    call ApplyPhysics       ; Gravity, Velocity, Momentum
    call HandleCollisions   ; Check for walls, enemies, items
    call UpdateEnemies      ; Move Goombas/Koopas
    call RenderFrame        ; Draw everything to the console
    
    mov eax, FRAME_DELAY    ; Sleep to maintain FPS
    call Delay
    
    cmp gameRunning, 1      ; Check for exit condition
    je GameLoop
```

### 🍎 Physics Engine & Kinematics
The physics engine uses signed bytes (`SBYTE`) to handle vertical velocity (`velY`). 

**Gravity Equation Implementation:**
`New_Velocity = Current_Velocity + GRAVITY_CONSTANT`
`New_Position = Current_Position + New_Velocity`

**Jumping Logic:**
When the jump key is pressed, `velY` is set to a negative value (e.g., `-8`). Each frame, the `GRAVITY` constant (e.g., `1`) is added to `velY`, eventually making it positive, which causes Mario to fall.

### 💥 Collision Detection Algorithms
Collisions are handled using Axis-Aligned Bounding Box (AABB) logic, adapted for character coordinates.

1.  **Vertical Collision**: Checks if Mario's `Y + height` matches a ground or block coordinate.
2.  **Horizontal Collision**: Checks if Mario's `X + width` intersects with a pipe or wall.
3.  **Enemy Collision**: A more granular check. If `Mario.Y < Enemy.Y` and they intersect, it's a stomp. Otherwise, Mario takes damage.

### 🖼️ Rendering Pipeline
To prevent flickering in the Windows Console, the game uses a manual "Double Buffering" approach. Instead of clearing the whole screen every frame (which causes high latency), the game only redraws modified areas or uses the `COORD` system to overwrite specific characters.

- **Background Rendering**: The `groundLine` and `skyChar` are drawn first.
- **Sprite Rendering**: Mario and enemies are drawn over the background using `Gotoxy`.
- **HUD Rendering**: The top bar is updated only when values (Score, Time) change.

### 🔊 Audio Integration
Sound is handled through the Windows Multimedia API (`winmm.dll`).

```assembly
; Example: Playing a jump sound
INVOKE PlaySoundA, ADDR sndJump, NULL, SND_ASYNC OR SND_FILENAME
```

### 💾 File I/O & Persistence
The game saves state into binary `.dat` files using standard Windows file handles.
- `highscore.dat`: Stores the top 5 scores and names.
- `progress.dat`: Saves the current level, lives, and score for the "Continue" feature.

---

## 🧪 Advanced Creative Features

### 🕒 Bullet Time (Slow Motion)
By holding a specific key, the player drains a "Power Meter" to slow down the game's `FRAME_DELAY`. This is implemented by dynamically increasing the `Sleep` duration in the main loop while the feature is active.

### 🌈 Visual Effects
- **Screen Shake**: When Bowser lands or Mario dies, the console window position is briefly jittered using the `SetConsoleWindowInfo` API.
- **Color Cycling**: Fire Mario and Invincible Mario use a color-cycling algorithm that changes their `SetTextColor` every few frames.

---

## 📂 Source Code Breakdown
The `Source.asm` file is organized into 10 primary sections:

1.  **Directives & Includes**: Irvine32 and Windows API protocols.
2.  **Data Segment - UI Assets**: ASCII art for titles, clouds, and pipes.
3.  **Data Segment - Game State**: Variables for positions, velocities, and flags.
4.  **Main Procedure**: Entry point and high-level menu navigation.
5.  **Graphics Procedures**: `DrawMario`, `DrawEnemies`, `DrawWorld`.
6.  **Physics Procedures**: `ApplyGravity`, `HandleJumping`, `MovePlayer`.
7.  **Collision Procedures**: `CheckGround`, `CheckBlockHits`, `CheckEnemyCollision`.
8.  **Enemy Logic**: Independent loops for Goomba and Koopa movement.
9.  **File Handling**: `SaveGame`, `LoadGame`, `UpdateHighScores`.
10. **Screen Procedures**: `IntroScreen`, `MainMenu`, `GameOverScreen`, `VictoryScreen`.

---

## 🛠️ Installation & Build Guide

### 1. Environment Setup
- Install **Visual Studio** (2019 or later).
- Download the **Irvine32 Library** from [Kip Irvine's website](http://kipirvine.com/asm/).
- Configure your Visual Studio project:
    - **Include Path**: Add `C:\Irvine`.
    - **Library Path**: Add `C:\Irvine`.
    - **Linker Dependencies**: Add `Irvine32.lib`, `User32.lib`, `Kernel32.lib`, `winmm.lib`.

### 2. Assembly Instructions
1.  Open the `.sln` file.
2.  Ensure `Source.asm` is part of the project.
3.  Set the solution platform to `x86`.
4.  Press `Ctrl + Shift + B` to build.

### 3. Running the Game
Navigate to the `Debug` folder and run `COAL_Project_2025.exe`. Ensure all `.wav` files and `.dat` files are in the same directory as the executable.

---

## 🎮 Controls Reference
| Key | Action | Technical Note |
| :--- | :--- | :--- |
| `W` / `Space` | **Jump** | Sets `velY = -8` |
| `A` / `Left` | **Move Left** | Decrements `velX` |
| `D` / `Right` | **Move Right** | Increments `velX` |
| `Shift` (Hold) | **Run** | Multiplies `velX` by 2 |
| `F` | **Fireball** | Spawns fireball object if `marioState == 2` |
| `ESC` | **Pause** | Breaks the main loop into a sub-menu loop |
| `Q` | **Quit** | Sets `gameRunning = 0` |

---

## 📝 Developer Log & Learning Outcomes
### Development Timeline
- **Week 1**: Basic physics and Mario movement (The "Cube" phase).
- **Week 2**: ASCII art integration and world rendering.
- **Week 3**: Enemy AI and collision detection (The "Buggy" phase).
- **Week 4**: Sound, File I/O, and Level 4 Boss Battle.
- **Week 5**: Optimization, polish, and documentation.

### Key Learnings
- **The Power of Indirect Addressing**: Using `ESI` and `EDI` to parse level arrays.
- **Flag Management**: Understanding how the `EFLAGS` register dictates game logic (e.g., `jz`, `jnz` for collision checks).
- **Stack Operations**: Managing local variables and return addresses in complex procedure calls.

---

## ❓ Troubleshooting & FAQ

**Q: The game is flickering heavily.**
*A: Ensure your console window is not being resized during play. The rendering uses fixed coordinates.*

**Q: Sound isn't playing.**
*A: Make sure the `.wav` files are in the same folder as the `.exe`. The program uses relative paths.*

**Q: Mario falls through the floor.**
*A: This usually happens if the `GROUND_LEVEL` constant is mismatched with the rendering Y-coordinate. Check Section 7 of the code.*

---

## 🚀 Future Enhancements
- **Side-Scrolling**: Transition from fixed-screen levels to a camera-based scrolling system.
- **Multiplayer**: Support for Luigi via a second set of keys (e.g., IJKLO).
- **Level Editor**: A Python-based tool to generate `.asm` data segments for new levels.
- **Advanced Sprite Animation**: Using 4-frame cycles for walking and jumping animations.

---

## 📜 License & Acknowledgments
- **Project Lead**: Muhammad Idrees
- **Academic Supervision**: Department of Computer Science (COAL Course)
- **Special Thanks**: Kip Irvine for the invaluable assembly library.
- **Disclaimer**: This is a non-commercial educational project. Super Mario Bros assets are owned by Nintendo.

---

> *"The assembly code is like the DNA of the game—complex, rigid, but capable of creating life."*

---

### 📋 Full Variable Appendix (Technical Reference)
*(For developers looking to extend the source code)*

| Variable | Type | Description |
| :--- | :--- | :--- |
| `marioX` | `BYTE` | Current horizontal coordinate (0-100) |
| `marioY` | `BYTE` | Current vertical coordinate (0-50) |
| `velY` | `SBYTE` | Signed vertical velocity for jump/gravity |
| `gameTime` | `WORD` | Countdown timer (seconds) |
| `playerScore`| `DWORD` | 32-bit score accumulator |
| `marioState` | `BYTE` | 0:Small, 1:Super, 2:Fire |
| `isJumping` | `BYTE` | Boolean flag to prevent mid-air multi-jumps |

---
**[END OF DOCUMENTATION]**
**Version 1.0.0 | May 2025**
