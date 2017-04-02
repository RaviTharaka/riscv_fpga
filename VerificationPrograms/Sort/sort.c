#include <stdio.h>
#include <stdbool.h>

//#define MAX 10

//int list[MAX] = {1,8,4,6,0,3,5,2,7,9};
int main() {
	//int MAX = 10;
	int list[10] = {1,8,4,6,0,3,5,2,7,9};	
	int temp;
	int i,j,k;
	bool swapped = false; 
	for(i = 0; i < 10-1; i++) { 
		swapped = false;
		for(j = 0; j < 10-1-i; j++) {			
			if(list[j] > list[j+1]) {
				temp = list[j];
				list[j] = list[j+1];
				list[j+1] = temp;
				swapped = true;
			}	
		}
		if(!swapped) {
			break;
		}
	}

	for(k = 0; k < 10-1; k++){
		*(int*)0x11FF8 =list[k];
		//printf("%d\n",list[k]);
	}

	while(1){}
	return 0;	
}
