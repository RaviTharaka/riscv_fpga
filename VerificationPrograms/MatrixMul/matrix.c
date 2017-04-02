#include<stdio.h>
 
int main() {
   //int a[10][10], b[10][10], c[10][10], 
	int i, j, k;
   int sum = 0;

	int a[1][3]={{1,4,6}};
	int b[3][2]={{2,3},{5,8},{7,9}};
	//int c[1][2];
 

 /*
   //printf("The First Matrix is: \n");
   for (i = 0; i < 1; i++) {
      for (j = 0; j < 3; j++) {
         printf(" %d ", a[i][j]);
      }
      printf("\n");
   }
 
   //printf("The Second Matrix is : \n");
   for (i = 0; i < 3; i++) {
      for (j = 0; j < 2; j++) {
         printf(" %d ", b[i][j]);
      }
      printf("\n");
   }
*/ 
   //Multiplication Logic
   for (i = 0; i < 1; i++) {
      for (j = 0; j < 2; j++) {
         sum = 0;
         for (k = 0; k < 3; k++) {
            sum = sum + a[i][k] * b[k][j];
         }
         //c[i][j] = sum;
		*(int*)0x11FF8 = sum;
      }
   }
/* 
   printf("\nMultiplication Of Two Matrices : \n");
   for (i = 0; i < 1; i++) {
      for (j = 0; j < 2; j++) {
         printf(" %d ", c[i][j]);
      }
      printf("\n");
   }
*/ 
	while(1){}
   return (0);
}
