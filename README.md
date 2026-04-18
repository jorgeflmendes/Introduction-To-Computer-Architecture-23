# Beyond Mars

Assembly game project for the **Introduction to Computer Architecture** course.

This repository contains the game source code, circuit definition, simulator, and media assets required to run the project locally.

## Overview

**Beyond Mars** is a real-time arcade-style game implemented in assembly for the course simulator environment.  
The player controls a ship, launches probes, avoids asteroid collisions, manages energy, and reacts to timed game events such as animated ship lights, asteroid spawning, and game-over states.

## Repository Layout

```text
.
|-- beyond-mars.asm        # Main assembly source file
|-- beyond-mars.cir        # Circuit and Media Center configuration
|-- sepe-simulator-1.5-2023.jar # Simulator used to run the project
`-- media/                 # Images, audio, and video assets used by the game
```

## Requirements

- Java runtime capable of launching `sepe-simulator-1.5-2023.jar`
- The provided simulator version

## Running the Project

1. Open the simulator:

   ```powershell
   java -jar sepe-simulator-1.5-2023.jar
   ```

2. Load the circuit file:

   - `beyond-mars.cir`

3. Confirm that the circuit points to:

   - `beyond-mars.asm`

4. Start the simulation from the simulator UI.

## Controls

The game uses the hexadecimal keypad expected by the simulator:

- `C` - Start game
- `F` - Pause / resume
- `E` - End game
- `0` - Launch left probe
- `1` - Launch center probe
- `2` - Launch right probe

## Features

- Real-time keyboard input scanning
- Concurrent game processes driven by interrupts
- Energy management and display updates
- Animated ship light patterns
- Multiple asteroid trajectories and types
- Probe launching and collision handling
- Integrated Media Center backgrounds, audio, and video events

## Media Assets

Media files are named using a consistent convention:

- `background-*` for backgrounds
- `overlay-*` for overlays
- `audio-*` for sound assets
- `video-*` for video assets

All media paths are configured in `beyond-mars.cir`.

## Notes

- The project is designed for the provided simulator and circuit environment.
