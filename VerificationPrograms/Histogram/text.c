#include <stdio.h>

int main(){

	//int *p = (int *) u;
	int temp;
	int address = 0x10350;
	int i,min=20000,max=0,median=0,sum=0, average=0;
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
		address+=0x04;
	}
	average = sum/1000;

	while(1){}
	return 0;
}
