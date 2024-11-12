# hs866 answers to ECAD Tick
## Question 1
In the best case, the denominator is 0. The program runs for 7 instructions to setup and check the denominator, jumps to end, and runs for 8 instructions to assign the results, print debug output, load word, and return. So 15 instructions in total.

In the worst case, the branches are never taken until all the bits are processed. So the program needs 7 instructions to setup, 12 instructions for each of the bit, 2 more instructions to decrement the iterator to -1 and take the branch to end the loop, and 8 instructions to assign the results, print debug output, load word, and return. So in total there are 7 + 12 * 32 + 2 + 8 = 401 instructions.

## Question 2
The factors are whether the denominator is zero or whether the branches are taken in the loop.

## Question 3
The pipeline might have a control hazard so that it flushes some instructions and stalls for a few cycles.

