#include <stdio.h>
#include <stdbool.h>

#define MAX 10

int list[MAX] = {1,8,4,6,0,3,5,2,7,9};
int main() {	
   int temp;
   int i,j,k;
   bool swapped = false; 
   for(i = 0; i < MAX-1; i++) { 
      swapped = false;
      for(j = 0; j < MAX-1-i; j++) {			
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

	for(k = 0; k < MAX-1; k++){
		*(int*)0x10150 =list[k];
	}

	while(1){}
	return 0;	
}
