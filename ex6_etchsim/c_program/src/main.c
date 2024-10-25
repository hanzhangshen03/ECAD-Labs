void dprint(int value) {
	asm ("csrw	0x800, %0" : : "r" (value) );
}

int myfunction(int x, int y) {
	return x+y;
}

int main(void) {
	// declare some variables
	int x=12, y=34, z;

	z = myfunction(x,y);
	dprint(z);

	return z;
}
