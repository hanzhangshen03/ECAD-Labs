# RISC-V baremetal init.s
# This code is executed first.

.section .text.init;
.global _start;
_start:
    la   sp, __sp-4      # Set up the stack pointer, using a constant defined in the linker script.
    la   t0, trap_vector
    csrw mtvec, t0       # Catch any exceptions

    call main
    j    _end

trap_vector:
    # test whether the trap came from ecall
    csrr  t5, mcause
    li    t6, 0xb        # 0xb == CAUSE_MACHINE_ECALL (Environment call from M-mode)
    bne   t5, t6, _error

    li    a0, 0x0        # Came from ecall (div by 0)
    li    a1, 0x0
    csrr  t6, mepc
    addi  t6, t6, 4
    csrw  mepc, t6
    mret

_error:
    li    a0, -0x1

_end:
    slli  t0, a0, 1
    ori   t0, t0, 1
    la    t1, tohost
    sw    t0, 0(t1)
loop:
    j     loop           # Loop when finished while waiting to be killed.


.data
tohost: .dword 0;
fromhost: .dword 0;
