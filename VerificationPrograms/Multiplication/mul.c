#include <stdio.h>

int main(){
	int a = 11;
	int b = 14;
	*(int*)0x11FF8 = a*b;

	while(1){}

	return 0;
}
