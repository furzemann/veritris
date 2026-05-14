# Veritris

A Tetris simulator written in Verilog that runs on an FPGA and displays output through VGA.

Veritris is a project focused on implementing rendering pipelines, game logic finite state machines (FSMs), collision systems, and gameplay mechanics directly in hardware description language (HDL). The goal is to leverage the parallel nature of FPGA hardware for efficient game execution.

---

## Project Goals

* Implement a playable Tetris engine entirely in Verilog
* Drive graphical output through a VGA interface
* Explore hardware-oriented rendering techniques
* Use FPGA parallelism for game state updates and collision checks
* Build modular and reusable HDL components

---

## Architecture Overview

The design is split into separate modules:

### Video Pipeline

* VGA timing generation
* Pixel coordinate generation
* Rendering logic
* RGB output generation

### Game Logic

* Piece spawning
* Gravity and movement
* Collision detection
* Piece locking
* Rotation handling
* Line clear checks

### Utility Systems

* Pseudorandom generation
* Clock division and timing modules
* Input handling

---

## Current Progress

### Implemented

* Standardized pseudorandom piece generation
* VGA protocol implementation
* VGA timing and synchronization logic
* Falling piece logic
* Piece movement and rotation framework
* Collision system foundation
* Hardware rendering pipeline structure

---

## What Comes Next

### Planned Features

* Tetris-style 7-bag random generation system
* Next piece preview window
* Line clearing logic improvements
* Game over handling
* Piece hold system
* Score tracking
* Improved rendering and visuals

---

## Design Philosophy

Veritris keeps rendering and game state independent:

* Game logic updates state
* VGA logic produces screen coordinates
* Renderer converts game state into pixels

This separation mirrors real architectures that use separate units for tasks and makes the project easier to scale and maintain.

---

## Long-Term Ideas

* HDMI output
* Colorized tetrominoes
* Soft-core CPU integration
* Additional FPGA game projects built on the same renderer
