.macro DEBUG_PRINT reg
csrw 0x800, \reg
.endm
	
.text
.global div              # Export the symbol 'div' so we can call it from other files
.type div, @function
div:
    addi sp, sp, -32     # Allocate stack space

    # store any callee-saved register you might overwrite
    sw   ra, 28(sp)      # Function calls would overwrite
    sw   s0, 24(sp)      # If t0-t6 is not enough, can use s0-s11 if I save and restore them
    # ...

    # do your work
    li   t0, 32
    li   t1, 0 # Q
    li   t2, 0 # R
    beq   a1, zero, end
loop:
    addi t0, t0, -1
    blt   t0, zero, end
    slli   t2, t2, 1
    srl   t3, a0, t0
    andi   t3, t3, 1
    or   t2, t2, t3	# R[0] = N[i];
    blt   t2, a1, loop
    sub   t2, t2, a1
    li   t3, 1
    sll   t3, t3, t0
    or t1, t1, t3
    j loop
end:
    mv a0, t1
    mv a1, t2

    # example of printing inputs a0 and a1
    DEBUG_PRINT a0
    DEBUG_PRINT a1

    # load every register you stored above
    lw   ra, 28(sp)
    lw   s0, 24(sp)
    # ...
    addi sp, sp, 32      # Free up stack space
    ret

