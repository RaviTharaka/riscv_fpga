#include <stdio.h>
#include <stdlib.h>



int main(){
    int i,j;
	//int k;
    int sampleCount = 100;
    int kernelCount = 5;
	int address = 0x10370;
	int tem=0;
	int tempAddress = 0;

    int y=0 ;
    int h[5] = {1,2,3,2,1};
    for ( i = 0; i < sampleCount-4; i++ ){
        y = 0;
		tempAddress = address+ (4*i); 
	//temp = *(int*)address;                      // set to zero before sum
        for ( j = 0; j < kernelCount; j++ ){
			tem = *(int*)(tempAddress + (4*j));
            y += tem * h[j];    // convolve: multiply and accumulate
        }
		*(int*)0x11FF8 = y;
    }

	//for(k=0;k<sampleCount;k++){
	//	*(int*)0x11FF8 = y[k];
		//printf("%d, ",y[k]);
	//}

    while(1){}
    return 0;

}


