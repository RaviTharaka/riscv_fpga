#include <stdio.h>
 
int main () {

   int n[ 10 ];
   int i;
	 //int j;
 
        
   for ( i = 0; i < 10; i++ ) {
      n[ i ] = i;
	*(int*)0x11FF8  = n[ i ];
   }
   

   //for (j = 0; j < 10; j++ ) {
   //   printf("Element[%d] = %d\n", j, n[j] );
   //}

	while(1){}
 
   return 0;
}
