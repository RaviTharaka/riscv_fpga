#include <stdio.h>

int main(){

	int temp=0;
	int i;
	int sum=0;
	int max=0;
	int min=20000;
int his0=0, his1=0,his2=0,his3=0,his4=0;

	FILE* file = fopen ("data.txt", "r");


	for(i=0;i<1000;i++){
		fscanf (file, "%d", &temp); 
		sum+=temp;
		if(temp < min){
			min = temp;
		}
		if(temp > max){
			max = temp;
		}
		if(0<=temp && temp<2000){
			his0++;
		}
		if(2000<=temp && temp<4000){
			his1++;
		}
		if(4000<=temp && temp<6000){
			his2++;
		}
		if(6000<=temp && temp<8000){
			his3++;
		}
		if(8000<=temp && temp<10000){
			his4++;
		}
	}

	printf("sum  %d \n",sum);
	printf("min %d \n",min);
	printf("max %d \n",max);
	printf("his0 %d \n",his0);
	printf("his1 %d \n",his1);
	printf("his2 %d \n",his2);
	printf("his3 %d \n",his3);
	printf("his4 %d \n",his4);

return 0;

}
