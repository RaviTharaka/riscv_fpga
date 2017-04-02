#include<stdio.h>


int main(){

	int i,j,k;
	int addressA = 0x10370;
	int addressB = 0x10370 + 400;
	int valA,valB;
	int temp;

	for(i=0;i<10;i++){
		for(j=0; j<10;j++){
			temp = 0;
			for(k=0;k<10;k++){
				valA = *(int*)(addressA + (40*i) + (4*k)); 
				valB = *(int*)(addressB + (40*k) + (4*j));
				temp += valA*valB;
			}
			*(int*)0x11FF8 = temp;
		}
	}

	while(1){};
	return 0;
}
