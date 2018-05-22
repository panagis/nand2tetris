// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(READ_KEYBOARD)
    // if (last filled color == white) go to @IS_WHITE
    // else go to @IS_BLACK
    @fillColor
    D=M
    @IS_WHITE
    D;JEQ

    // if (key was pressed) go to @READ_KEYBOARD *** because the screen is already black
    // else go to @FILL_SCREEN
    (IS_BLACK)
    @KBD
    D=M    
    @READ_KEYBOARD
    D;JNE
    @fillColor
    M=0
    @FILL_SCREEN
    0;JMP

    // if (key was not pressed) go to @READ_KEYBOARD *** because the screen is already white
    // else go to @FILSCREN
    (IS_WHITE)
    @KBD
    D=M
    @READ_KEYBOARD
    D;JEQ    
    @fillColor
    M=-1 // -1 in decimal = 1111 1111 1111 1111 in binary in a 16-bit register
    @FILL_SCREEN
    0;JMP

// if (@fillColor == 0) screen becomes white
// else if (@fillColor == -1) screen becomes black
(FILL_SCREEN)
    @SCREEN
    D=A  //  D = base address of the SCREEN's address space
    @i   // @i = a pointer to the base address of the SCREEN's address space
    M=D

    (LOOP)
        @fillColor
        D=M
        @i
        A=M // dereference the @i pointer
        M=D // set the value of the @fillColor variable into the SCREEN's register
        @i
        M = M + 1 // change the @i pointer to point to the next memory location (next RAM register)
        D=M

        @24576 // 24576 is the address of the last register of the SCREEN's address space
               // screen base + screen size = 16384 + 256x512bits/16 = 24576
        D=A-D  // D = 24576 - value (which is an address) of @i pointer
        @LOOP
        D;JGT  // if the last address of the SCREEN's address space is not reached go to @LOOP
        
    @READ_KEYBOARD
    0;JMP