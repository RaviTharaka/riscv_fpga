#include <stdio.h>

int main(){

	//int *p = (int *) u;
	int temp;
	int address = 0x10370;
	int i,min=20000,max=0,median=0,sum=0, average=0;
	int his0 = 0, his1 = 0, his2 = 0, his3 = 0, his4 = 0;
	int his5 = 0, his6 = 0, his7 = 0, his8 = 0, his9 = 0;
	//temp *p;
	//temp = *(int*)address;
	//address+=0x04;
	//temp = *(int*)address;

	for(i=0;i<1000;i++){
		temp = *(int*)address;
		sum+=temp;
		if(temp < min){
			min = temp;
		}

		if(temp > max){
			max = temp;
		}
		if(i = 500){
			median = temp;
		}

		if(0<=i && i<100){
			his0++;
		}
		if(100<=i && i<200){
			his1++;
		}
		if(200<=i && i<300){
			his2++;
		}
		if(300<=i && i<400){
			his3++;
		}
		if(400<=i && i<500){
			his4++;
		}
		if(500<=i && i<600){
			his5++;
		}
		if(600<=i && i<700){
			his6++;
		}
		if(700<=i && i<800){
			his7++;
		}
		if(800<=i && i<900){
			his8++;
		}
		if(900<=i && i<=1000){
			his9++;
		}

		address+=0x04;
	}
	

	*(int*)0x11FF8 = min;
	*(int*)0x11FF8 = max;
	*(int*)0x11FF8 = median;
	*(int*)0x11FF8 = sum;

	*(int*)0x11FF8 = his0;
	*(int*)0x11FF8 = his1;
	*(int*)0x11FF8 = his2;
	*(int*)0x11FF8 = his3;
	*(int*)0x11FF8 = his4;
	*(int*)0x11FF8 = his5;
	*(int*)0x11FF8 = his6;
	*(int*)0x11FF8 = his7;
	*(int*)0x11FF8 = his8;
	*(int*)0x11FF8 = his9;

	
	while(1){}
	return 0;
}
