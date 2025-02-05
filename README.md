# Simple Fractal in β-assembly

![fractal_example](https://github.com/user-attachments/assets/3ca4a312-574a-433b-bb0b-199f7ea9c6a1) *The fractal with a recursion depth of 3*

## Description

This project implements algorithms to draw a fractal pattern using the β-simulator's graphical interface. The fractal is composed of interleaved squares and circles, where each iteration fits perfectly within the previously drawn shape. The implementation uses only integer arithmetic and follows the Bresenham's circle algorithm for precise circle drawing.

## Key Features

- Square drawing algorithm with outline rendering
- Circle implementation using Bresenham's algorithm
- Recursive fractal generation
- Integer-only arithmetic for compatibility with β-assembly
- Memory-mapped video display (1024 first words)

## Implementation Details

The project consists of three main components:

1. **Square Drawing** (`square.asm`)
   - Draws square outlines from top-left corner coordinates
   - Takes x, y coordinates and side length as parameters

2. **Circle Drawing** (`circle_bresenham.asm`)
   - Implements Bresenham's circle algorithm
   - Uses octant symmetry for efficient drawing
   - Returns last pixel coordinates for square fitting

3. **Fractal Generation** (`fractal.asm`)
   - Recursive implementation
   - Interleaves squares and circles
   - Handles proper shape fitting and scaling

## Technical Requirements

- β-simulator (βSim) 
- Canvas size: 256x125 pixels
- Memory view access for visualization
- Support for 32-bit word operations

## Usage

* Load the program in β-simulator
* Adjust maxDepth variable in main.asm for different recursion levels
* Run the simulation to see the fractal being drawn


## Course Information

This project was completed as part of the Computation Structures course at ULiège (Fall 2024).

## Grade

Final grade: **20/20**

## Author

- [Mehdi Boustani](https://github.com/MehdiBoustani)
