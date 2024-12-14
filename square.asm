|; drawSquare(xTopLeft, yTopLeft, sideLength)
|; Draw a square on the canvas.
|; @param xTopLeft    the x-coordinate of the top-left corner of the square.
|; @param yTopLeft    the y-coordinate of the top-left corner of the square.
|; @param sideLength  the length of the side of the square (in number of pixels).
drawSquare:

    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    |; Save registers
    PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5) PUSH(R6)

    |; Arguments
    LD(BP, -12, R1) |; R1 <- xTopLeft 
    
    LD(BP, -16, R2) |; R2 <- yTopLeft 
    
    LD(BP, -20, R3) |; R3 <- sideLength

    |; Local variables for bottom-right corner
    SUBC(R3, 1, R3) |; R3 <- sideLength - 1
    
    ADD(R1, R3, R4) |; xBottomRight (R4) <- xTopLeft (R1) + sideLength - 1 (R3)
    
    ADD(R2, R3, R5) |; yBottomRight (R5) <- yTopLeft (R2) + sideLength - 1 (R3)

    MOVE(R2, R3) |; yCur (R3) <- yTopLeft (R2)

|; Loop through each row of the square
square_loop1:

    |; yCur (R3) <= yBottomRight (R5)
    CMPLE(R3, R5, R0)
    BF(R0, drawSquare_end)

    |; xCur (R6) <- xTopLeft (R1)
    MOVE(R1, R6) 

|; Loop through each column of the square
square_loop2:

    |; xCur (R6) <= xBottomRight (R4)
    CMPLE(R6, R4, R0)
    BF(R0, square_loop2_end)

    |; Comparaisons one after the other to avoid using a register in an OR
    |; xCur (R6) == xTopLeft (R1)
    CMPEQ(R6, R1, R0)
    BT(R0, square_canvas)

    |; xCur (R6) == xBottomRight (R4)
    CMPEQ(R6, R4, R0) |; 
    BT(R0, square_canvas) 

    |; yCur (R3) == yTopLeft (R2)
    CMPEQ(R3, R2, R0)
    BT(R0, square_canvas)

    |; yCur (R3) == yBottomRight (R5)
    CMPEQ(R3, R5, R0)
    BT(R0, square_canvas) 

    ADDC(R6, 1, R6)  |; xCur++
    BR(square_loop2) |; Continue inner loop

|; Set pixel to 1 on the canvas if on border
square_canvas:

    |; Last-argument-pushed-first (LAPF) convention
    PUSH(R3) |; yCur
    PUSH(R6) |; xCur
    CALL(canvas_set_to_1)
    
    |; Incrementing xCur and branching to the current inner loop
    ADDC(R6, 1, R6)     |; xCur++
    BR(square_loop2) |; Continue inner loop

|; End of inner loop
square_loop2_end:

    |; Incrementing yCur and branching to the current outer loop
    ADDC(R3, 1, R3)  |; yCur++
    BR(square_loop1) |; Continue outer loop

|; End of function
drawSquare_end:

    |; Cleaning the stack
    POP(R6) POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)
    POP(BP) POP(LP)
    RTN()