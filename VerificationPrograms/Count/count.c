#include <stdio.h>

int main(){
	int i=0;
	int count=0;

	for(i=0;i<10;i++){
	count=i;
	*(int*)0x11FF8 = count;
	//printf("%d", i);
	}

	while(1){}

	return 0;
	
}
