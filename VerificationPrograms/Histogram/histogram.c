#include <stdio.h>

int main(){

	int temp=0;
	int i;
	int sum=0;
	int max=0;
	int min=20000;
int his0=0, his1=0;

	FILE* file = fopen ("data.txt", "r");


	for(i=0;i<100;i++){
		fscanf (file, "%d", &temp); 
		sum+=temp;
		if(temp < min){
			min = temp;
		}
		if(temp > max){
			max = temp;
		}
		if(0<=temp && temp<5000){
			his0++;
		}
		if(5000<=temp && temp<10000){
			his1++;
		}
	}

	printf("sum  %d \n",sum);
	printf("min %d \n",min);
	printf("max %d \n",max);
	printf("his1 %d \n",his0);
	printf("his2 %d \n",his1);

return 0;

}
