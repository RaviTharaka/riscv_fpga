#include <stdio.h>

int main(){

	int temp;
	int address = 0x10370;
	int i;


	int sum=0;
	for(i=0;i<100;i++){
		temp = *(int*)address;
		sum+=temp;
		address+=0x04;
	}
	*(int*)0x11FF8 = sum;

	int min=20000;
	address = 0x10370;
	for(i=0;i<100;i++){
		temp = *(int*)address;
		if(temp < min){
			min = temp;
		}
		address+=0x04;
	}
	*(int*)0x11FF8 = min;

	int max=0;
	address = 0x10370;
	for(i=0;i<100;i++){
		temp = *(int*)address;
		if(temp > max){
			max = temp;
		}
		address+=0x04;
	}
	*(int*)0x11FF8 = max;


	address = 0x10370;
	int his0 = 0, his1 = 0;
	for(i=0;i<100;i++){
		temp = *(int*)address;
		if(0<=temp && temp<5000){
			his0++;
		}
		if(5000<=temp && temp<10000){
			his1++;
		}
		address+=0x04;
	}
	*(int*)0x11FF8 = his0;
	*(int*)0x11FF8 = his1;

	while(1){}
return 0;

}
