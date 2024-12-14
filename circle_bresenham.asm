|; drawCircleBres(xc, yc, radius)
|; Draw a circle using Bresenham's algorithm.
|;  @param xc      the x-coordinate of the center of the circle.
|;  @param yc      the y-coordinate of the center of the circle.
|;  @param radius  the radius of the circle.
|;  @return        the x coordinate, using the center of the circle as origin,
|;                 of the last pixel placed (on one of the top right "octant"),
|;                 i.e. the top right pixel of the circle.
drawCircleBres:

    |; Initialize the stack
    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    |; Save registers
    PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5)

    |; Arguments
    LD(BP, -12, R1) |; R1 <- xc
    LD(BP, -16, R2) |; R2 <- yc
    LD(BP, -20, R3) |; R3 <- radius

    |; Local variables
    MULC(R3, 2, R0) |; R0 <- 2 * radius (R3)
    CMOVE(3, R4)    |; R4 <- 3
    SUBC(R4, R0, R4)|; decisionVar (R4) <- 3 - (2 * radius)

    MOVE(R31, R5) |; circleX (R5) <- 0 (R31)
    
    |; For circleY, I just reuse the value of radius (R3)

circle_loop:

    |; circleX <= circleY
    CMPLE(R5, R3, R0)
    BF(R0, drawCircleBres_end)

    |; Last-argument-pushed-first (LAPF) convention
    PUSH(R3) PUSH(R5) PUSH(R2) PUSH(R1)
    CALL(placeCirclePixels, 4)

    |; decisionVar (R4) > 0 (R31)
    CMPLT(R31, R4, R0)
    BT(R0, decisionVar_greater_than_0)

    |; R0 <- 4 * circleX + 6
    MULC(R5, 4, R0)
    ADDC(R0, 6, R0)

    ADD(R4, R0, R4)

    BR(circle_loop_end)

decisionVar_greater_than_0:

    |; R0 <- 4 * (circleX - circleY) + 10
    SUB(R5, R3, R0)  |; R0 <- circleX (R5) - circleY (R3)
    MULC(R0, 4, R0)  |; R0 <- 4 * R0
    ADDC(R0, 10, R0) |; R0 <- R0 + 10

    ADD(R4, R0, R4) |; decisionVar (R4) += R0

    SUBC(R3, 1, R3) |; circleY--

circle_loop_end:

    ADDC(R5, 1, R5)
    BR(circle_loop)

drawCircleBres_end:

    |; Return value
    SUBC(R5, 1, R0) |; R0 <- circleX (R5) - 1

    |; Cleaning the stack
    POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)
    POP(BP) POP(LP)

    |; Return
    RTN()

|; placeCirclePixels(xc, yc, circleX, circleY)
|; Place the current pixels of the circle using symmetry.
|; @param xc       the x-coordinate of the center of the circle.
|; @param yc       the y-coordinate of the center of the circle.
|; @param circleX  the x-coordinate of the current pixel to place, using the center of the circle as origin.
|; @param circleY  the y-coordinate of the current pixel to place, using the center of the circle as origin.
placeCirclePixels:

    PUSH(LP) PUSH(BP)
    MOVE(SP, BP)

    PUSH(R1) PUSH(R2) PUSH(R3) PUSH(R4) PUSH(R5)

    LD(BP, -12, R1) |; xc
    LD(BP, -16, R2) |; yc
    LD(BP, -20, R3) |; circleX
    LD(BP, -24, R4) |; circleY

    ADD(R1, R3, R5) |; xc + circleX
    ADD(R2, R4, R0) |; yc + circleY
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    SUB(R1, R3, R5) |; xc - circleX
    ADD(R2, R4, R0) |; yc + circleY
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    ADD(R1, R3, R5) |; xc + circleX
    SUB(R2, R4, R0) |; yc - circleY
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    SUB(R1, R3, R5) |; xc - circleX
    SUB(R2, R4, R0) |; yc + circleY
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    ADD(R1, R4, R5) |; xc + circleY
    ADD(R2, R3, R0) |; yc + circleX
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    SUB(R1, R4, R5) |; xc - circleY
    ADD(R2, R3, R0) |; yc + circleX
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    ADD(R1, R4, R5) |; xc + circleY
    SUB(R2, R3, R0) |; yc - circleX
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    SUB(R1, R4, R5) |; xc - circleY
    SUB(R2, R3, R0) |; yc - circleX
    PUSH(R0) PUSH(R5)
    CALL(canvas_set_to_1, 2)

    POP(R5) POP(R4) POP(R3) POP(R2) POP(R1)

    POP(BP) POP(LP)

    RTN()
