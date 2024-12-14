|; drawFractal(xTopLeft, yTopLeft, sideLength, maxDepth)
|; Draw a fractal using squares and circles.
|; @param xTopLeft    the x-coordinate of the top-left corner of the current square.
|; @param yTopLeft    the y-coordinate of the top-left corner of the current square.
|; @param sideLength  the length of the side of the current square.
|; @param maxDepth    the maximum depth of the fractal.
drawFractal:

    |; Initialize the stack
    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    |; Save registers
    PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5) PUSH(R6) 

    |; Arguments
    LD(BP, -12, R1) |; R1 <- xTopLeft
    LD(BP, -16, R2) |; R2 <- yTopLeft
    LD(BP, -20, R3) |; R3 <- sideLength
    LD(BP, -24, R4) |; R4 <- maxDepth

    |; maxDepth (R4) == 0
    CMPEQ(R4, R31, R0)
    BT(R0, drawFractal_end)

    |; (sideLength & 1) == 0
    ANDC(R3, 1, R0)
    BT(R0, drawFractal2)

    SUBC(R3, 1, R3)

drawFractal2:

    |; drawSquare(xTopLeft, yTopLeft, sideLength) with LAPF convention
    PUSH(R3) PUSH(R2) PUSH(R1)
    CALL(drawSquare, 3)
    
    |; Calculate the parameters of the circle
    SHRC(R3, 1, R5) |; radius (R5) <- sideLength (R3) / 2 (using shift right)
    ADD(R1, R5, R0) |; xc (R0) <- xTopLeft (R1) + radius (R5)
    ADD(R2, R5, R6) |; yc (R6) <- yTopLeft (R2) + radius (R5)

    |; drawCircleBres(xc, yc, radius) with LAPF convention
    PUSH(R5) PUSH(R6) PUSH(R0)
    CALL(drawCircleBres, 3) |; lastPixelCircleX (R0) <- drawCircleBres(xc, yc, radius)

    SUB(R5, R0, R0) |; shift (R0) = radius (R5) - lastPixelCircleX (R0)

    |; shift (R0) < 1
    CMPLTC(R0, 1, R5) |;
    BT(R5, drawFractal_end)
    
    ADD(R1, R0, R1) |; xTopLeft (R1) <- xTopLeft (R1) + shift (R0)

    ADD(R2, R0, R2) |;yTopLeft (R2) <- yTopLeft (R2) + shift (R0)

    MULC(R0, 2, R0) |; shift (R0) <- shift (R0) * 2
    SUB(R3, R0, R3) |; sideLength (R3) <- sideLength (R3) - R0

    SUBC(R4, 1, R4) |; maxDepth (R4) <- maxDepth (R4) - 1

    |; drawFractal(xTopLeft + shift, yTopLeft + shift, sideLength - (2 * shift), maxDepth - 1)
    |; with LAPF convention
    PUSH(R4) PUSH(R3) PUSH(R2) PUSH(R1) 
    CALL(drawFractal, 4)
    

drawFractal_end:
    
    |; Cleaning the stack
    POP(R6) POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)
    POP(BP) POP(LP)
    RTN()

