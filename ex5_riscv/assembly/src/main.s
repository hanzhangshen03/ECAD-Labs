.macro DEBUG_PRINT reg
csrw 0x800, \reg
.endm
	
.text
.global main              # Export the symbol 'main' so we can call it from other files
.type main, @function
main:
    addi sp, sp, -32     # Allocate stack space

    # store on the stack any callee-saved register you might overwrite
    sw   ra, 28(sp)      # Function calls would overwrite


# *** Do some work ***
#    addi a2, zero, 0x123 # a2 := 0x123
#    # example of printing value of register a2 
#    DEBUG_PRINT a2
     addi    a0, zero, 12    # a0 <- 12
     addi    a1, zero, 4     # a1 <- 4
     call    div
     DEBUG_PRINT a0          # display the quotient
     DEBUG_PRINT a1          # display the remainder

     addi    a0, zero, 93    # a0 <- 93
     addi    a1, zero, 7     # a1 <- 7
     call    div
     DEBUG_PRINT a0          # display the quotient
     DEBUG_PRINT a1          # display the remainder

     lui     a0, (0x12345000>>12)
     addi    a0, a0, 0x678   # a0 <- 0x12345678
     # we could also use the pseudo-instruction 'li a0, 0x12345678'
     # which will assemble to the above two instructions
     addi    a1, zero, 255   # a1 <- 255
     call    div
     DEBUG_PRINT a0          # display the quotient
     DEBUG_PRINT a1          # display the remainder
# *** End useful work ***


    # A function's return value is stored in a0
    # on exit. The simulator environment
    # regards a return value of 0 as 'success',
    # so return that as we don't have errors to
    # report
    addi a0, zero, 0 

    # load from the stack every register you stored above
    lw   ra, 28(sp)

    addi sp, sp, 32      # Free up stack space
    ret

