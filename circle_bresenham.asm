|; drawCircleBres(xc, yc, radius)
|; Draw a circle using Bresenham's algorithm.
|;  @param xc      the x-coordinate of the center of the circle.
|;  @param yc      the y-coordinate of the center of the circle.
|;  @param radius  the radius of the circle.
|;  @return        the x coordinate, using the center of the circle as origin,
|;                 of the last pixel placed (on one of the top right "octant"),
|;                 i.e. the top right pixel of the circle.
drawCircleBres:

    |; Place your code here


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
