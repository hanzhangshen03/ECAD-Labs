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

int add_bcd(int time, int x, int shift) {
	while (x) {
		time += mod(x, 10) << shift;
		shift += 4;
		x = div(x, 10);
	}
	return time;
}

void hex_output(int value)
{
	int *hex_leds = (int *) 0x04000080;  // define a pointer to the register
	*hex_leds = value;                   // write the value to that address
}

int main(void) {
	while (1) {
  	  int ticks = get_time();
	  int centiseconds = div(mod(ticks, 1000), 10);
	  int seconds = div(mod(ticks, 60000), 1000);
	  int minutes = div(ticks, 60000);
	  int time = 0;
	  time = add_bcd(time, centiseconds, 0);
	  time = add_bcd(time, seconds, 8);
	  time = add_bcd(time, minutes, 16);
	  // dprint(time);
	  hex_output(time);
	}


	return 0;
}
