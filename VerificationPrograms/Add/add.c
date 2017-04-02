#include <stdio.h>

int main(){
	int a = 1;
	int b = 2;
	*(int*)0x11FF8 = a+b;

	while(1){}

	return 0;
}
