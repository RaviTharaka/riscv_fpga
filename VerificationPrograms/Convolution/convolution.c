#include <stdio.h>
#include <stdlib.h>



int main(){
    int i,j;
	int k;
    int sampleCount = 9;
    int kernelCount = 3;
    int x[9] = {1,2,3,4,5,6,7,8,9};
    int y[9] ;
    int h[3] = {1,2,1};
    for ( i = 0; i < sampleCount; i++ ){
        y[i] = 0;                       // set to zero before sum
        for ( j = 0; j < kernelCount; j++ ){
			if((i-j)<0){continue;}
            y[i] += x[i - j] * h[j];    // convolve: multiply and accumulate
        }
    }

	for(k=0;k<sampleCount;k++){
		*(int*)0x11FF8 = y[k];
	}

    while(1){}
    return 0;
}
