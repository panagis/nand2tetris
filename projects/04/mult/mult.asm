// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies the registers R0 and R1 and stores the result in the R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Given the fact that the exercise doesn't specifies if the values of the R0 and R1 RAM registers are costants or not,
// I considered them as non constants for optimization reasons.

    // R2 = 0
    @R2
    M=0
    
    // if (R1 == 0) go to @END;
    @R1
    D=M
    @END
    D;JEQ
(LOOP)
    // if (R0 == 0) go to @END;
    // R0 = R0 - 1;
    @R0
    D=M
    M=M-1
    @END
    D;JEQ

    // R2 = R2 + R1
    @R1
    D=M
    @R2
    M=M+D

    // go to @LOOP
    @LOOP
    0;JMP
(END)
    // go to @END
    @END
    0;JMP