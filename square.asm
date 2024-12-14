|; drawSquare(xTopLeft, yTopLeft, sideLength)
|; Draw a square on the canvas.
|; @param xTopLeft    the x-coordinate of the top-left corner of the square.
|; @param yTopLeft    the y-coordinate of the top-left corner of the square.
|; @param sideLength  the length of the side of the square (in number of pixels).
drawSquare:
    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5) PUSH(R6) PUSH(R7) PUSH(R8)

    |; Arguments
    LD(BP, -12, R1) |; R1 <- xTopLeft
    LD(BP, -16, R2) |; R2 <- yTopLeft
    LD(BP, -20, R3) |; R3 <- sideLength

    |; Local variables
    SUBC(R3, 1, R3) |; R3 <- sideLength - 1
    ADD(R1, R3, R4) |; xBottomRight (R4) <- xTopLeft (R1) + sideLength - 1 (R3)
    ADD(R2, R3, R5) |; yBottomRight (R5) <- yTopLeft (R2) + sideLength - 1(R3)

    MOVE(R2, R3) |; yCur (R3) <- yTopLeft (R2)

square_loop1:
    CMPLE(R3, R5, R0) |; R0 <- (yCur (R3) <= yBottomRight (R5)) 
    BF(R0, draw_square_end)

    MOVE(R1, R6) |; xCur (R6) <- xTopLeft (R1)

square_loop2:
    CMPLE(R6, R4, R0) |; R0 <- (xCur (R6) <= xBottomRight (R4))
    BF(R0, square_loop2_end)

    |; First binary comparaison
    CMPEQ(R6, R1, R7) |; R0 <- (xCur (R6) == xTopLeft (R1))
    CMPEQ(R6, R4, R8) |; R1 <- (xCur (R6) == xBottomRight (R4))
    OR(R7, R8, R7) |; R0 <- (R0 || R1)

    |; Second binary comparaison
    CMPEQ(R3, R2, R0) |; R0 <- (yCur (R3) == yTopLeft (R2))
    CMPEQ(R3, R5, R7) |; R7 <- (yCur (R3) == yBottomRight (R5))
    OR(R0, R7, R0) |; R1 <- (R1 || R7)

    OR(R0, R7, R0)
    BT(R0, square_canvas)

    |; If this is false, we can continue the current loop
    ADDC(R6, 1, R6) |; xCur++
    BR(square_loop2)

square_canvas:
    |; Last-argument-pushed-first (LAPF) convention
    PUSH(R3) |; yCur
    PUSH(R6) |; xCur
    CALL(canvas_set_to_1)
    ADDC(R6, 1, R6) |; xCur++
    BR(square_loop2)

square_loop2_end:
    ADDC(R3, 1, R3) |; yCur++
    BR(square_loop1)

draw_square_end:
    POP(R8) POP(R7) POP(R6) POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)
    POP(BP) POP(LP)
    RTN()
