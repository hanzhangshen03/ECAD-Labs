#include "asmfunctions.h"

/* some debugging printouts */
void dprint(int value) {
	asm ("csrw	0x800, %0" : : "r" (value) );
}
/* these only work in Spike */
void dprint_str(char* str) {
	while (*str) asm ("csrw	0x801, %0" : : "r" (*str++) );
}
void dprint_int(int value) {
	asm ("csrw	0x802, %0" : : "r" (value) );
}



int main(void) {
	/* your C code goes here */
	dprint(0xC0FFEE);

	return 0;
}
